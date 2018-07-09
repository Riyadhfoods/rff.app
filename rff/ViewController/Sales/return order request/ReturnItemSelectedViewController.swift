//
//  ReturnItemSelectedViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 28/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class FileModul {
    var image: UIImage?
    var imageName: String?
    var imageBytesArray: Data?
    var imageUrl: URL?
    
    var filePath: URL?
    var fileName: String?
    var filePathBytesArray: Data?
    
    init(image: UIImage, imageName: String, imageBytesArray: Data, imageUrl: URL){
        self.image  = image
        self.imageName = imageName
        self.imageBytesArray = imageBytesArray
        self.imageUrl = imageUrl
    }
    
    init(filePath: URL, fileName: String, filePathBytesArray: Data){
        self.filePath = filePath
        self.fileName = fileName
        self.filePathBytesArray = filePathBytesArray
    }
}

var fileInfo = [FileModul]()

class ReturnItemSelectedViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var uploadFileOutlet: UIButton!
    @IBOutlet weak var showFilesOutlet: UIButton!
    
    // -- MARK: Variables
    
    let cellId = "cell_items"
    let webservice = Sales()
    var isAttachmentError = false
    var isSendingError = false
    var sendResultError = ""
    var attachmentError = ""
    var returnId = ""
    var attachmentName = ""
    var attachmentContent = ""
    var action: (() -> Void)?
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpButtonBorderView()
        setViewAlignment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Setups
    
    func setUpButtonBorderView(){
        setupButtonBorder(button: uploadFileOutlet)
        setupButtonBorder(button: showFilesOutlet)
    }
    
    func setupButtonBorder(button: UIButton){
        button.layer.borderWidth = 1
        button.layer.borderColor = AppDelegate().mainBackgroundColor.cgColor
    }
    
    // -- MARK: IBActions
    
    @IBAction func uploadFileButtonTapped(_ sender: Any) {
        AttachmentHandler.shared.showAttachmentActionSheet(vc: self)
        AttachmentHandler.shared.imagePickedBlock = { (image, imageName, imageUrl) in
            if let ImageBytes = self.convertImageToBytes(imageReceived: image){
                fileInfo.append(FileModul(image: image, imageName: imageName, imageBytesArray: ImageBytes, imageUrl: imageUrl))
            }
        }
        AttachmentHandler.shared.filePickedBlock = {(filePath) in
            if let filePatBytes = self.convertFilePathToBytes(url: filePath){
                fileInfo.append(FileModul(filePath: filePath, fileName: filePath.lastPathComponent, filePathBytesArray: filePatBytes))
            }
        }
    }
    
    @IBAction func showFileButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showFile", sender: nil)
    }
    
    func convertImageToBytes(imageReceived: UIImage) -> Data?{
        var imageData: Data?
        imageData = UIImageJPEGRepresentation(imageReceived, 1)
        return imageData
    }
    
    func convertFilePathToBytes(url: URL) -> Data?{
        var fileData: Data?
        do {
            fileData = try Data(contentsOf: url)
        } catch let error{
            print(error)
        }
        return fileData
    }
    
    var alertTitle = ""
    var alertMessage = ""
    @IBAction func sendButtonTapped(_ sender: Any) {
        
        checkIfStoreId()
        checkReturnType()
        runBeforeSending()
        runSend()
        //runSaveAttachmentAndValidate()
        handleSendAction()
        
        AlertMessage().showAlertMessage(alertTitle: alertTitle, alertMessage: alertMessage, actionTitle: "OK", onAction: action, cancelAction: nil, self)
    }
    
    func checkIfStoreId(){
        if returnOrderRequestDetails.isStoreArrayNotEmptyAndStoreSelectionEmpty == true {
            AlertMessage().showAlertMessage(alertTitle: "Alert", alertMessage: "You did not select store id", actionTitle: nil, onAction: nil, cancelAction: "Cancel", self)
            return
        }
    }
    
    func checkReturnType(){
        for item in returnOrderRequestDetails.itemsarrayFromWS{
            if item.returnType == "Select Type"{
                AlertMessage().showAlertMessage(
                    alertTitle: "Alert",
                    alertMessage: "You did not select return item for All items",
                    actionTitle: nil,
                    onAction: nil,
                    cancelAction: "OK", self)
                return
            }
        }
    }
    
    func runBeforeSending(){
        for item in returnOrderRequestDetails.itemsarrayFromWS{
            let beforeSendResultArray = webservice.SRR_BEFORESEND_SRR(
                itemid: item.itemNumberFromWS,
                invoicenumber: item.invoiceNumberFromWS,
                quantity: item.qty,
                returnid: returnId,
                rownumber: item.serialNumberFromWS,
                Item_Desc: item.desc,
                unitofmeasure: item.uofm,
                totalcost: item.totalPrice,
                unitprice: item.avgPrice,
                lotnumber: item.expiredDate,
                invoicedate: item.invoiceDateFromWS,
                returntype_grid: item.returnType)
            
            validateBeforeSending(beforeSendResultArray: beforeSendResultArray)
        }
    }
    
    func validateBeforeSending(beforeSendResultArray: [String?]){
        if !beforeSendResultArray.isEmpty{
            if beforeSendResultArray[1] != ""{
                if let alertMessage = beforeSendResultArray[1]{
                    AlertMessage().showAlertMessage(alertTitle: "Alert!", alertMessage: alertMessage , actionTitle: "OK", onAction: {
                        return
                    }, cancelAction: nil, self)
                }
            } else {
                if let returnIdFromBeforeSendResultArray = beforeSendResultArray[0]{
                    returnId = returnIdFromBeforeSendResultArray
                }
            }
        }
    }
    
    func runSend(){
        let sendResultArray = webservice.SRR_SEND_SRR(
            supermarket: returnOrderRequestDetails.supermarket,
            itemtable: !returnOrderRequestDetails.itemsarrayFromWS.isEmpty,
            returnid: returnId,
            customervalue: returnOrderRequestDetails.customerId,
            customertext: returnOrderRequestDetails.customer,
            salespersonvalue: returnOrderRequestDetails.salespersonId,
            salespersontext: returnOrderRequestDetails.salesperson,
            returndate: returnOrderRequestDetails.returnDate,
            emp_no: returnOrderRequestDetails.emp_id,
            comment: returnOrderRequestDetails.comment,
            branchtext: returnOrderRequestDetails.branch,
            companyid: returnOrderRequestDetails.companyId,
            branchvalue: returnOrderRequestDetails.branchId,
            storevalue: returnOrderRequestDetails.store,
            cityvalue: returnOrderRequestDetails.city,
            storesalespersonvalue: returnOrderRequestDetails.salespersonstore,
            merchandiser: returnOrderRequestDetails.merchandiser)
        
        if !sendResultArray.isEmpty{
            if sendResultArray[1] != ""{
                if let error = sendResultArray[1]{
                    sendResultError = error
                    isSendingError = true
                }
            } else { isSendingError = false }
        }
    }
    
    func runSaveAttachmentAndValidate(){
        for file in fileInfo{
            if file.image != nil{
                if let imageName = file.imageName{
                    attachmentName = imageName
                } else if let imageNameFromUrl = file.imageUrl?.lastPathComponent{
                    attachmentName = imageNameFromUrl
                }
                
                if let imageData = file.imageBytesArray{
                    let imageDataString = imageData.base64EncodedString()
                    attachmentContent = imageDataString
                }
            } else {
                if let fileNmae = file.fileName{
                    attachmentName = fileNmae
                }
                
                if let fileData = file.filePathBytesArray{
                    let fileDataString = fileData.base64EncodedString()
                    attachmentContent = fileDataString
                }
            }
            
            let saveAttachmentResault = webservice.SR_SaveAttachment(
                returnid: returnId,
                attachment_name: attachmentName,
                attachment_Content: attachmentContent)
            
            if !saveAttachmentResault.isEmpty{
                attachmentError = saveAttachmentResault
                isAttachmentError = true
            } else { isAttachmentError = false }
        }
    }
    
    func handleSendAction(){
        if isSendingError && isAttachmentError{
            alertTitle = "Alert"
            alertMessage = "Sending Error: \(sendResultError)\nAttachment Error: \(attachmentError)"
            action = {
                return
            }
        } else if isSendingError{
            alertTitle = "Sending Error"
            alertMessage = "\(sendResultError)"
            action = {
                self.successAction()
            }
        } else if isAttachmentError{
            alertTitle = "Attachment Error"
            alertMessage = "\(attachmentError)"
            action = {
                self.successAction()
            }
        } else {
            alertTitle = "Success".localize()
            alertMessage = "Return request sent successfully".localize()
            action = {
                self.successAction()
            }
        }
    }
    
    func successAction(){
        returnOrderRequestDetails.isSendReturnSalesRequestCompleted = true
        fileInfo.removeAll()
        returnOrderRequestDetails.setDefaultValues()
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension ReturnItemSelectedViewController: UITableViewDataSource, UITableViewDelegate{
    // -- MARKK: Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if returnOrderRequestDetails.itemsarrayFromWS.count == 0{
            emptyMessage(message: "No Data", viewController: self, tableView: itemsTableView)
        }
        return returnOrderRequestDetails.itemsarrayFromWS.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ReturnItemSelectedCell{
            
            let item = returnOrderRequestDetails.itemsarrayFromWS[indexPath.row]
            cell.cellIndex = indexPath.row
            
            cell.serialNmuber.text = "\(indexPath.row + 1)"
            cell.itemNumber.text = item.itemNumberFromWS
            cell.invoiceNumber.text = item.invoiceNumberFromWS
            cell.invoiceDate.text = item.invoiceDateFromWS
            cell.desc.text = item.desc
            cell.uofm.text = item.uofm
            cell.qty.text = item.qty
            cell.avePrice.text = item.avgPrice
            cell.totalCost.text = item.totalPrice
            cell.expiredDate.text = item.expiredDate
            cell.returnType.text = item.returnType
            
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(deleteItemTapped(sender:)), for: .touchUpInside)
            
            returnOrderRequestDetails.itemsarrayFromWS[indexPath.row].serialNumberFromWS = indexPath.row + 1
            return cell
        }
        return UITableViewCell()
    }
    
    @objc func deleteItemTapped(sender: UIButton){
        returnOrderRequestDetails.itemsarrayFromWS.remove(at: sender.tag)
        print(returnOrderRequestDetails)
        itemsTableView.reloadData()
    }
}





