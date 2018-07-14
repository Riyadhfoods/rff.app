//
//  HandleReturnOrderPickersActions.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 11/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation
import UIKit

struct InvoicesModel {
    var serialNumber: Int = 0
    var invoiceDate: String = ""
    var invoice: String = ""
    var item: String = ""
    
    init(serialNumber: Int, invoiceDate: String, invoice: String, item: String){
        self.serialNumber = serialNumber
        self.invoiceDate = invoiceDate
        self.invoice = invoice
        self.item = item
    }
}

struct InvoiceItemModel {
    var serialNumberFromWS: Int = 0
    var itemNumberFromWS: String = ""
    var invoiceNumberFromWS: String = ""
    var desc: String = ""
    var uofm: String = ""
    var qty: String = ""
    var avgPrice: String = ""
    var totalPrice: String = ""
    var expiredDate: String = ""
    var invoiceDateFromWS: String = ""
    var returnType: String = ""
    
    init(serialNumberFromWS: Int, itemNumberFromWS: String, invoiceNumberFromWS: String, desc: String, unof: String, qty: String, avgPrice: String, totalPrice: String, expiredDate: String, invoiceDateFromWS: String, returnType: String){
        self.serialNumberFromWS = serialNumberFromWS
        self.itemNumberFromWS = itemNumberFromWS
        self.invoiceNumberFromWS = invoiceNumberFromWS
        self.desc = desc
        self.uofm = unof
        self.qty = qty
        self.avgPrice = avgPrice
        self.totalPrice = totalPrice
        self.expiredDate = expiredDate
        self.invoiceDateFromWS = invoiceDateFromWS
        self.returnType = returnType
    }
}

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

class ROActions{
    static var shared = ROActions()
    let webservice = Sales()
    
    // To set the count the item add to the list
    func setCountForItem(c: Int, button: UIBarButtonItem){
        button.title = "ITEMS".localize() + " (" + "\(c))"
    }
    
    // To set the format of date to show
    func getStringDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    // To covert uiimage to data
    private func convertImageToBytes(imageReceived: UIImage) -> Data?{
        var imageData: Data?
        imageData = UIImageJPEGRepresentation(imageReceived, 1)
        return imageData
    }
    
    // To covert url to data
    private func convertFilePathToBytes(url: URL) -> Data?{
        var fileData: Data?
        do {
            fileData = try Data(contentsOf: url)
        } catch let error{
            print(error)
        }
        return fileData
    }
    
    // To show uimage picker and uiducoment picker
    func handleFilesToShow(target vc: UIViewController){
        AttachmentHandler.shared.showAttachmentActionSheet(vc: vc)
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
}





















