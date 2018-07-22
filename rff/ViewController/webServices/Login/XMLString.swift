//
//  XMLString.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 21/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

//import Foundation
//class XMLString<T>{
//    var returnValueBlock: ((String, T, String) -> T)?
//
//    public func Task_InboxArrFromXMLString(xmlToParse:String) -> [T] {
//        let xml = SWXMLHash.lazy(xmlToParse)
//        let xmlRoot = xml.children.first
//        let xmlBody = xmlRoot?.children.last
//        let xmlResponse: XMLIndexer? = xml.children.first?.children.first?.children.first
//        let xmlResult0: XMLIndexer?  = xmlResponse?.children.last
//        var strVal = ""
//        var elemName = ""
//        let rItem1: T
//        var returnItemReceived: T
//        var returnValue:[T] = [T]()
//        if elemName == "" {
//            // Array Property For returnValue
//            if let itemCount1: Int = (xmlResult0?.children.count){
//                for i1 in 0 ..< itemCount1 {
//
//                    let xmlResult_Parent1:XMLIndexer? = xmlResult0?.children[i1]
//                    if let childCount1 :Int = (xmlResult_Parent1?.children.count){
//                        for j1 in 0 ..< childCount1 {
//                            let xmlResult1: XMLIndexer? =  xmlResult_Parent1?.children[j1]
//                            let elem1: XMLElement? =  xmlResult1?.element
//                            strVal = ""
//                            if elem1?.children.first is TextElement {
//                                if let childern = elem1?.children{
//                                    for elem in childern{
//                                        let elemText:TextElement = elem as! TextElement
//                                        strVal += elemText.text
//                                    }
//                                }
//                            }
//                            elemName = elem1!.name
//                            if let returnItem = returnValueBlock?(elemName, rItem1, strVal){
//                                returnItemReceived = returnItem
//                            }
//                        }
//                    }
//                    returnValue.append(returnItemReceived)
//                }
//            }
//        }
//        return returnValue
//    }
//}
