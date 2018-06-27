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
    func stringFromXMLString(xmlToParse:String)->String {
        do
        {
            let xml = SWXMLHash.lazy(xmlToParse)
            let xmlResponse : XMLIndexer? = xml.children.first?.children.first?.children.first
            let xmlResult: XMLIndexer?  = xmlResponse?.children.last
            
            let xmlElement = xmlResult?.element
            let str = xmlElement?.text
            let xmlElementFirst = xmlElement?.children[0] as!TextElement
            return xmlElementFirst.text
        }
        catch
        {
        }
        //NOT IMPLETEMENTED!
        var returnValue:String!
        return returnValue
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
        let xmlBody = xmlRoot?.children.last
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
//                        let elemText:TextElement = elem1?.children.first as! TextElement
//                        strVal = elemText.text
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
                    else if elemName == "Flag" {
                        rItem1.Flag =  (strVal.lowercased())
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
 }
