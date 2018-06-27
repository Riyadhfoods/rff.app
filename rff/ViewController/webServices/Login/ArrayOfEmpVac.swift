import Foundation
public class ArrayOfEmpVac{
     public var EmpVacArr : [EmpVac] = [] 
}

public func depVacTicketArrFromXMLString(xmlToParse:String)->[DepVacTicket] {
    
    let xml = SWXMLHash.lazy(xmlToParse)
    let xmlRoot = xml.children.first
    let xmlBody = xmlRoot?.children.last
    let xmlResponse: XMLIndexer? = xml.children.first?.children.first?.children.first
    let xmlResult0: XMLIndexer?  = xmlResponse?.children.last
    var strVal = ""
    var elemName = ""
    var returnValue:[DepVacTicket] = [DepVacTicket]()
    if elemName == "" {
        // Array Property For returnValue
        let itemCount1: Int = (xmlResult0?.children.count)!
        for i1 in 0 ..< itemCount1 {
            let rItem1 = DepVacTicket()
            let xmlResult_Parent1:XMLIndexer? = xmlResult0?.children[i1]
            let childCount1 :Int = (xmlResult_Parent1?.children.count)!
            for j1 in 0 ..< childCount1 {
                
                let xmlResult1: XMLIndexer? =  xmlResult_Parent1?.children[j1]
                let elem1: XMLElement? =  xmlResult1?.element
                strVal = ""
                if elem1?.children.first is TextElement {
                    let elemText:TextElement = elem1?.children.first as! TextElement
                    strVal = elemText.text
                    
                }
                elemName = elem1!.name
                // Array Propert of returnValue subProperty for rItem1
                if elemName == "RequireVisa" {
                    rItem1.RequireVisa = strVal.toInt()!
                }
                    // Array Propert of returnValue subProperty for rItem1
                else if elemName == "Ticket" {
                    rItem1.Ticket =  strVal
                }
                    // Array Propert of returnValue subProperty for rItem1
                else if elemName == "DependentName" {
                    rItem1.DependentName =  strVal
                }
                    // Array Propert of returnValue subProperty for rItem1
                else if elemName == "BirthDate" {
                    rItem1.BirthDate =  strVal
                }
                    // Array Propert of returnValue subProperty for rItem1
                else if elemName == "Age" {
                    rItem1.Age =  strVal
                }
                
            }
            returnValue.append(rItem1)
            
        }
    }
    return returnValue
}
public func depVacTicketArrFromXML(data: Data)-> [DepVacTicket] {
    let xmlToParse   = String.init(data: data, encoding: String.Encoding.utf8)!
    return depVacTicketArrFromXMLString( xmlToParse : xmlToParse)
}
