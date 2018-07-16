 import Foundation 
 public class Sales {
    public var Url:String = "http://82.118.166.164/ios_hrms/sales.asmx"
    public var Host:String = "82.118.166.164"
    public func dataToBase64(data:NSData)->String{
        
        let result = data.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return result;
    }
    public func dataToBase64(data: Data)->String {
        let result = data.base64EncodedString()
        return result
    }
    public func byteArrayToBase64(data:[UInt])->String{
        let nsdata = NSData(bytes: data, length: data.count)
        let data  = Data.init(referencing: nsdata)
        if let str = String.init(data: data, encoding: String.Encoding.utf8){
            return str
        }
        return "";
    }
    public func timeToString(date:Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    public func dateToString(date:Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    public func base64ToByteArray(base64String: String) -> [UInt8] {
        let data = Data.init(base64Encoded: base64String)
        let dataCount = data!.count
        var bytes = [UInt8].init(repeating: 0, count: dataCount)
        data!.copyBytes(to: &bytes, count: dataCount)
        return bytes
    }
    func stringFromXMLString(xmlToParse:String) -> String {
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
    func stringFromXML(data:Data)-> String
    {
        
        let xmlToParse :String? = String.init(data: data, encoding: String.Encoding.utf8)
        if xmlToParse == nil {
            return ""
        }
        if xmlToParse!.count == 0 {
            return ""
        }
        let  stringVal = stringFromXMLString(xmlToParse:  xmlToParse!)
        return stringVal
        
    }
    func stringArrFromXMLString(xmlToParse :String)->[String?]{
        let xml  = SWXMLHash.lazy(xmlToParse)
        let xmlRoot  = xml.children.first
        let xmlBody = xmlRoot?.children.last
        let xmlResponse : XMLIndexer? =  xmlBody?.children.first
        let xmlResult : XMLIndexer?  = xmlResponse?.children.last
        
        var strList = [String?]()
        let childs = xmlResult!.children
        for child in childs {
            let text = child.element?.text
            strList.append(text)
        }
        
        return strList
    }
    func stringArrFromXML(data:Data)->[String?]{
        let xmlToParse :String? = String.init(data: data, encoding: String.Encoding.utf8)
        if xmlToParse == nil {
            return [String?]()
        }
        if xmlToParse!.count == 0 {
            return [String?]()
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
    
    public func SalesArrFromXMLString(xmlToParse:String)->[SalesModel] {
        
        let xml = SWXMLHash.lazy(xmlToParse)
        let xmlRoot = xml.children.first
        let _ = xmlRoot?.children.last
        let xmlResponse: XMLIndexer? = xml.children.first?.children.first?.children.first
        let xmlResult0: XMLIndexer?  = xmlResponse?.children.last
        var strVal = ""
        var elemName = ""
        var returnValue:[SalesModel] = [SalesModel]()
        if elemName == "" {
            // Array Property For returnValue
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let rItem1 = SalesModel()
                let xmlResult_Parent1:XMLIndexer? = xmlResult0?.children[i1]
                let childCount1 :Int = (xmlResult_Parent1?.children.count)!
                for j1 in 0 ..< childCount1 {
                    
                    let xmlResult1: XMLIndexer? =  xmlResult_Parent1?.children[j1]
                    let elem1: XMLElement? =  xmlResult1?.element
                    strVal = ""
                    if elem1?.children.first is TextElement {
                        for elem in (elem1?.children)!{
                            let elemText:TextElement = elem as! TextElement
                            strVal += elemText.text
                        }
                    }
                    elemName = elem1!.name
                    // Array Propert of returnValue subProperty for rItem1
                    if elemName == "totalrows" {
                        rItem1.totalrows = strVal.toInt()!
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "currentrows" {
                        rItem1.currentrows =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "grid_error" {
                        rItem1.grid_error =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "CustomerStore_StoreId" {
                        rItem1.CustomerStore_StoreId =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "CustomerStore_City" {
                        rItem1.CustomerStore_City =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "CustomerStore_SalesPerson" {
                        rItem1.CustomerStore_SalesPerson =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "CustomerStore_Merchandiser" {
                        rItem1.CustomerStore_Merchandiser =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Approver1" {
                        rItem1.Approver1 =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "App_Retail" {
                        rItem1.App_Retail =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "App_Market" {
                        rItem1.App_Market =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "ApproveandEnterManually_btn" {
                        rItem1.ApproveandEnterManually_btn =  (strVal.lowercased() == "true")
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "App_Export" {
                        rItem1.App_Export =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "U_Comment" {
                        rItem1.U_Comment =  (strVal.lowercased() == "true")
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "App_Diary" {
                        rItem1.App_Diary =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Approver" {
                        rItem1.Approver =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "App_btn_vis" {
                        rItem1.App_btn_vis =  (strVal.lowercased() == "true")
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Rej_btn_vis" {
                        rItem1.Rej_btn_vis =  (strVal.lowercased() == "true")
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Report_btn_vis" {
                        rItem1.Report_btn_vis =  (strVal.lowercased() == "true")
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Savetogp_btn_vis" {
                        rItem1.Savetogp_btn_vis =  (strVal.lowercased() == "true")
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Loc_control_vis" {
                        rItem1.Loc_control_vis =  (strVal.lowercased() == "true")
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "DocId_control_vis" {
                        rItem1.DocId_control_vis =  (strVal.lowercased() == "true")
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "DocumentId" {
                        rItem1.DocumentId =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SSO_EmployeeCreated" {
                        rItem1.SSO_EmployeeCreated =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SSO_OrderId" {
                        rItem1.SSO_OrderId =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SSO_ReqDate" {
                        rItem1.SSO_ReqDate =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SSO_DeliveryDate" {
                        rItem1.SSO_DeliveryDate =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SSO_ITEMS" {
                        rItem1.SSO_ITEMS =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SSO_CustomerName" {
                        rItem1.SSO_CustomerName =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SSO_Comment" {
                        rItem1.SSO_Comment =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SSO_Status" {
                        rItem1.SSO_Status =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Flag" {
                        rItem1.Flag =  (strVal.lowercased() == "true")
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_SERIALNUMBER" {
                        rItem1.SOA_SERIALNUMBER =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_EMPID" {
                        rItem1.SOA_EMPID =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_NAME" {
                        rItem1.SOA_NAME =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_EMPROLE" {
                        rItem1.SOA_EMPROLE =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_WORKFLOWSTATUS" {
                        rItem1.SOA_WORKFLOWSTATUS =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_TRANSACTIONDATE" {
                        rItem1.SOA_TRANSACTIONDATE =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_EMPNAME" {
                        rItem1.SOA_EMPNAME =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_COMMENT" {
                        rItem1.SOA_COMMENT =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_CUSTOMERID" {
                        rItem1.SOA_CUSTOMERID =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_CUSTOMERNAME" {
                        rItem1.SOA_CUSTOMERNAME =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_CREDITLIMIT" {
                        rItem1.SOA_CREDITLIMIT =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_TOTALDUE" {
                        rItem1.SOA_TOTALDUE =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_ZEROTOTHIRYONEDAYS" {
                        rItem1.SOA_ZEROTOTHIRYONEDAYS =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_THIRYONETOSIXTYDAYS" {
                        rItem1.SOA_THIRYONETOSIXTYDAYS =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_SIXTYONETONINETYDAYS" {
                        rItem1.SOA_SIXTYONETONINETYDAYS =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_NINETYONETOHUNDREDTWENTYDAYS" {
                        rItem1.SOA_NINETYONETOHUNDREDTWENTYDAYS =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_ABOVE120DAYS" {
                        rItem1.SOA_ABOVE120DAYS =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_OrderId" {
                        rItem1.SOA_OrderId =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_STATUS" {
                        rItem1.SOA_STATUS =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_ITEMNUMBER" {
                        rItem1.SOA_ITEMNUMBER =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_ITEMDESC" {
                        rItem1.SOA_ITEMDESC =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_CHANGEDPRICE" {
                        rItem1.SOA_CHANGEDPRICE =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_ORIGINALPRICE" {
                        rItem1.SOA_ORIGINALPRICE =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_QTY" {
                        rItem1.SOA_QTY =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_UNITOFMEASUREMENT" {
                        rItem1.SOA_UNITOFMEASUREMENT =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_LASTYEARORDERQTY" {
                        rItem1.SOA_LASTYEARORDERQTY =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_YEARTODATEORDERQTY" {
                        rItem1.SOA_YEARTODATEORDERQTY =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_TOTAL" {
                        rItem1.SOA_TOTAL =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_REQUESTDATE" {
                        rItem1.SOA_REQUESTDATE =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SOA_DELIVERYDATE" {
                        rItem1.SOA_DELIVERYDATE =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SalesPersonId" {
                        rItem1.SalesPersonId =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "CustomerId" {
                        rItem1.CustomerId =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Merchandiser" {
                        rItem1.Merchandiser =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SalesPersonStore" {
                        rItem1.SalesPersonStore =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "City" {
                        rItem1.City =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "StoreID" {
                        rItem1.StoreID =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "StoreName" {
                        rItem1.StoreName =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "ItemId" {
                        rItem1.ItemId =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Description" {
                        rItem1.Description =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "PCS_CRTN" {
                        rItem1.PCS_CRTN =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Quantity" {
                        rItem1.Quantity =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "UnitPrice" {
                        rItem1.UnitPrice =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "TotalPrice" {
                        rItem1.TotalPrice =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "UnitofMeasure" {
                        rItem1.UnitofMeasure =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "CreditLimit" {
                        rItem1.CreditLimit =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "ToTalDue" {
                        rItem1.ToTalDue =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "ZEROTO31days" {
                        rItem1.ZEROTO31days =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "ThirtyOneTo60Days" {
                        rItem1.ThirtyOneTo60Days =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SIXTYOneTo90Days" {
                        rItem1.SIXTYOneTo90Days =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "NINETYOneTo120Days" {
                        rItem1.NINETYOneTo120Days =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Above120DAYS" {
                        rItem1.Above120DAYS =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "CustomerAgying_Status" {
                        rItem1.CustomerAgying_Status =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "DrpItems" {
                        rItem1.DrpItems =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "DrpItemId" {
                        rItem1.DrpItemId =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Customers" {
                        rItem1.Customers =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SalesPerson" {
                        rItem1.SalesPerson =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "LocationCode" {
                        rItem1.LocationCode =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Comp_ID" {
                        rItem1.Comp_ID =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "EName" {
                        rItem1.EName =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Branch" {
                        rItem1.Branch =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "AccountEmp" {
                        rItem1.AccountEmp =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "OrderID" {
                        rItem1.OrderID =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "ReqDate" {
                        rItem1.ReqDate =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "DeliveryDate" {
                        rItem1.DeliveryDate =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SO_EmpCreated" {
                        rItem1.SO_EmpCreated =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SO_Comment" {
                        rItem1.SO_Comment =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SO_CustomerName" {
                        rItem1.SO_CustomerName =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SO_Items" {
                        rItem1.SO_Items =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SO_Status" {
                        rItem1.SO_Status =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SO_Url" {
                        rItem1.SO_Url =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "ID" {
                        rItem1.ID = strVal.toInt()!
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "EmpCreated" {
                        rItem1.EmpCreated =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "CustomerName" {
                        rItem1.CustomerName =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Items" {
                        rItem1.Items =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Date" {
                        rItem1.Date =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Status" {
                        rItem1.Status =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "PendingBy" {
                        rItem1.PendingBy =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Comment" {
                        rItem1.Comment =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "URL" {
                        rItem1.URL =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "RequestDate" {
                        rItem1.RequestDate =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "ReturnDate" {
                        rItem1.ReturnDate =  strVal
                    }
                    
                }
                returnValue.append(rItem1)
                
            }
        }
        return returnValue
    }
    public func SalesArrFromXML(data: Data)-> [SalesModel] {
        
        let xmlToParse = String.init(data: data, encoding: String.Encoding.utf8)!
        return SalesArrFromXMLString( xmlToParse : xmlToParse)
    }
    
    public func ItemAddedArrFromXMLString(xmlToParse:String)->[ItemAddedModel] {
        
        let xml = SWXMLHash.lazy(xmlToParse)
        let xmlRoot = xml.children.first
        let xmlBody = xmlRoot?.children.last
        let xmlResponse: XMLIndexer? = xml.children.first?.children.first?.children.first
        let xmlResult0: XMLIndexer?  = xmlResponse?.children.last
        var strVal = ""
        var elemName = ""
        var returnValue:[ItemAddedModel] = [ItemAddedModel]()
        if elemName == "" {
            // Array Property For returnValue
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let rItem1 = ItemAddedModel()
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
                    if elemName == "Grid_ItemId" {
                        rItem1.Grid_ItemId =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Grid_Desc" {
                        rItem1.Grid_Desc =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Grid_UOM" {
                        rItem1.Grid_UOM =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Grid_Qty" {
                        rItem1.Grid_Qty =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Grid_UnitPrice" {
                        rItem1.Grid_UnitPrice =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Grid_TotalPrice" {
                        rItem1.Grid_TotalPrice =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "grid_error" {
                        rItem1.grid_error =  strVal
                    }
                    
                }
                returnValue.append(rItem1)
                
            }
        }
        return returnValue
    }
    
    public func ItemAddedSalesArrFromXML(data: Data)-> [ItemAddedModel] {
        
        let xmlToParse   = String.init(data: data, encoding: String.Encoding.utf8)!
        return ItemAddedArrFromXMLString( xmlToParse : xmlToParse)
    }
    
    public func SalesOrderApprove(empno:Int)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SalesOrderApprove xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<empno>"
        soapReqXML += String(empno)
        soapReqXML += "</empno>"
        soapReqXML += "</SalesOrderApprove>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SalesOrderApprove"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel] = SalesArrFromXML(data : responseData)
        return returnValue
    }
    
    public func GetSalesInbox(id:Int, emp_id:String, searchtext:String, index:Int)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<GetSalesInbox xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<id>"
        soapReqXML += String(id)
        soapReqXML += "</id>"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<searchtext>"
        soapReqXML += searchtext
        soapReqXML += "</searchtext>"
        soapReqXML += "<index>"
        soapReqXML += String(index)
        soapReqXML += "</index>"
        soapReqXML += "</GetSalesInbox>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"

        let soapAction :String = "http://tempuri.org/GetSalesInbox"

        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel] = SalesArrFromXML(data : responseData)
        return returnValue
    }
    
    public func GetSalesInbox(id:Int, emp_id:String, searchtext:String, index:Int, activityIndicator: UIActivityIndicatorView)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<GetSalesInbox xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<id>"
        soapReqXML += String(id)
        soapReqXML += "</id>"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<searchtext>"
        soapReqXML += searchtext
        soapReqXML += "</searchtext>"
        soapReqXML += "<index>"
        soapReqXML += String(index)
        soapReqXML += "</index>"
        soapReqXML += "</GetSalesInbox>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/GetSalesInbox"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML, activityIndicator: activityIndicator)
        //SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel] = SalesArrFromXML(data : responseData)
        return returnValue
    }
    
    public func BindSalesOrderCompany()-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindSalesOrderCompany xmlns=\"http://tempuri.org/\">"
        soapReqXML += "</BindSalesOrderCompany>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindSalesOrderCompany"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel] = SalesArrFromXML(data : responseData)
        return returnValue
    }
    public func BindSalesOrderBranches()-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindSalesOrderBranches xmlns=\"http://tempuri.org/\">"
        soapReqXML += "</BindSalesOrderBranches>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindSalesOrderBranches"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel] = SalesArrFromXML(data : responseData)
        return returnValue
    }
    public func BindSalesOrderLocCode()-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindSalesOrderLocCode xmlns=\"http://tempuri.org/\">"
        soapReqXML += "</BindSalesOrderLocCode>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindSalesOrderLocCode"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel] = SalesArrFromXML(data : responseData)
        return returnValue
    }
    public func BindSalesOrderSalesPerson()-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindSalesOrderSalesPerson xmlns=\"http://tempuri.org/\">"
        soapReqXML += "</BindSalesOrderSalesPerson>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindSalesOrderSalesPerson"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel] = SalesArrFromXML(data : responseData)
        return returnValue
    }
    
    public func BindSalesOrderCustomers(salesperson:String)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindSalesOrderCustomers xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<salesperson>"
        soapReqXML += salesperson
        soapReqXML += "</salesperson>"
        soapReqXML += "</BindSalesOrderCustomers>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindSalesOrderCustomers"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel] = SalesArrFromXML(data : responseData)
        return returnValue
    }
    public func BindSalesOrderItems(customerid:String)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindSalesOrderItems xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<customerid>"
        soapReqXML += customerid
        soapReqXML += "</customerid>"
        soapReqXML += "</BindSalesOrderItems>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindSalesOrderItems"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel] = SalesArrFromXML(data : responseData)
        return returnValue
    }
    public func BindCustomerAgingGV(cutomerid:String)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindCustomerAgingGV xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<cutomerid>"
        soapReqXML += cutomerid
        soapReqXML += "</cutomerid>"
        soapReqXML += "</BindCustomerAgingGV>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindCustomerAgingGV"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel] = SalesArrFromXML(data : responseData)
        return returnValue
    }
    public func BindSalesOrderUnitofMeasure(itemid:String)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindSalesOrderUnitofMeasure xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<itemid>"
        soapReqXML += itemid
        soapReqXML += "</itemid>"
        soapReqXML += "</BindSalesOrderUnitofMeasure>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindSalesOrderUnitofMeasure"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel] = SalesArrFromXML(data : responseData)
        return returnValue
    }
    
    public func BindPurchaseGridData(quantity:String, quantityrequired:Double, ItemId:String, unitofmeasure:String, customerid:String, loccode:String)-> [ItemAddedModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindPurchaseGridData xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<quantity>"
        soapReqXML += quantity
        soapReqXML += "</quantity>"
        soapReqXML += "<quantityrequired>"
        soapReqXML += String(quantityrequired)
        soapReqXML += "</quantityrequired>"
        soapReqXML += "<ItemId>"
        soapReqXML += ItemId
        soapReqXML += "</ItemId>"
        soapReqXML += "<unitofmeasure>"
        soapReqXML += unitofmeasure
        soapReqXML += "</unitofmeasure>"
        soapReqXML += "<customerid>"
        soapReqXML += customerid
        soapReqXML += "</customerid>"
        soapReqXML += "<loccode>"
        soapReqXML += loccode
        soapReqXML += "</loccode>"
        soapReqXML += "</BindPurchaseGridData>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindPurchaseGridData"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[ItemAddedModel] = ItemAddedSalesArrFromXML(data : responseData)
        return returnValue
    }
    
    public func BindDdlStore(customerid:String)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindDdlStore xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<customerid>"
        soapReqXML += customerid
        soapReqXML += "</customerid>"
        soapReqXML += "</BindDdlStore>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindDdlStore"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel]=SalesArrFromXML(data : responseData)
        return returnValue
    }
    public func BindCity(storevalue:String, customer:String)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindCity xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<storevalue>"
        soapReqXML += storevalue
        soapReqXML += "</storevalue>"
        soapReqXML += "<customer>"
        soapReqXML += customer
        soapReqXML += "</customer>"
        soapReqXML += "</BindCity>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindCity"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel]=SalesArrFromXML(data : responseData)
        return returnValue
    }
    public func BindSalesPersonforStore(customer:String, city:String, store:String)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindSalesPersonforStore xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<customer>"
        soapReqXML += customer
        soapReqXML += "</customer>"
        soapReqXML += "<city>"
        soapReqXML += city
        soapReqXML += "</city>"
        soapReqXML += "<store>"
        soapReqXML += store
        soapReqXML += "</store>"
        soapReqXML += "</BindSalesPersonforStore>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindSalesPersonforStore"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel]=SalesArrFromXML(data : responseData)
        return returnValue
    }
    public func BindMerchandiser(customer:String, city:String, store:String, salesperson:String)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindMerchandiser xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<customer>"
        soapReqXML += customer
        soapReqXML += "</customer>"
        soapReqXML += "<city>"
        soapReqXML += city
        soapReqXML += "</city>"
        soapReqXML += "<store>"
        soapReqXML += store
        soapReqXML += "</store>"
        soapReqXML += "<salesperson>"
        soapReqXML += salesperson
        soapReqXML += "</salesperson>"
        soapReqXML += "</BindMerchandiser>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindMerchandiser"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel]=SalesArrFromXML(data : responseData)
        return returnValue
    }
    
    public func Senditem(orderid:String, branchid:String, customerid:String, branch:String, table:Bool, salesperson:String, company:String, emp_id:String, comment:String, city:String, store:String, salespersonstore:String, merchandiser:String, offer:Bool, deliverydate:String, loccode:String, docid:String, purchasegrid:String, supermarket:Bool, flag:Bool)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Senditem xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<orderid>"
        soapReqXML += orderid
        soapReqXML += "</orderid>"
        soapReqXML += "<branchid>"
        soapReqXML += branchid
        soapReqXML += "</branchid>"
        soapReqXML += "<customerid>"
        soapReqXML += customerid
        soapReqXML += "</customerid>"
        soapReqXML += "<branch>"
        soapReqXML += branch
        soapReqXML += "</branch>"
        soapReqXML += "<table>"
        soapReqXML += String(table)
        soapReqXML += "</table>"
        soapReqXML += "<salesperson>"
        soapReqXML += salesperson
        soapReqXML += "</salesperson>"
        soapReqXML += "<company>"
        soapReqXML += company
        soapReqXML += "</company>"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "<city>"
        soapReqXML += city
        soapReqXML += "</city>"
        soapReqXML += "<store>"
        soapReqXML += store
        soapReqXML += "</store>"
        soapReqXML += "<salespersonstore>"
        soapReqXML += salespersonstore
        soapReqXML += "</salespersonstore>"
        soapReqXML += "<merchandiser>"
        soapReqXML += merchandiser
        soapReqXML += "</merchandiser>"
        soapReqXML += "<offer>"
        soapReqXML += String(offer)
        soapReqXML += "</offer>"
        soapReqXML += "<deliverydate>"
        soapReqXML += deliverydate
        soapReqXML += "</deliverydate>"
        soapReqXML += "<loccode>"
        soapReqXML += loccode
        soapReqXML += "</loccode>"
        soapReqXML += "<docid>"
        soapReqXML += docid
        soapReqXML += "</docid>"
        soapReqXML += "<purchasegrid>"
        soapReqXML += purchasegrid
        soapReqXML += "</purchasegrid>"
        soapReqXML += "<supermarket>"
        soapReqXML += String(supermarket)
        soapReqXML += "</supermarket>"
        soapReqXML += "<flag>"
        soapReqXML += String(flag)
        soapReqXML += "</flag>"
        soapReqXML += "</Senditem>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/Senditem"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel] = SalesArrFromXML(data : responseData)
        return returnValue
    }
    
    public func SendItemGrid(orderid:String, serialno:Int, customerid:String, Grid_ItemId:String, Grid_Desc:String, Grid_UnitPrice:String, Grid_Qty:String, Grid_TotalPrice:String, Grid_UOM:String)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SendItemGrid xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<orderid>"
        soapReqXML += orderid
        soapReqXML += "</orderid>"
        soapReqXML += "<serialno>"
        soapReqXML += String(serialno)
        soapReqXML += "</serialno>"
        soapReqXML += "<customerid>"
        soapReqXML += customerid
        soapReqXML += "</customerid>"
        soapReqXML += "<Grid_ItemId>"
        soapReqXML += Grid_ItemId
        soapReqXML += "</Grid_ItemId>"
        soapReqXML += "<Grid_Desc>"
        soapReqXML += Grid_Desc
        soapReqXML += "</Grid_Desc>"
        soapReqXML += "<Grid_UnitPrice>"
        soapReqXML += Grid_UnitPrice
        soapReqXML += "</Grid_UnitPrice>"
        soapReqXML += "<Grid_Qty>"
        soapReqXML += Grid_Qty
        soapReqXML += "</Grid_Qty>"
        soapReqXML += "<Grid_TotalPrice>"
        soapReqXML += Grid_TotalPrice
        soapReqXML += "</Grid_TotalPrice>"
        soapReqXML += "<Grid_UOM>"
        soapReqXML += Grid_UOM
        soapReqXML += "</Grid_UOM>"
        soapReqXML += "</SendItemGrid>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SendItemGrid"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel]=SalesArrFromXML(data : responseData)
        return returnValue
    }
    
    public func BindOrderItemGridFor_SalesApprovalForm(emp_id:String, ordernumber:String)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindOrderItemGridFor_SalesApprovalForm xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<ordernumber>"
        soapReqXML += ordernumber
        soapReqXML += "</ordernumber>"
        soapReqXML += "</BindOrderItemGridFor_SalesApprovalForm>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindOrderItemGridFor_SalesApprovalForm"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel] = SalesArrFromXML(data : responseData)
        return returnValue
    }
    public func BindCustomerCreditGridView_SalesApprovalForm(ordernumber:String)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindCustomerCreditGridView_SalesApprovalForm xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<ordernumber>"
        soapReqXML += ordernumber
        soapReqXML += "</ordernumber>"
        soapReqXML += "</BindCustomerCreditGridView_SalesApprovalForm>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindCustomerCreditGridView_SalesApprovalForm"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel]=SalesArrFromXML(data : responseData)
        return returnValue
    }
    public func BindUserComment_SalesApprovalForm(orderid:String)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindUserComment_SalesApprovalForm xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<orderid>"
        soapReqXML += orderid
        soapReqXML += "</orderid>"
        soapReqXML += "</BindUserComment_SalesApprovalForm>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindUserComment_SalesApprovalForm"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel]=SalesArrFromXML(data : responseData)
        return returnValue
    }
    public func BindApprovalGrid_SalesApprovalForm(orderid:String)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindApprovalGrid_SalesApprovalForm xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<orderid>"
        soapReqXML += orderid
        soapReqXML += "</orderid>"
        soapReqXML += "</BindApprovalGrid_SalesApprovalForm>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindApprovalGrid_SalesApprovalForm"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel]=SalesArrFromXML(data : responseData)
        return returnValue
    }
    
    public func BindCombobox(ordernumber:String)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindCombobox xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<ordernumber>"
        soapReqXML += ordernumber
        soapReqXML += "</ordernumber>"
        soapReqXML += "</BindCombobox>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindCombobox"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel] = SalesArrFromXML(data : responseData)
        return returnValue
    }
    public func CheckSalesApproval(emp_number:String, order_number:String, comment:String)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<CheckSalesApproval xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<emp_number>"
        soapReqXML += emp_number
        soapReqXML += "</emp_number>"
        soapReqXML += "<order_number>"
        soapReqXML += order_number
        soapReqXML += "</order_number>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "</CheckSalesApproval>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/CheckSalesApproval"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel] = SalesArrFromXML(data : responseData)
        return returnValue
    }
    
    public func BindSalesOrderGrid(empno:String)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindSalesOrderGrid xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<empno>"
        soapReqXML += empno
        soapReqXML += "</empno>"
        soapReqXML += "</BindSalesOrderGrid>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindSalesOrderGrid"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel]=SalesArrFromXML(data : responseData)
        return returnValue
    }
    
    public func SaveToGpArrFromXMLString(xmlToParse:String) -> [SaveToGpModel] {
        
        let xml = SWXMLHash.lazy(xmlToParse)
        let xmlRoot = xml.children.first
        let xmlBody = xmlRoot?.children.last
        let xmlResponse: XMLIndexer? = xml.children.first?.children.first?.children.first
        let xmlResult0: XMLIndexer?  = xmlResponse?.children.last
        var strVal = ""
        var elemName = ""
        var returnValue: [SaveToGpModel] = [SaveToGpModel]()
        if elemName == "" {
            // Array Property For returnValue
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let rItem1 = SaveToGpModel()
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
                    if elemName == "GP_Save" {
                        rItem1.GP_Save =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "GP_Error" {
                        rItem1.GP_Error =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Savetogp_btn_vis" {
                        rItem1.Savetogp_btn_vis =  (strVal.lowercased() == "true")
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "ApproveandEnterManually_btn" {
                        rItem1.ApproveandEnterManually_btn =  (strVal.lowercased() == "true")
                    }
                    
                }
                returnValue.append(rItem1)
                
            }
        }
        return returnValue
    }
    public func SaveToGpArrFromXML(data: Data)-> [SaveToGpModel] {
        
        let xmlToParse   = String.init(data: data, encoding: String.Encoding.utf8)!
        return SaveToGpArrFromXMLString( xmlToParse : xmlToParse)
    }
    public func SaveToGp(orderno:String, combo_loc_code:String, combo_doc_id:String, empnumber:String)-> [SaveToGpModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SaveToGp xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<orderno>"
        soapReqXML += orderno
        soapReqXML += "</orderno>"
        soapReqXML += "<combo_loc_code>"
        soapReqXML += combo_loc_code
        soapReqXML += "</combo_loc_code>"
        soapReqXML += "<combo_doc_id>"
        soapReqXML += combo_doc_id
        soapReqXML += "</combo_doc_id>"
        soapReqXML += "<empnumber>"
        soapReqXML += empnumber
        soapReqXML += "</empnumber>"
        soapReqXML += "</SaveToGp>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SaveToGp"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SaveToGpModel]=SaveToGpArrFromXML(data : responseData)
        return returnValue
    }
    public func BeforeApproveFinalOrder(serialnumber:String, ordernumber:String, checkbox:Bool){
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BeforeApproveFinalOrder xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<serialnumber>"
        soapReqXML += serialnumber
        soapReqXML += "</serialnumber>"
        soapReqXML += "<ordernumber>"
        soapReqXML += ordernumber
        soapReqXML += "</ordernumber>"
        soapReqXML += "<checkbox>"
        soapReqXML += String(checkbox)
        soapReqXML += "</checkbox>"
        soapReqXML += "</BeforeApproveFinalOrder>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BeforeApproveFinalOrder"
        
        SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
    }
    
    public func ApproveFinalOrder(orderno:String, approver:String, empno:String, comment:String)-> String{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<ApproveFinalOrder xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<orderno>"
        soapReqXML += orderno
        soapReqXML += "</orderno>"
        soapReqXML += "<approver>"
        soapReqXML += approver
        soapReqXML += "</approver>"
        soapReqXML += "<empno>"
        soapReqXML += empno
        soapReqXML += "</empno>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "</ApproveFinalOrder>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/ApproveFinalOrder"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let strVal :String? = stringFromXML(data : responseData);
        if strVal == nil {
            
            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func Reject_SalesOrderApproval(ordernumber:String, empnumber:String, app_diary:String, app_retail:String, app_market:String, export:String, approval1:String, approver:String, comment:String)-> String{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Reject_SalesOrderApproval xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<ordernumber>"
        soapReqXML += ordernumber
        soapReqXML += "</ordernumber>"
        soapReqXML += "<empnumber>"
        soapReqXML += empnumber
        soapReqXML += "</empnumber>"
        soapReqXML += "<app_diary>"
        soapReqXML += app_diary
        soapReqXML += "</app_diary>"
        soapReqXML += "<app_retail>"
        soapReqXML += app_retail
        soapReqXML += "</app_retail>"
        soapReqXML += "<app_market>"
        soapReqXML += app_market
        soapReqXML += "</app_market>"
        soapReqXML += "<export>"
        soapReqXML += export
        soapReqXML += "</export>"
        soapReqXML += "<approval1>"
        soapReqXML += approval1
        soapReqXML += "</approval1>"
        soapReqXML += "<approver>"
        soapReqXML += approver
        soapReqXML += "</approver>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "</Reject_SalesOrderApproval>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/Reject_SalesOrderApproval"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let strVal :String? = stringFromXML(data : responseData);
        if strVal == nil {
            
            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    
    public func SalesReturnArrFromXMLString(xmlToParse:String)->[SalesReturn] {
        
        let xml = SWXMLHash.lazy(xmlToParse)
        let xmlRoot = xml.children.first
        let xmlBody = xmlRoot?.children.last
        let xmlResponse: XMLIndexer? = xml.children.first?.children.first?.children.first
        let xmlResult0: XMLIndexer?  = xmlResponse?.children.last
        var strVal = ""
        var elemName = ""
        var returnValue:[SalesReturn] = [SalesReturn]()
        if elemName == "" {
            // Array Property For returnValue
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let rItem1 = SalesReturn()
                let xmlResult_Parent1:XMLIndexer? = xmlResult0?.children[i1]
                let childCount1 :Int = (xmlResult_Parent1?.children.count)!
                for j1 in 0 ..< childCount1 {
                    
                    let xmlResult1: XMLIndexer? =  xmlResult_Parent1?.children[j1]
                    let elem1: XMLElement? =  xmlResult1?.element
                    strVal = ""
                    if elem1?.children.first is TextElement {
                        for elem in (elem1?.children)!{
                            let elemText:TextElement = elem as! TextElement
                            strVal += elemText.text
                        }
                    }
                    elemName = elem1!.name
                    // Array Propert of returnValue subProperty for rItem1
                    if elemName == "CreditLimit" {
                        rItem1.CreditLimit =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "TotalDue" {
                        rItem1.TotalDue =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "ZeroTo31Days" {
                        rItem1.ZeroTo31Days =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "ThirtyOneto60Days" {
                        rItem1.ThirtyOneto60Days =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SixtyOneTo90Days" {
                        rItem1.SixtyOneTo90Days =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Nineoneto120Days" {
                        rItem1.Nineoneto120Days =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Above120Days" {
                        rItem1.Above120Days =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Status" {
                        rItem1.Status =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Sop_Number" {
                        rItem1.Sop_Number =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "ReturnID" {
                        rItem1.ReturnID =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "EmpCreated" {
                        rItem1.EmpCreated =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Items" {
                        rItem1.Items =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "ReqDate" {
                        rItem1.ReqDate =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "RetDate" {
                        rItem1.RetDate =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Comment" {
                        rItem1.Comment =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRI_CustomerID" {
                        rItem1.SRI_CustomerID =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRI_CustomerName" {
                        rItem1.SRI_CustomerName =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRI_CreditLimit" {
                        rItem1.SRI_CreditLimit =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRI_TotalDue" {
                        rItem1.SRI_TotalDue =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRI_Status" {
                        rItem1.SRI_Status =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_Comment" {
                        rItem1.SRA_Comment =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_SLSPersonId" {
                        rItem1.SRA_SLSPersonId =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_SLSPersonName" {
                        rItem1.SRA_SLSPersonName =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_ExtPrice" {
                        rItem1.SRA_ExtPrice =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_ItemDesc" {
                        rItem1.SRA_ItemDesc =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_ReturnId" {
                        rItem1.SRA_ReturnId =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_InvoiceDate" {
                        rItem1.SRA_InvoiceDate =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_EmpCreated" {
                        rItem1.SRA_EmpCreated =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_CustomerName" {
                        rItem1.SRA_CustomerName =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_SalesPerson" {
                        rItem1.SRA_SalesPerson =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_ReqDate" {
                        rItem1.SRA_ReqDate =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_ReturnDate" {
                        rItem1.SRA_ReturnDate =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_InvoiceNumber" {
                        rItem1.SRA_InvoiceNumber =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_LotNumber" {
                        rItem1.SRA_LotNumber =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_ItemNumber" {
                        rItem1.SRA_ItemNumber =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_Description" {
                        rItem1.SRA_Description =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_Unitprice" {
                        rItem1.SRA_Unitprice =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_TotalCost" {
                        rItem1.SRA_TotalCost =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_Qty" {
                        rItem1.SRA_Qty =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_UOFM" {
                        rItem1.SRA_UOFM =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_ReturnType" {
                        rItem1.SRA_ReturnType =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_EMP_ID" {
                        rItem1.SRA_EMP_ID =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_Name" {
                        rItem1.SRA_Name =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_EmpRole" {
                        rItem1.SRA_EmpRole =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_Status" {
                        rItem1.SRA_Status =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_TransDate" {
                        rItem1.SRA_TransDate =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_User_EmpName" {
                        rItem1.SRA_User_EmpName =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_User_EmpComment" {
                        rItem1.SRA_User_EmpComment =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_SerialNumber" {
                        rItem1.SRA_SerialNumber =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "VIEW" {
                        rItem1.VIEW =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "INDEX" {
                        rItem1.INDEX =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "FILENAME" {
                        rItem1.FILENAME =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "FILETYPE" {
                        rItem1.FILETYPE =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_APPROVE_BTN" {
                        rItem1.SRA_APPROVE_BTN =  (strVal.lowercased() == "true")
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_REJECT_BTN" {
                        rItem1.SRA_REJECT_BTN =  (strVal.lowercased() == "true")
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRA_APPROVER" {
                        rItem1.SRA_APPROVER =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRR_CustomerDDL" {
                        rItem1.SRR_CustomerDDL =  (strVal.lowercased() == "true")
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRR_SalesPersonDDL" {
                        rItem1.SRR_SalesPersonDDL =  (strVal.lowercased() == "true")
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRR_ITEMNUMBER" {
                        rItem1.SRR_ITEMNUMBER =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRR_INVOICENO" {
                        rItem1.SRR_INVOICENO =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRR_DESCRIPTION" {
                        rItem1.SRR_DESCRIPTION =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRR_LOTNO" {
                        rItem1.SRR_LOTNO =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRR_UOFM" {
                        rItem1.SRR_UOFM =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRR_QTY" {
                        rItem1.SRR_QTY =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRR_TOTALPRICE" {
                        rItem1.SRR_TOTALPRICE =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRR_UNITPRICE" {
                        rItem1.SRR_UNITPRICE =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRR_INVOICEDATE" {
                        rItem1.SRR_INVOICEDATE =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRR_ITEMGRID_COLUMN1" {
                        rItem1.SRR_ITEMGRID_COLUMN1 =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRR_ITEMGRID_COLUMN2" {
                        rItem1.SRR_ITEMGRID_COLUMN2 =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRR_ITEMGRID_COLUMN3" {
                        rItem1.SRR_ITEMGRID_COLUMN3 =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRR_ITEMGRID_COLUMN4" {
                        rItem1.SRR_ITEMGRID_COLUMN4 =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRR_ITEMGRID_COLUMN5" {
                        rItem1.SRR_ITEMGRID_COLUMN5 =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRR_ITEMGRID_COLUMN6" {
                        rItem1.SRR_ITEMGRID_COLUMN6 =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRR_ITEMGRID_COLUMN7" {
                        rItem1.SRR_ITEMGRID_COLUMN7 =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRR_ITEMGRID_COLUMN8" {
                        rItem1.SRR_ITEMGRID_COLUMN8 =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRR_ITEMGRID_COLUMN9" {
                        rItem1.SRR_ITEMGRID_COLUMN9 =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRR_ITEMGRID_COLUMN10" {
                        rItem1.SRR_ITEMGRID_COLUMN10 =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SRR_ITEMGRID_COLUMN11" {
                        rItem1.SRR_ITEMGRID_COLUMN11 =  strVal
                    }
                    
                }
                returnValue.append(rItem1)
                
            }
        }
        return returnValue
    }
    public func SalesReturnArrFromXML(data: Data)-> [SalesReturn] {
        
        let xmlToParse   = String.init(data: data, encoding: String.Encoding.utf8)!
        return SalesReturnArrFromXMLString( xmlToParse : xmlToParse)
    }
    
    public func SRR_BindCustomerAging(customer_no:String)-> [SalesReturn]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRR_BindCustomerAging xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<customer_no>"
        soapReqXML += customer_no
        soapReqXML += "</customer_no>"
        soapReqXML += "</SRR_BindCustomerAging>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SRR_BindCustomerAging"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesReturn]=SalesReturnArrFromXML(data : responseData)
        return returnValue
    }
    
    public func SRR_BindInvoice(salesperson_id:String, customernumber:String, invoice_date:String)-> [SalesReturn]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRR_BindInvoice xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<salesperson_id>"
        soapReqXML += salesperson_id
        soapReqXML += "</salesperson_id>"
        soapReqXML += "<customernumber>"
        soapReqXML += customernumber
        soapReqXML += "</customernumber>"
        soapReqXML += "<invoice_date>"
        soapReqXML += invoice_date
        soapReqXML += "</invoice_date>"
        soapReqXML += "</SRR_BindInvoice>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SRR_BindInvoice"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesReturn]=SalesReturnArrFromXML(data : responseData)
        return returnValue
    }
    
    public func SRO_BindOrder(empno:String)-> [SalesReturn]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRO_BindOrder xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<empno>"
        soapReqXML += empno
        soapReqXML += "</empno>"
        soapReqXML += "</SRO_BindOrder>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SRO_BindOrder"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesReturn]=SalesReturnArrFromXML(data : responseData)
        return returnValue
    }
    public func SRA_BindApproverGrid(empno:String, returnid:String)-> [SalesReturn]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRA_BindApproverGrid xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<empno>"
        soapReqXML += empno
        soapReqXML += "</empno>"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "</SRA_BindApproverGrid>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SRA_BindApproverGrid"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesReturn]=SalesReturnArrFromXML(data : responseData)
        return returnValue
    }
    
    public func SRA_BindUserGrid(empno:String, returnid:String)-> [SalesReturn]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRA_BindUserGrid xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<empno>"
        soapReqXML += empno
        soapReqXML += "</empno>"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "</SRA_BindUserGrid>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SRA_BindUserGrid"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesReturn]=SalesReturnArrFromXML(data : responseData)
        return returnValue
    }
    
    public func SR_SaveAttachment(returnid:String, attachment_name:String, attachment_Content:String)-> String{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SR_SaveAttachment xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "<attachment_name>"
        soapReqXML += attachment_name
        soapReqXML += "</attachment_name>"
        soapReqXML += "<attachment_Content>"
        soapReqXML += attachment_Content
        soapReqXML += "</attachment_Content>"
        soapReqXML += "</SR_SaveAttachment>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SR_SaveAttachment"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let strVal :String? = stringFromXML(data : responseData);
        if strVal == nil {
            
            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    
    public func SRR_SEND_SRR(supermarket:Bool, itemtable:Bool, returnid:String, customervalue:String, customertext:String, salespersonvalue:String, salespersontext:String, returndate:String, emp_no:String, comment:String, branchtext:String, companyid:String, branchvalue:String, storevalue:String, cityvalue:String, storesalespersonvalue:String, merchandiser:String)-> [String?]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRR_SEND_SRR xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<supermarket>"
        soapReqXML += String(supermarket)
        soapReqXML += "</supermarket>"
        soapReqXML += "<itemtable>"
        soapReqXML += String(itemtable)
        soapReqXML += "</itemtable>"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "<customervalue>"
        soapReqXML += customervalue
        soapReqXML += "</customervalue>"
        soapReqXML += "<customertext>"
        soapReqXML += customertext
        soapReqXML += "</customertext>"
        soapReqXML += "<salespersonvalue>"
        soapReqXML += salespersonvalue
        soapReqXML += "</salespersonvalue>"
        soapReqXML += "<salespersontext>"
        soapReqXML += salespersontext
        soapReqXML += "</salespersontext>"
        soapReqXML += "<returndate>"
        soapReqXML += returndate
        soapReqXML += "</returndate>"
        soapReqXML += "<emp_no>"
        soapReqXML += emp_no
        soapReqXML += "</emp_no>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "<branchtext>"
        soapReqXML += branchtext
        soapReqXML += "</branchtext>"
        soapReqXML += "<companyid>"
        soapReqXML += companyid
        soapReqXML += "</companyid>"
        soapReqXML += "<branchvalue>"
        soapReqXML += branchvalue
        soapReqXML += "</branchvalue>"
        soapReqXML += "<storevalue>"
        soapReqXML += storevalue
        soapReqXML += "</storevalue>"
        soapReqXML += "<cityvalue>"
        soapReqXML += cityvalue
        soapReqXML += "</cityvalue>"
        soapReqXML += "<storesalespersonvalue>"
        soapReqXML += storesalespersonvalue
        soapReqXML += "</storesalespersonvalue>"
        soapReqXML += "<merchandiser>"
        soapReqXML += merchandiser
        soapReqXML += "</merchandiser>"
        soapReqXML += "</SRR_SEND_SRR>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SRR_SEND_SRR"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let strVals :[String?] = stringArrFromXML(data : responseData);
        var vals = [String?]()
        for i in 0  ..< strVals.count {
            let xVal =  strVals[i]
            vals.append(xVal)
        }
        let returnValue:[String?] = vals
        return returnValue
    }
    
    public func SRR_BindItemsonChangeofInvoice(invoicenumber:String)-> [SalesReturn]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRR_BindItemsonChangeofInvoice xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<invoicenumber>"
        soapReqXML += invoicenumber
        soapReqXML += "</invoicenumber>"
        soapReqXML += "</SRR_BindItemsonChangeofInvoice>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SRR_BindItemsonChangeofInvoice"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesReturn]=SalesReturnArrFromXML(data : responseData)
        return returnValue
    }
    
    public func SRR_BEFORESEND_SRR(itemid:String, invoicenumber:String, quantity:String, returnid:String, rownumber:Int, Item_Desc:String, unitofmeasure:String, totalcost:String, unitprice:String, lotnumber:String, invoicedate:String, returntype_grid:String)-> [String?]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRR_BEFORESEND_SRR xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<itemid>"
        soapReqXML += itemid
        soapReqXML += "</itemid>"
        soapReqXML += "<invoicenumber>"
        soapReqXML += invoicenumber
        soapReqXML += "</invoicenumber>"
        soapReqXML += "<quantity>"
        soapReqXML += quantity
        soapReqXML += "</quantity>"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "<rownumber>"
        soapReqXML += String(rownumber)
        soapReqXML += "</rownumber>"
        soapReqXML += "<Item_Desc>"
        soapReqXML += Item_Desc
        soapReqXML += "</Item_Desc>"
        soapReqXML += "<unitofmeasure>"
        soapReqXML += unitofmeasure
        soapReqXML += "</unitofmeasure>"
        soapReqXML += "<totalcost>"
        soapReqXML += totalcost
        soapReqXML += "</totalcost>"
        soapReqXML += "<unitprice>"
        soapReqXML += unitprice
        soapReqXML += "</unitprice>"
        soapReqXML += "<lotnumber>"
        soapReqXML += lotnumber
        soapReqXML += "</lotnumber>"
        soapReqXML += "<invoicedate>"
        soapReqXML += invoicedate
        soapReqXML += "</invoicedate>"
        soapReqXML += "<returntype_grid>"
        soapReqXML += returntype_grid
        soapReqXML += "</returntype_grid>"
        soapReqXML += "</SRR_BEFORESEND_SRR>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SRR_BEFORESEND_SRR"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let strVals :[String?] = stringArrFromXML(data : responseData);
        var vals = [String?]()
        for i in 0  ..< strVals.count {
            let xVal =  strVals[i]
            vals.append(xVal)
        }
        let returnValue:[String?] = vals
        return returnValue
    }
    
    public func SRR_AddItem(rownumber:Int, returnid:String, empno:String, qty:String, invoicenumber:String, item:String, table:String)-> [SalesReturn]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRR_AddItem xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<rownumber>"
        soapReqXML += String(rownumber)
        soapReqXML += "</rownumber>"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "<empno>"
        soapReqXML += empno
        soapReqXML += "</empno>"
        soapReqXML += "<qty>"
        soapReqXML += qty
        soapReqXML += "</qty>"
        soapReqXML += "<invoicenumber>"
        soapReqXML += invoicenumber
        soapReqXML += "</invoicenumber>"
        soapReqXML += "<item>"
        soapReqXML += item
        soapReqXML += "</item>"
        soapReqXML += "<table>"
        soapReqXML += table
        soapReqXML += "</table>"
        soapReqXML += "</SRR_AddItem>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SRR_AddItem"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesReturn]=SalesReturnArrFromXML(data : responseData)
        return returnValue
    }
    
    public func SRA_REJECT(returnid:String, empnumber:String, comment:String, approver:String)-> String{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRA_REJECT xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "<empnumber>"
        soapReqXML += empnumber
        soapReqXML += "</empnumber>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "<approver>"
        soapReqXML += approver
        soapReqXML += "</approver>"
        soapReqXML += "</SRA_REJECT>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SRA_REJECT"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let strVal :String? = stringFromXML(data : responseData);
        if strVal == nil {
            
            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    
    public func SRA_ONLOADCOMPLETE(empnumber:String, returnid:String, comment:String)-> [SalesReturn]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRA_ONLOADCOMPLETE xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<empnumber>"
        soapReqXML += empnumber
        soapReqXML += "</empnumber>"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "</SRA_ONLOADCOMPLETE>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SRA_ONLOADCOMPLETE"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesReturn]=SalesReturnArrFromXML(data : responseData)
        return returnValue
    }
    
    public func SRA_BindItemGrid(empno:String, returnid:String)-> [SalesReturn]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRA_BindItemGrid xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<empno>"
        soapReqXML += empno
        soapReqXML += "</empno>"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "</SRA_BindItemGrid>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SRA_BindItemGrid"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesReturn]=SalesReturnArrFromXML(data : responseData)
        return returnValue
    }
    
    public func SRA_BindAttachmentGrid(empno:String, returnid:String)-> [SalesReturn]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRA_BindAttachmentGrid xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<empno>"
        soapReqXML += empno
        soapReqXML += "</empno>"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "</SRA_BindAttachmentGrid>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SRA_BindAttachmentGrid"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesReturn]=SalesReturnArrFromXML(data : responseData)
        return returnValue
    }
    
    public func SRA_BEFOREAPPROVE(empno:String, returnid:String, gridcheckbox:Bool, serialnumber:String)-> String{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRA_BEFOREAPPROVE xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<empno>"
        soapReqXML += empno
        soapReqXML += "</empno>"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "<gridcheckbox>"
        soapReqXML += String(gridcheckbox)
        soapReqXML += "</gridcheckbox>"
        soapReqXML += "<serialnumber>"
        soapReqXML += serialnumber
        soapReqXML += "</serialnumber>"
        soapReqXML += "</SRA_BEFOREAPPROVE>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SRA_BEFOREAPPROVE"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let strVal :String? = stringFromXML(data : responseData);
        if strVal == nil {
            
            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    
    public func SRA_APPROVE(empnumber:String, returnid:String, approver:String, comment:String)-> String{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRA_APPROVE xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<empnumber>"
        soapReqXML += empnumber
        soapReqXML += "</empnumber>"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "<approver>"
        soapReqXML += approver
        soapReqXML += "</approver>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "</SRA_APPROVE>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SRA_APPROVE"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let strVal :String? = stringFromXML(data : responseData);
        if strVal == nil {
            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    
    public func GetTempFilename()-> String{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<GetTempFilename xmlns=\"http://tempuri.org/\">"
        soapReqXML += "</GetTempFilename>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/GetTempFilename"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let strVal :String? = stringFromXML(data : responseData);
        if strVal == nil {
            
            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    
    public func BindSalesReturnSalesPerson()-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindSalesReturnSalesPerson xmlns=\"http://tempuri.org/\">"
        soapReqXML += "</BindSalesReturnSalesPerson>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindSalesReturnSalesPerson"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel]=SalesArrFromXML(data : responseData)
        return returnValue
    }
    
    public func BindSalesReturnCustomers(salesperson:String)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindSalesReturnCustomers xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<salespersonid>"
        soapReqXML += salesperson
        soapReqXML += "</salespersonid>"
        soapReqXML += "</BindSalesReturnCustomers>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindSalesReturnCustomers"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel] = SalesArrFromXML(data : responseData)
        return returnValue
    }
    
    public func SRI_BindItemGrid(returnid:String)-> [SalesReturn]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRI_BindItemGrid xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "</SRI_BindItemGrid>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SRI_BindItemGrid"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesReturn]=SalesReturnArrFromXML(data : responseData)
        return returnValue
    }
    
    public func SRI_BindCustomerCreditLimit(returnid:String, company:String)-> [SalesReturn]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRI_BindCustomerCreditLimit xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "<company>"
        soapReqXML += company
        soapReqXML += "</company>"
        soapReqXML += "</SRI_BindCustomerCreditLimit>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SRI_BindCustomerCreditLimit"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesReturn]=SalesReturnArrFromXML(data : responseData)
        return returnValue
    }
    
 }
