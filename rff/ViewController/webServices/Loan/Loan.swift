import Foundation
public class Loan {
    public var Url:String = "http://82.118.166.164/ios_hrms/loan.asmx"
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
        do{
            let xml = SWXMLHash.lazy(xmlToParse)
            let xmlResponse : XMLIndexer? = xml.children.first?.children.first?.children.first
            let xmlResult: XMLIndexer?  = xmlResponse?.children.last
            
            let xmlElement = xmlResult?.element
            let _ = xmlElement?.text
            let xmlElementFirst = xmlElement?.children[0] as!TextElement
            return xmlElementFirst.text
        }
        //return ""
    }
    
    func stringFromXML(data:Data)-> String{
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
  
    public func EmpLoanArrFromXMLString(xmlToParse:String)->[EmpLoan] {
        
        let xml = SWXMLHash.lazy(xmlToParse)
        let xmlRoot = xml.children.first
        let _ = xmlRoot?.children.last
        let xmlResponse: XMLIndexer? = xml.children.first?.children.first?.children.first
        let xmlResult0: XMLIndexer?  = xmlResponse?.children.last
        var strVal = ""
        var elemName = ""
        var returnValue:[EmpLoan] = [EmpLoan]()
        if elemName == "" {
            // Array Property For returnValue
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let rItem1 = EmpLoan()
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
                    if elemName == "error" {
                        rItem1.error =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Emp_ID" {
                        rItem1.Emp_ID =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Emp_Name" {
                        rItem1.Emp_Name =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Join_Date" {
                        rItem1.Join_Date =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Start_Date" {
                        rItem1.Start_Date =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Company" {
                        rItem1.Company =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Manager" {
                        rItem1.Manager =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Job_Desc" {
                        rItem1.Job_Desc =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SubJob_Desc" {
                        rItem1.SubJob_Desc =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Department" {
                        rItem1.Department =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Nationality" {
                        rItem1.Nationality =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Basic_Sal" {
                        rItem1.Basic_Sal =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Package" {
                        rItem1.Package =  strVal
                    }
                }
                returnValue.append(rItem1)
            }
        }
        return returnValue
    }
    
    public func EmpLoanArrFromXML(data: Data)-> [EmpLoan] {
        let xmlToParse   = String.init(data: data, encoding: String.Encoding.utf8)!
        return EmpLoanArrFromXMLString( xmlToParse : xmlToParse)
    }
    
    public func BindEmployees(emp_number:String, lang:Int)-> [EmpLoan]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindEmployees xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<emp_number>"
        soapReqXML += emp_number
        soapReqXML += "</emp_number>"
        soapReqXML += "<lang>"
        soapReqXML += String(lang)
        soapReqXML += "</lang>"
        soapReqXML += "</BindEmployees>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindEmployees"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[EmpLoan]=EmpLoanArrFromXML(data : responseData)
        return returnValue
    }
    
    public func GetEmpDetails(emp_number:String, lang:Int)-> [EmpLoan]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<GetEmpDetails xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<emp_number>"
        soapReqXML += emp_number
        soapReqXML += "</emp_number>"
        soapReqXML += "<lang>"
        soapReqXML += String(lang)
        soapReqXML += "</lang>"
        soapReqXML += "</GetEmpDetails>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/GetEmpDetails"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[EmpLoan]=EmpLoanArrFromXML(data : responseData)
        return returnValue
    }
    
    public func SubmitEmpLoan(login_emp_number:String, guarantor:String, loan_empnumber:String, loantype:String, paymentperiod:String, Amt_Required:String, comment:String)-> [EmpLoan]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SubmitEmpLoan xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<login_emp_number>"
        soapReqXML += login_emp_number
        soapReqXML += "</login_emp_number>"
        soapReqXML += "<guarantor>"
        soapReqXML += guarantor
        soapReqXML += "</guarantor>"
        soapReqXML += "<loan_empnumber>"
        soapReqXML += loan_empnumber
        soapReqXML += "</loan_empnumber>"
        soapReqXML += "<loantype>"
        soapReqXML += loantype
        soapReqXML += "</loantype>"
        soapReqXML += "<paymentperiod>"
        soapReqXML += paymentperiod
        soapReqXML += "</paymentperiod>"
        soapReqXML += "<Amt_Required>"
        soapReqXML += Amt_Required
        soapReqXML += "</Amt_Required>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "</SubmitEmpLoan>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SubmitEmpLoan"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[EmpLoan]=EmpLoanArrFromXML(data : responseData)
        return returnValue
    }
}
