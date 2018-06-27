 import Foundation
 public class Login {
    public var Url:String = "http://82.118.166.164/ios_hrms/login.asmx"
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
            if let str = str {
                let xmlElementFirst = xmlElement?.children[0] as!TextElement
                return xmlElementFirst.text
            }
            
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
    
    public func HelloWorld()-> String{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<HelloWorld xmlns=\"http://tempuri.org/\">"
        soapReqXML += "</HelloWorld>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/HelloWorld"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let strVal :String? = stringFromXML(data : responseData);
        if strVal == nil {
            
            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func CheckLogin(username:String, password:String, error:String, langid:Int)-> [String?]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<CheckLogin xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<username>"
        soapReqXML += username
        soapReqXML += "</username>"
        soapReqXML += "<password>"
        soapReqXML += password
        soapReqXML += "</password>"
        soapReqXML += "<error>"
        soapReqXML += error
        soapReqXML += "</error>"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "</CheckLogin>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/CheckLogin"
        
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
    
    public func CheckLogin(username:String, password:String, error:String, langid:Int, activityIndicator: UIActivityIndicatorView)-> [String?]{
        activityIndicator.startAnimating()
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<CheckLogin xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<username>"
        soapReqXML += username
        soapReqXML += "</username>"
        soapReqXML += "<password>"
        soapReqXML += password
        soapReqXML += "</password>"
        soapReqXML += "<error>"
        soapReqXML += error
        soapReqXML += "</error>"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "</CheckLogin>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/CheckLogin"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML, activityIndicator: activityIndicator)
        
        let strVals :[String?] = stringArrFromXML(data : responseData);
        var vals = [String?]()
        for i in 0  ..< strVals.count {
            let xVal =  strVals[i]
            vals.append(xVal)
        }
        let returnValue:[String?] = vals
        return returnValue
    }
    
    
    
    public func Task_InboxArrFromXMLString(xmlToParse:String)->[Task_Inbox] {
        
        let xml = SWXMLHash.lazy(xmlToParse)
        let xmlRoot = xml.children.first
        let xmlBody = xmlRoot?.children.last
        let xmlResponse: XMLIndexer? = xml.children.first?.children.first?.children.first
        let xmlResult0: XMLIndexer?  = xmlResponse?.children.last
        var strVal = ""
        var elemName = ""
        var returnValue:[Task_Inbox] = [Task_Inbox]()
        if elemName == "" {
            // Array Property For returnValue
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let rItem1 = Task_Inbox()
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
                    if elemName == "FormId" {
                        rItem1.FormId =  strVal
                    }
                    // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "EnglishDes" {
                        rItem1.EnglishDes =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "ArabicDesc" {
                        rItem1.ArabicDesc =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "PageName" {
                        rItem1.PageName =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Count" {
                        rItem1.Count = strVal.toInt()!
                    }
                    
                }
                returnValue.append(rItem1)
                
            }
        }
        return returnValue
    }
    public func Task_InboxArrFromXML(data: Data)-> [Task_Inbox] {
        
        let xmlToParse   = String.init(data: data, encoding: String.Encoding.utf8)!
        return Task_InboxArrFromXMLString( xmlToParse : xmlToParse)
    }
    public func Task_InboxM(langid:Int, emp_id:String)-> [Task_Inbox]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Task_Inbox xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "</Task_Inbox>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/Task_Inbox"
        
        let responseData: Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        
        let returnValue: [Task_Inbox] = Task_InboxArrFromXML(data : responseData)
        return returnValue
    }
    public func ChangePassword(emp_id:String, oldpassword:String, newpassword:String, error:String)-> String{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<ChangePassword xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<oldpassword>"
        soapReqXML += oldpassword
        soapReqXML += "</oldpassword>"
        soapReqXML += "<newpassword>"
        soapReqXML += newpassword
        soapReqXML += "</newpassword>"
        soapReqXML += "<error>"
        soapReqXML += error
        soapReqXML += "</error>"
        soapReqXML += "</ChangePassword>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/ChangePassword"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let strVal :String? = stringFromXML(data : responseData);
        if strVal == nil {
            
            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func ListTypeArrFromXMLString(xmlToParse:String)->[ListType] {
        
        let xml = SWXMLHash.lazy(xmlToParse)
        let xmlRoot = xml.children.first
        let xmlBody = xmlRoot?.children.last
        let xmlResponse: XMLIndexer? = xml.children.first?.children.first?.children.first
        let xmlResult0: XMLIndexer?  = xmlResponse?.children.last
        var strVal = ""
        var elemName = ""
        var returnValue:[ListType] = [ListType]()
        if elemName == "" {
            // Array Property For returnValue
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let rItem1 = ListType()
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
                    if elemName == "listtype" {
                        rItem1.listtype =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "listname" {
                        rItem1.listname =  strVal
                    }
                    
                }
                returnValue.append(rItem1)
                
            }
        }
        return returnValue
    }
    public func ListTypeArrFromXML(data: Data)-> [ListType] {
        
        let xmlToParse   = String.init(data: data, encoding: String.Encoding.utf8)!
        return ListTypeArrFromXMLString( xmlToParse : xmlToParse)
    }
    public func Bind_ddlReqType(langid:Int)-> [ListType]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Bind_ddlReqType xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "</Bind_ddlReqType>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/Bind_ddlReqType"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[ListType]=ListTypeArrFromXML(data : responseData)
        return returnValue
    }
    public func InboxGridArrFromXMLString(xmlToParse:String)->[InboxGrid] {
        
        let xml = SWXMLHash.lazy(xmlToParse)
        let xmlRoot = xml.children.first
        let xmlBody = xmlRoot?.children.last
        let xmlResponse: XMLIndexer? = xml.children.first?.children.first?.children.first
        let xmlResult0: XMLIndexer?  = xmlResponse?.children.last
        var strVal = ""
        var elemName = ""
        var returnValue:[InboxGrid] = [InboxGrid]()
        if elemName == "" {
            // Array Property For returnValue
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let rItem1 = InboxGrid()
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
                    if elemName == "pid" {
                        rItem1.pid =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "empname" {
                        rItem1.empname =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "empid" {
                        rItem1.empid =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "date" {
                        rItem1.date =  strVal
                    }
                    
                }
                returnValue.append(rItem1)
                
            }
        }
        return returnValue
    }
    public func InboxGridArrFromXML(data: Data)-> [InboxGrid] {
        
        let xmlToParse   = String.init(data: data, encoding: String.Encoding.utf8)!
        return InboxGridArrFromXMLString( xmlToParse : xmlToParse)
    }
    public func SearchInbox(empid:Int, formid:String, drpdwnvalue:String, search:String, langid:Int)-> [InboxGrid]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SearchInbox xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<empid>"
        soapReqXML += String(empid)
        soapReqXML += "</empid>"
        soapReqXML += "<formid>"
        soapReqXML += formid
        soapReqXML += "</formid>"
        soapReqXML += "<drpdwnvalue>"
        soapReqXML += drpdwnvalue
        soapReqXML += "</drpdwnvalue>"
        soapReqXML += "<search>"
        soapReqXML += search
        soapReqXML += "</search>"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "</SearchInbox>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SearchInbox"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[InboxGrid]=InboxGridArrFromXML(data : responseData)
        return returnValue
    }
    public func EmpVacArrFromXMLString(xmlToParse:String)->[EmpVac] {
        
        let xml = SWXMLHash.lazy(xmlToParse)
        let xmlRoot = xml.children.first
        let xmlBody = xmlRoot?.children.last
        let xmlResponse: XMLIndexer? = xml.children.first?.children.first?.children.first
        let xmlResult0: XMLIndexer?  = xmlResponse?.children.last
        var strVal = ""
        var elemName = ""
        var returnValue:[EmpVac] = [EmpVac]()
        if elemName == "" {
            // Array Property For returnValue
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let rItem1 = EmpVac()
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
                    if elemName == "exitrentry" {
                        rItem1.exitrentry =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "extradays" {
                        rItem1.extradays =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Error" {
                        rItem1.Error =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "PID" {
                        rItem1.PID =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "TotalSettlementAmount" {
                        rItem1.TotalSettlementAmount =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "DiffTicketAmount" {
                        rItem1.DiffTicketAmount =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "NetTicketPrice" {
                        rItem1.NetTicketPrice =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "TicketPercent" {
                        rItem1.TicketPercent =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "TicketAmount" {
                        rItem1.TicketAmount =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "TicketPrice" {
                        rItem1.TicketPrice =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "VNet" {
                        rItem1.VNet =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "VAllowances" {
                        rItem1.VAllowances =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "VTotal" {
                        rItem1.VTotal =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "VBasic" {
                        rItem1.VBasic =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SNet" {
                        rItem1.SNet =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "STotal" {
                        rItem1.STotal =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SAllowances" {
                        rItem1.SAllowances =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SBasic" {
                        rItem1.SBasic =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SDeduction" {
                        rItem1.SDeduction =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Emp_Id" {
                        rItem1.Emp_Id = strVal.toInt()!
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Emp_Ename" {
                        rItem1.Emp_Ename =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Emp_AName" {
                        rItem1.Emp_AName =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Job_Num" {
                        rItem1.Job_Num =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Job_English" {
                        rItem1.Job_English =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Job_Arabic" {
                        rItem1.Job_Arabic =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Sub_Job_Num" {
                        rItem1.Sub_Job_Num =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Sub_Job_English" {
                        rItem1.Sub_Job_English =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Sub_Job_Arabic" {
                        rItem1.Sub_Job_Arabic =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Nationality_Num" {
                        rItem1.Nationality_Num =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Nationality_English" {
                        rItem1.Nationality_English =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Nationality_Arabic" {
                        rItem1.Nationality_Arabic =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Manager_Id" {
                        rItem1.Manager_Id =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Manager_English" {
                        rItem1.Manager_English =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Manager_Arabic" {
                        rItem1.Manager_Arabic =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Department_Num" {
                        rItem1.Department_Num =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Department_English" {
                        rItem1.Department_English =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "JoinDate" {
                        rItem1.JoinDate =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "StartDate" {
                        rItem1.StartDate =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Leave_Start_Dt" {
                        rItem1.Leave_Start_Dt =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Leave_Return_Dt" {
                        rItem1.Leave_Return_Dt =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Balance_Vacation" {
                        rItem1.Balance_Vacation =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Number_Days" {
                        rItem1.Number_Days =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "ExitReEntry" {
                        rItem1.ExitReEntry =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "ExtraDays" {
                        rItem1.ExtraDays =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Vac_Type" {
                        rItem1.Vac_Type =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Vac_Desc" {
                        rItem1.Vac_Desc =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SettlementAmount" {
                        rItem1.SettlementAmount =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Dependent_Ticket" {
                        rItem1.Dependent_Ticket =  strVal
                    }
                }
                returnValue.append(rItem1)
                
            }
        }
        return returnValue
    }
    public func EmpVacArrFromXML(data: Data)-> [EmpVac] {
        
        let xmlToParse   = String.init(data: data, encoding: String.Encoding.utf8)!
        return EmpVacArrFromXMLString( xmlToParse : xmlToParse)
    }
    public func BindEmpsVacationsDropDown(langid:Int, Emp_no:String)-> [EmpVac]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindEmpsVacationsDropDown xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "<Emp_no>"
        soapReqXML += Emp_no
        soapReqXML += "</Emp_no>"
        soapReqXML += "</BindEmpsVacationsDropDown>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindEmpsVacationsDropDown"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[EmpVac]=EmpVacArrFromXML(data : responseData)
        return returnValue
    }
    public func BindDelegateVacationsDropDown(langid:Int, Emp_no:String)-> [EmpVac]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindDelegateVacationsDropDown xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "<Emp_no>"
        soapReqXML += Emp_no
        soapReqXML += "</Emp_no>"
        soapReqXML += "</BindDelegateVacationsDropDown>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindDelegateVacationsDropDown"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[EmpVac]=EmpVacArrFromXML(data : responseData)
        return returnValue
    }
    public func EmpVacFromXMLString(xmlToParse:String)->EmpVac {
        
        let xml = SWXMLHash.lazy(xmlToParse)
        let xmlRoot = xml.children.first
        let xmlBody = xmlRoot?.children.last
        let xmlResponse: XMLIndexer? = xml.children.first?.children.first?.children.first
        let xmlResult0: XMLIndexer?  = xmlResponse?.children.last
        var strVal = ""
        var elemName = ""
        var returnValue:EmpVac = EmpVac()
        if elemName == "" {
            // Property name :
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let xmlResult1:XMLIndexer? = xmlResult0?.children[i1]
                let elem1: XMLElement? =  xmlResult1!.element
                strVal = ""
                if elem1?.children.first is TextElement {
                    let elemText1:TextElement = elem1?.children.first as! TextElement
                    strVal = elemText1.text
                    
                }
                elemName = elem1!.name
                if elemName == "exitrentry" {
                    returnValue.exitrentry =  strVal
                }
                else if elemName == "extradays" {
                    returnValue.extradays =  strVal
                }
                else if elemName == "Error" {
                    returnValue.Error =  strVal
                }
                else if elemName == "PID" {
                    returnValue.PID =  strVal
                }
                else if elemName == "TotalSettlementAmount" {
                    returnValue.TotalSettlementAmount =  strVal
                }
                else if elemName == "DiffTicketAmount" {
                    returnValue.DiffTicketAmount =  strVal
                }
                else if elemName == "NetTicketPrice" {
                    returnValue.NetTicketPrice =  strVal
                }
                else if elemName == "TicketPercent" {
                    returnValue.TicketPercent =  strVal
                }
                else if elemName == "TicketAmount" {
                    returnValue.TicketAmount =  strVal
                }
                else if elemName == "TicketPrice" {
                    returnValue.TicketPrice =  strVal
                }
                else if elemName == "VNet" {
                    returnValue.VNet =  strVal
                }
                else if elemName == "VAllowances" {
                    returnValue.VAllowances =  strVal
                }
                else if elemName == "VTotal" {
                    returnValue.VTotal =  strVal
                }
                else if elemName == "VBasic" {
                    returnValue.VBasic =  strVal
                }
                else if elemName == "SNet" {
                    returnValue.SNet =  strVal
                }
                else if elemName == "STotal" {
                    returnValue.STotal =  strVal
                }
                else if elemName == "SAllowances" {
                    returnValue.SAllowances =  strVal
                }
                else if elemName == "SBasic" {
                    returnValue.SBasic =  strVal
                }
                else if elemName == "SDeduction" {
                    returnValue.SDeduction =  strVal
                }
                else if elemName == "Emp_Id" {
                    returnValue.Emp_Id = strVal.toInt()!
                }
                else if elemName == "Emp_Ename" {
                    returnValue.Emp_Ename =  strVal
                }
                else if elemName == "Emp_AName" {
                    returnValue.Emp_AName =  strVal
                }
                else if elemName == "Job_Num" {
                    returnValue.Job_Num =  strVal
                }
                else if elemName == "Job_English" {
                    returnValue.Job_English =  strVal
                }
                else if elemName == "Job_Arabic" {
                    returnValue.Job_Arabic =  strVal
                }
                else if elemName == "Sub_Job_Num" {
                    returnValue.Sub_Job_Num =  strVal
                }
                else if elemName == "Sub_Job_English" {
                    returnValue.Sub_Job_English =  strVal
                }
                else if elemName == "Sub_Job_Arabic" {
                    returnValue.Sub_Job_Arabic =  strVal
                }
                else if elemName == "Nationality_Num" {
                    returnValue.Nationality_Num =  strVal
                }
                else if elemName == "Nationality_English" {
                    returnValue.Nationality_English =  strVal
                }
                else if elemName == "Nationality_Arabic" {
                    returnValue.Nationality_Arabic =  strVal
                }
                else if elemName == "Manager_Id" {
                    returnValue.Manager_Id =  strVal
                }
                else if elemName == "Manager_English" {
                    returnValue.Manager_English =  strVal
                }
                else if elemName == "Manager_Arabic" {
                    returnValue.Manager_Arabic =  strVal
                }
                else if elemName == "Department_Num" {
                    returnValue.Department_Num =  strVal
                }
                else if elemName == "Department_English" {
                    returnValue.Department_English =  strVal
                }
                else if elemName == "JoinDate" {
                    returnValue.JoinDate =  strVal
                }
                else if elemName == "StartDate" {
                    returnValue.StartDate =  strVal
                }
                else if elemName == "Leave_Start_Dt" {
                    returnValue.Leave_Start_Dt =  strVal
                }
                else if elemName == "Leave_Return_Dt" {
                    returnValue.Leave_Return_Dt =  strVal
                }
                else if elemName == "Balance_Vacation" {
                    returnValue.Balance_Vacation =  strVal
                }
                else if elemName == "Number_Days" {
                    returnValue.Number_Days =  strVal
                }
                else if elemName == "ExitReEntry" {
                    returnValue.ExitReEntry =  strVal
                }
                else if elemName == "ExtraDays" {
                    returnValue.ExtraDays =  strVal
                }
                else if elemName == "Vac_Type" {
                    returnValue.Vac_Type =  strVal
                }
                else if elemName == "Vac_Desc" {
                    returnValue.Vac_Desc =  strVal
                }
                else if elemName == "SettlementAmount" {
                    returnValue.SettlementAmount =  strVal
                }
                else if elemName == "Dependent_Ticket" {
                    returnValue.Dependent_Ticket =  strVal
                }
            }
        }
        return returnValue
    }
    public func EmpVacFromXML(data: Data)-> EmpVac {
        
        let xmlToParse   = String.init(data: data, encoding: String.Encoding.utf8)!
        return EmpVacFromXMLString( xmlToParse : xmlToParse)
    }
    public func GetEmpVacationDetails(langid:Int, Emp_no:String)-> EmpVac{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<GetEmpVacationDetails xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "<Emp_no>"
        soapReqXML += Emp_no
        soapReqXML += "</Emp_no>"
        soapReqXML += "</GetEmpVacationDetails>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/GetEmpVacationDetails"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:EmpVac=EmpVacFromXML(data : responseData)
        return returnValue
    }
    public func GetEmpVacationTickets(emp_id:String, langId:Int)-> [DepVacTicket]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<GetEmpVacationTickets xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<langId>"
        soapReqXML += String(langId)
        soapReqXML += "</langId>"
        soapReqXML += "</GetEmpVacationTickets>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/GetEmpVacationTickets"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[DepVacTicket]=depVacTicketArrFromXML(data : responseData)
        return returnValue
    }
    public func BindVacationType_DDL(langid:Int)-> [EmpVac]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindVacationType_DDL xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "</BindVacationType_DDL>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindVacationType_DDL"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[EmpVac]=EmpVacArrFromXML(data : responseData)
        return returnValue
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
                        for elem in (elem1?.children)!{
                            let elemText:TextElement = elem as! TextElement
                            strVal += elemText.text
                        }
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

    public func SubmitEmpVacation(emp_no:String, delegateid:String, vacationtype:String, tickekreq:Int, settlementamt:Double, leavestartdate:String, leavertndate:String, numberofdays:String, dependenttck:String, exitreentry:Int, comment:String, error:String)-> EmpVac{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SubmitEmpVacation xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<emp_no>"
        soapReqXML += emp_no
        soapReqXML += "</emp_no>"
        soapReqXML += "<delegateid>"
        soapReqXML += delegateid
        soapReqXML += "</delegateid>"
        soapReqXML += "<vacationtype>"
        soapReqXML += vacationtype
        soapReqXML += "</vacationtype>"
        soapReqXML += "<tickekreq>"
        soapReqXML += String(tickekreq)
        soapReqXML += "</tickekreq>"
        soapReqXML += "<settlementamt>"
        soapReqXML += String(settlementamt)
        soapReqXML += "</settlementamt>"
        soapReqXML += "<leavestartdate>"
        soapReqXML += leavestartdate
        soapReqXML += "</leavestartdate>"
        soapReqXML += "<leavertndate>"
        soapReqXML += leavertndate
        soapReqXML += "</leavertndate>"
        soapReqXML += "<numberofdays>"
        soapReqXML += numberofdays
        soapReqXML += "</numberofdays>"
        soapReqXML += "<dependenttck>"
        soapReqXML += dependenttck
        soapReqXML += "</dependenttck>"
        soapReqXML += "<exitreentry>"
        soapReqXML += String(exitreentry)
        soapReqXML += "</exitreentry>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "<error>"
        soapReqXML += error
        soapReqXML += "</error>"
        soapReqXML += "</SubmitEmpVacation>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SubmitEmpVacation"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:EmpVac=EmpVacFromXML(data : responseData)
        return returnValue
    }
    public func get_settlement_details(vacationtype:String, langid:Int, emp_no:String, startdate:String, ticket:Int)-> EmpVac{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<get_settlement_details xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<vacationtype>"
        soapReqXML += vacationtype
        soapReqXML += "</vacationtype>"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "<emp_no>"
        soapReqXML += emp_no
        soapReqXML += "</emp_no>"
        soapReqXML += "<startdate>"
        soapReqXML += startdate
        soapReqXML += "</startdate>"
        soapReqXML += "<ticket>"
        soapReqXML += String(ticket)
        soapReqXML += "</ticket>"
        soapReqXML += "</get_settlement_details>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/get_settlement_details"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:EmpVac=EmpVacFromXML(data : responseData)
        return returnValue
    }
    public func save_settlement(emp_id:String, pid:String, sbasic:String, sallowances:String, stotal:String, snet:String, vbasic:String, vallowances:String, vtotal:String, vnet:String, ticketprice:String, ticketamount:String, ticketpercent:String, diffticketamount:String, netticketp:String, error:String)-> String{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<save_settlement xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<pid>"
        soapReqXML += pid
        soapReqXML += "</pid>"
        soapReqXML += "<sbasic>"
        soapReqXML += sbasic
        soapReqXML += "</sbasic>"
        soapReqXML += "<sallowances>"
        soapReqXML += sallowances
        soapReqXML += "</sallowances>"
        soapReqXML += "<stotal>"
        soapReqXML += stotal
        soapReqXML += "</stotal>"
        soapReqXML += "<snet>"
        soapReqXML += snet
        soapReqXML += "</snet>"
        soapReqXML += "<vbasic>"
        soapReqXML += vbasic
        soapReqXML += "</vbasic>"
        soapReqXML += "<vallowances>"
        soapReqXML += vallowances
        soapReqXML += "</vallowances>"
        soapReqXML += "<vtotal>"
        soapReqXML += vtotal
        soapReqXML += "</vtotal>"
        soapReqXML += "<vnet>"
        soapReqXML += vnet
        soapReqXML += "</vnet>"
        soapReqXML += "<ticketprice>"
        soapReqXML += ticketprice
        soapReqXML += "</ticketprice>"
        soapReqXML += "<ticketamount>"
        soapReqXML += ticketamount
        soapReqXML += "</ticketamount>"
        soapReqXML += "<ticketpercent>"
        soapReqXML += ticketpercent
        soapReqXML += "</ticketpercent>"
        soapReqXML += "<diffticketamount>"
        soapReqXML += diffticketamount
        soapReqXML += "</diffticketamount>"
        soapReqXML += "<netticketp>"
        soapReqXML += netticketp
        soapReqXML += "</netticketp>"
        soapReqXML += "<error>"
        soapReqXML += error
        soapReqXML += "</error>"
        soapReqXML += "</save_settlement>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/save_settlement"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
//        let strVal :String? = stringFromXML(data : responseData);
//        if strVal == nil {
//
//            return  ""
//        }
//        let returnValue:String = strVal!
        return ""
    }
    public func UpdateVisaReq(emp_id:String, dep_name:String, value:Int, error:String) -> String{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<UpdateVisaReq xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<dep_name>"
        soapReqXML += dep_name
        soapReqXML += "</dep_name>"
        soapReqXML += "<value>"
        soapReqXML += String(value)
        soapReqXML += "</value>"
        soapReqXML += "<error>"
        soapReqXML += error
        soapReqXML += "</error>"
        soapReqXML += "</UpdateVisaReq>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/UpdateVisaReq"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
//        let strVal :String? = stringFromXML(data : responseData);
//        if strVal == nil {
//
//            return  ""
//        }
//        let returnValue:String = strVal!
        return ""
    }
 }
