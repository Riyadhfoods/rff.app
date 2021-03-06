//
//  SalesReturnApprovalViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SalesReturnApprovalViewController: UIViewController, ApprovalConfomationDelegate {
    
    // -- MARK: IBOutlets
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var salesReturnTableview: UITableView!
    @IBOutlet weak var aiContainer: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // -- MARK: Variables
    
    let cellId = "cell_salesReturnApproval"
    let screenSize = AppDelegate.shared.screenSize
    let webService = SalesReturnApproveService.instance
    var salesReturnDetails: [SalesReturnApproveModul] = [SalesReturnApproveModul]()
    var rowIndexSelected = 0
    var isApproved = false
    var isRejected = false
    
    func returnRequestStatus(isApproved: Bool) {
        self.isApproved = isApproved
    }
    func returnRequestStatus(isRejected: Bool) {
        self.isRejected = isRejected
    }
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        start()
        setCustomNavAndBackButton(navItem: navigationItem, title: "Sales Return Approval".localize(), backTitle: "Return".localize())
        setViewAlignment()
        setSlideMenu(controller: self, menuButton: menuBtn)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        CommonFunction.shared.getCurrentViewContoller(Target: self)
        if salesReturnDetails.isEmpty || isApproved || isRejected{
            getSalesReturnDetails()
        }
        stop()
    }
    
    func getSalesReturnDetails(){
        salesReturnDetails = webService.SRO_BindOrder(empno: AuthServices.currentUserId)
        salesReturnTableview.reloadData()
    }
    
    func start(){startLoader(superView: aiContainer, activityIndicator: activityIndicator)}
    func stop(){stopLoader(superView: aiContainer, activityIndicator: activityIndicator)}
    
}

extension SalesReturnApprovalViewController: UITableViewDataSource, UITableViewDelegate{
    // -- MARK: Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyMessage(viewController: self, tableView: salesReturnTableview, isEmpty: salesReturnDetails.isEmpty)
        return salesReturnDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SalesReturnApprovalCellCell{
            cell.selectButton.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
            
            let salesReturn = salesReturnDetails[indexPath.row]
            let returnId = salesReturn.ReturnID
            let items = salesReturn.Items
            let empCreated = salesReturn.EmpCreated
            let requestDate = salesReturn.ReqDate
            let returnDate =  salesReturn.RetDate
            let comment = salesReturn.Comment
            
            cell.returnId.text = returnId
            cell.items.text = items
            cell.empCreated.text = empCreated
            cell.reqDate.text = requestDate
            cell.rtnDate.text = returnDate
            cell.comment.text = comment  == "" ? AppDelegate.noComment : comment
            cell.selectButton.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
            cell.selectButton.tag = indexPath.row
            
            return cell
        }
        return UITableViewCell()
    }
    
    // -- MARK: objc functions
    
    @objc func selectButtonTapped(sender: UIButton){
        rowIndexSelected = sender.tag
        performSegue(withIdentifier: "showSalesReturnApproval", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSalesReturnApproval"{
            if let vc = segue.destination as? DetailsSalesReturnApprovalViewController {
                vc.returnId = salesReturnDetails[rowIndexSelected].ReturnID
                vc.requestDateString = salesReturnDetails[rowIndexSelected].ReqDate
                vc.returnDateString = salesReturnDetails[rowIndexSelected].RetDate
                vc.delegate = self
            }
        }
    }
}






