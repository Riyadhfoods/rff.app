//
//  XMLString.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class SuperT{
    required init(){
    }
}

class XMLString<T: SuperT>{
    var returnValueBlock: ((String, String) -> T)?
    
    func arrayFromXMLString(xmlToParse:String, type: T.Type) -> [T]{
        
        let xml = SWXMLHash.lazy(xmlToParse)
        let xmlRoot = xml.children.first
        _ = xmlRoot?.children.last
        let xmlResponse: XMLIndexer? = xml.children.first?.children.first?.children.first
        let xmlResult0: XMLIndexer?  = xmlResponse?.children.last
        var strVal = ""
        var elemName = ""
        var returnValue:[T] = [T]()
        
        if elemName == "" {
            // Array Property For returnValue
            if let itemCount1: Int = (xmlResult0?.children.count){
                for i1 in 0 ..< itemCount1 {
                    var rItem1 = type.init()
                    let xmlResult_Parent1:XMLIndexer? = xmlResult0?.children[i1]
                    let childCount1 :Int = (xmlResult_Parent1?.children.count)!
                    for j1 in 0 ..< childCount1 {
                        
                        let xmlResult1: XMLIndexer? =  xmlResult_Parent1?.children[j1]
                        let elem1: XMLElement? =  xmlResult1?.element
                        strVal = ""
                        if elem1?.children.first is TextElement {
                            for elem in (elem1?.children)!{
                                if let elemText: TextElement = elem as? TextElement{
                                    strVal += elemText.text
                                }
                            }
                        }
                        
                        if let element = elem1{
                            elemName = element.name
                            if let returnItem = returnValueBlock?(elemName, strVal) {
                                rItem1 = returnItem
                            }
                        }
                    }
                    returnValue.append(rItem1)
                }
            }
        }
        
        return returnValue
    }
    
}
