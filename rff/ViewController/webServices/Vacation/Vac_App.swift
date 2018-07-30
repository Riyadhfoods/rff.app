 import Foundation 
 public class Vac_App {
    public var Url:String = "http://82.118.166.164/ios_hrms/approvals/vac_app.asmx"
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
    
    public func Vac_AppArrFromXMLString(xmlToParse:String)->[VacAppModul] {
        
        let xml = SWXMLHash.lazy(xmlToParse)
        let xmlRoot = xml.children.first
        let _ = xmlRoot?.children.last
        let xmlResponse: XMLIndexer? = xml.children.first?.children.first?.children.first
        let xmlResult0: XMLIndexer?  = xmlResponse?.children.last
        var strVal = ""
        var elemName = ""
        var returnValue:[VacAppModul] = [VacAppModul]()
        if elemName == "" {
            // Array Property For returnValue
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let rItem1 = VacAppModul()
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
                    if elemName == "Cmt_Name" {
                        rItem1.Cmt_Name =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Cmt_Comment" {
                        rItem1.Cmt_Comment =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "WorkFlow_Empid" {
                        rItem1.WorkFlow_Empid =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "WorkFlow_EmpName" {
                        rItem1.WorkFlow_EmpName =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "WorkFlow_EmpRole" {
                        rItem1.WorkFlow_EmpRole =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "WorkFlow_EmpStatus" {
                        rItem1.WorkFlow_EmpStatus =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "WorkFlow_EmpTransDate" {
                        rItem1.WorkFlow_EmpTransDate =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "S_BasicSal" {
                        rItem1.S_BasicSal =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "S_Allowances" {
                        rItem1.S_Allowances =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "S_Total" {
                        rItem1.S_Total =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "S_DeductAmount" {
                        rItem1.S_DeductAmount =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "S_NetAmount" {
                        rItem1.S_NetAmount =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "V_BasicSal" {
                        rItem1.V_BasicSal =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "V_Allowances" {
                        rItem1.V_Allowances =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "V_Total" {
                        rItem1.V_Total =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "V_DeductAmount" {
                        rItem1.V_DeductAmount =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "V_NetAmount" {
                        rItem1.V_NetAmount =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Tck_Price" {
                        rItem1.Tck_Price =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Tck_Amount" {
                        rItem1.Tck_Amount =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Tck_Percent1" {
                        rItem1.Tck_Percent1 =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Tck_DeductAmount" {
                        rItem1.Tck_DeductAmount =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Tck_NetAmount" {
                        rItem1.Tck_NetAmount =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Deduction_Grid_ID" {
                        rItem1.Deduction_Grid_ID =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Deduction_Grid_DeductionType" {
                        rItem1.Deduction_Grid_DeductionType =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Deduction_Grid_DeductibleAmount" {
                        rItem1.Deduction_Grid_DeductibleAmount =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Salary_Deduction" {
                        rItem1.Salary_Deduction =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "NumberofDays" {
                        rItem1.NumberofDays =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "LeaveStartDate" {
                        rItem1.LeaveStartDate =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "ReturnDate" {
                        rItem1.ReturnDate =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "RequestDate" {
                        rItem1.RequestDate =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "VacationType" {
                        rItem1.VacationType =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "ExitReEntry" {
                        rItem1.ExitReEntry =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "ExitReEntryDays" {
                        rItem1.ExitReEntryDays =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "VacTypeAdmin" {
                        rItem1.VacTypeAdmin =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "VacationDays" {
                        rItem1.VacationDays =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "TicketRequired" {
                        rItem1.TicketRequired =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Vacation_Number" {
                        rItem1.Vacation_Number =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Requested" {
                        rItem1.Requested =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Total_SettlementAmount" {
                        rItem1.Total_SettlementAmount =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "EmpName" {
                        rItem1.EmpName =  strVal
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
                    else if elemName == "ManagerName" {
                        rItem1.ManagerName =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "JobDesc" {
                        rItem1.JobDesc =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SubJobDesc" {
                        rItem1.SubJobDesc =  strVal
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
                    else if elemName == "City" {
                        rItem1.City =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "VacationDays_Details" {
                        rItem1.VacationDays_Details =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Used_Details" {
                        rItem1.Used_Details =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Remaining_Detail" {
                        rItem1.Remaining_Detail =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Name_Companion" {
                        rItem1.Name_Companion =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "City_Companion" {
                        rItem1.City_Companion =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "DOB_Companion" {
                        rItem1.DOB_Companion =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "VisaRequest_Companion" {
                        rItem1.VisaRequest_Companion =  strVal
                    }
                    
                }
                returnValue.append(rItem1)
            }
        }
        return returnValue
    }
    
    public func Vac_AppArrFromXML(data: Data)-> [VacAppModul] {
        
        let xmlToParse   = String.init(data: data, encoding: String.Encoding.utf8)!
        return Vac_AppArrFromXMLString( xmlToParse : xmlToParse)
    }
    
    public func GetData(langid:Int, pid:String, emp_number:String)-> [VacAppModul]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<GetData xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "<pid>"
        soapReqXML += pid
        soapReqXML += "</pid>"
        soapReqXML += "<emp_number>"
        soapReqXML += emp_number
        soapReqXML += "</emp_number>"
        soapReqXML += "</GetData>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/GetData"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[VacAppModul]=Vac_AppArrFromXML(data : responseData)
        return returnValue
    }
    
    public func get_settlement_details(langid:Int, emp_number:String, pid:String)-> [VacAppModul]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<get_settlement_details xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "<emp_number>"
        soapReqXML += emp_number
        soapReqXML += "</emp_number>"
        soapReqXML += "<pid>"
        soapReqXML += pid
        soapReqXML += "</pid>"
        soapReqXML += "</get_settlement_details>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/get_settlement_details"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[VacAppModul]=Vac_AppArrFromXML(data : responseData)
        return returnValue
    }
    
    public func BindApproversGrid(formid:Int, pid:String, langid: Int)-> [VacAppModul]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindApproversGrid xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<formid>"
        soapReqXML += String(formid)
        soapReqXML += "</formid>"
        soapReqXML += "<pid>"
        soapReqXML += pid
        soapReqXML += "</pid>"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "</BindApproversGrid>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindApproversGrid"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[VacAppModul]=Vac_AppArrFromXML(data : responseData)
        return returnValue
    }
    
    public func BindCommentGrid(pid:String, fid:Int, gvApp_RowCount:Int)-> [VacAppModul]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindCommentGrid xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<pid>"
        soapReqXML += pid
        soapReqXML += "</pid>"
        soapReqXML += "<fid>"
        soapReqXML += String(fid)
        soapReqXML += "</fid>"
        soapReqXML += "<gvApp_RowCount>"
        soapReqXML += String(gvApp_RowCount)
        soapReqXML += "</gvApp_RowCount>"
        soapReqXML += "</BindCommentGrid>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindCommentGrid"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[VacAppModul]=Vac_AppArrFromXML(data : responseData)
        return returnValue
    }
    
    public func Approve_Vacation(vac_number:String, Emp_ID:String, fid:String, pid:String, comment:String, buttonType:String, FormId:Int, Comment:String, grid_empid:String, totalgrd_rows:Int?, login_empId:String, finalApp_EmpId:String, finalApp_Status:String)-> String{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Approve_Vacation xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<vac_number>"
        soapReqXML += vac_number
        soapReqXML += "</vac_number>"
        soapReqXML += "<Emp_ID>"
        soapReqXML += Emp_ID
        soapReqXML += "</Emp_ID>"
        soapReqXML += "<fid>"
        soapReqXML += fid
        soapReqXML += "</fid>"
        soapReqXML += "<pid>"
        soapReqXML += pid
        soapReqXML += "</pid>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "<buttonType>"
        soapReqXML += buttonType
        soapReqXML += "</buttonType>"
        soapReqXML += "<FormId>"
        soapReqXML += String(FormId)
        soapReqXML += "</FormId>"
        soapReqXML += "<Comment>"
        soapReqXML += Comment
        soapReqXML += "</Comment>"
        soapReqXML += "<grid_empid>"
        soapReqXML += grid_empid
        soapReqXML += "</grid_empid>"
        soapReqXML += "<totalgrd_rows"
        
        if totalgrd_rows == nil {
            soapReqXML += "xsi:nil=\"true\" />"
        }
        else {
            soapReqXML += ">"
            soapReqXML += (totalgrd_rows == nil ?"":String( totalgrd_rows! ) )
            soapReqXML += "</totalgrd_rows>"
        }
        
        soapReqXML += "<login_empId>"
        soapReqXML += login_empId
        soapReqXML += "</login_empId>"
        soapReqXML += "<finalApp_EmpId>"
        soapReqXML += finalApp_EmpId
        soapReqXML += "</finalApp_EmpId>"
        soapReqXML += "<finalApp_Status>"
        soapReqXML += finalApp_Status
        soapReqXML += "</finalApp_Status>"
        soapReqXML += "</Approve_Vacation>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/Approve_Vacation"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let strVal :String? = stringFromXML(data : responseData);
        if strVal == nil {
            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    
    public func Update_ApprovalGrid(buttonType:String, fid:Int, pid:String, comment:String, grid_empid:String, totalgrd_rows:Int?, login_empId:String){
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Update_ApprovalGrid xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<buttonType>"
        soapReqXML += buttonType
        soapReqXML += "</buttonType>"
        soapReqXML += "<fid>"
        soapReqXML += String(fid)
        soapReqXML += "</fid>"
        soapReqXML += "<pid>"
        soapReqXML += pid
        soapReqXML += "</pid>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "<grid_empid>"
        soapReqXML += grid_empid
        soapReqXML += "</grid_empid>"
        soapReqXML += "<totalgrd_rows"
        if totalgrd_rows == nil {
            soapReqXML += "xsi:nil=\"true\" />"
        }
            
        else {
            soapReqXML += ">"
            soapReqXML += (totalgrd_rows == nil ?"":String( totalgrd_rows! ) )
            soapReqXML += "</totalgrd_rows>"
        }
        soapReqXML += "<login_empId>"
        soapReqXML += login_empId
        soapReqXML += "</login_empId>"
        soapReqXML += "</Update_ApprovalGrid>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/Update_ApprovalGrid"
        
        let _ = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
    }
 }
