//
//  CommonUserFunctions.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class CommonFunction{
    static let shared = CommonFunction()
    fileprivate var currentVC: UIViewController?
    
    func getCurrentViewContoller(Target vc: UIViewController){ currentVC = vc }
    
    func dataToBase64(data:NSData)->String{
        let result = data.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return result;
    }
    
    func dataToBase64(data: Data)->String {
        let result = data.base64EncodedString()
        return result
    }
    
    func byteArrayToBase64(data:[UInt])->String{
        let nsdata = NSData(bytes: data, length: data.count)
        let data  = Data.init(referencing: nsdata)
        if let str = String.init(data: data, encoding: String.Encoding.utf8){
            return str
        }
        return "";
    }
    
    func timeToString(date:Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func dateToString(date:Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func base64ToByteArray(base64String: String) -> [UInt8] {
        let data = Data.init(base64Encoded: base64String)
        let dataCount = data!.count
        var bytes = [UInt8].init(repeating: 0, count: dataCount)
        data!.copyBytes(to: &bytes, count: dataCount)
        return bytes
    }
    
    func stringFromXMLString(xmlToParse:String)->String {
        do{
            let xml = SWXMLHash.lazy(xmlToParse)
            let xmlResponse : XMLIndexer? = xml.children.first?.children.first?.children.first
            let xmlResult: XMLIndexer?  = xmlResponse?.children.last
            
            let xmlElement = xmlResult?.element
            let _ = xmlElement?.text
            if let child = xmlElement?.children{
                if !child.isEmpty{
                    if let xmlElementFirst = xmlElement?.children[0] as? TextElement{
                        return xmlElementFirst.text
                    }
                }
            }
        }
        return ""
    }
    
    func stringFromXML(data:Data)-> String{
        let xmlToParse: String? = String.init(data: data, encoding: String.Encoding.utf8)
        if xmlToParse == nil {
            return ""
        }
        if let xmlToParse = xmlToParse{
            if xmlToParse.count == 0 {
                return ""
            }
        }
        let  stringVal = stringFromXMLString(xmlToParse:  xmlToParse!)
        return stringVal
    }
    
    func stringArrFromXMLString(xmlToParse :String)->[String?]{
        let xml = SWXMLHash.lazy(xmlToParse)
        let xmlRoot = xml.children.first
        let xmlBody = xmlRoot?.children.last
        let xmlResponse: XMLIndexer? =  xmlBody?.children.first
        let xmlResult: XMLIndexer?  = xmlResponse?.children.last
        
        var strList = [String?]()
        let childs = xmlResult!.children
        for child in childs {
            let text = child.element?.text
            strList.append(text)
        }
        return strList
    }
    
    func stringArrFromXML(data:Data)->[String?]{
        let xmlToParse: String? = String.init(data: data, encoding: String.Encoding.utf8)
        if xmlToParse == nil {
            return [String?]()
        }
        if let xmlToParse = xmlToParse{
            if xmlToParse.count == 0 {
                return [String?]()
            }
        }
        let  stringVal = stringArrFromXMLString(xmlToParse:  xmlToParse!)
        return stringVal
    }
    
    func byteArrayToBase64(bytes: [UInt8]) -> String {
        let data = Data.init(bytes: bytes)
        let base64Encoded = data.base64EncodedString()
        return base64Encoded;
    }
    
    func base64ToByteArray(base64String: String) -> [UInt8]? {
        if let data = Data.init(base64Encoded: base64String){
            var bytes = [UInt8](repeating: 0, count: data.count)
            data.copyBytes(to: &bytes, count: data.count)
            return bytes;
        }
        return nil // Invalid input
    }
    
    func getStrValue(elem1: XMLElement?) -> String{
        var strVal = ""
        if elem1?.children.first is TextElement {
            for elem in (elem1?.children)!{
                if let elemText: TextElement = elem as? TextElement{
                    strVal += elemText.text
                }
            }
        }
        return strVal
    }
    
    func ArrValues(data: Data, reSet: (() -> Void), getValue: @escaping ((_ elementName: String, _ value: String) -> AnyObject)) -> [AnyObject] {
        if let xmlToParse = String.init(data: data, encoding: String.Encoding.utf8){
            let xml = SWXMLHash.lazy(xmlToParse)
            let xmlRoot = xml.children.first
            _ = xmlRoot?.children.last
            let xmlResponse: XMLIndexer? = xml.children.first?.children.first?.children.first
            let xmlResult0: XMLIndexer?  = xmlResponse?.children.last
            var strVal = ""
            var elemName = ""
            var returnValue: [AnyObject] = [AnyObject]()
            if elemName == "" {
                if let itemCount1: Int = (xmlResult0?.children.count){
                    for i1 in 0 ..< itemCount1 {
                        var rItem1: AnyObject?
                        let xmlResult_Parent1: XMLIndexer? = xmlResult0?.children[i1]
                        let childCount1: Int = (xmlResult_Parent1?.children.count)!
                        reSet()
                        for j1 in 0 ..< childCount1 {
                            let xmlResult1: XMLIndexer? =  xmlResult_Parent1?.children[j1]
                            let elem1: XMLElement? =  xmlResult1?.element
                            strVal = getStrValue(elem1: elem1)
                            if let element = elem1{
                                elemName = element.name
                                rItem1 = getValue(elemName, strVal)
                            }
                        }
                        if let rItem1 = rItem1{
                            returnValue.append(rItem1)
                        }
                    }
                }
            }
            return returnValue
        } else { showWarningAlert() }
        return [AnyObject]()
    }
    
    func Values(data: Data, reSet: (() -> Void), getValue: @escaping ((_ elementName: String, _ value: String) -> AnyObject)) -> AnyObject? {
        if let xmlToParse = String.init(data: data, encoding: String.Encoding.utf8){
            let xml = SWXMLHash.lazy(xmlToParse)
            let xmlRoot = xml.children.first
            _ = xmlRoot?.children.last
            let xmlResponse: XMLIndexer? = xml.children.first?.children.first?.children.first
            let xmlResult0: XMLIndexer?  = xmlResponse?.children.last
            var strVal = ""
            var elemName = ""
            var returnValue: AnyObject?
            reSet()
            
            if elemName == "" {
                if let itemCount1: Int = (xmlResult0?.children.count){
                    for i1 in 0 ..< itemCount1 {
                        let xmlResult1: XMLIndexer? =  xmlResult0?.children[i1]
                        let elem1: XMLElement? =  xmlResult1?.element
                        
                        strVal = getStrValue(elem1: elem1)
                        if let element = elem1{
                            elemName = element.name
                            returnValue = getValue(elemName, strVal)
                        }
                    }
                }
            }
            return returnValue
        } else { showWarningAlert() }
        return nil
    }
    
    func showWarningAlert(){
        if let currentVC = currentVC{
            AlertMessage().showAlertMessage(alertTitle: "Alert",
                                            alertMessage: "No data receive, please try again",
                                            actionTitle: "OK", onAction: {
                                                moveTo(storyboard: "Home", withIdentifier: "homeViewControllerNav", viewController: currentVC)
            }, cancelAction: nil, currentVC)
        } else { print("Current view contoller is nil") }
        return
    }
    
}
