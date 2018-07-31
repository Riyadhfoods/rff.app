//
//  LoanData.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 28/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation
class LoanData{
    static let shared = LoanData()
    private var LoanType : String = ""
    private var Emp_ID : String = ""
    private var AmountRequired : String = ""
    private var Guarantor_Name : String = ""
    private var PayPeriod : String = ""
    private var Monthly_Pay : String = ""
    private var CreatedDate : String = ""
    private var Emp_Name : String = ""
    private var L_LoanType : String = ""
    private var Join_Date : String = ""
    private var Start_Date : String = ""
    private var Company : String = ""
    private var Manager : String = ""
    private var Job_Desc : String = ""
    private var Sub_JobDesc : String = ""
    private var Department : String = ""
    private var Nationality : String = ""
    private var Basic_Sal : String = ""
    private var Package : String = ""
    var prevLoanArray = [LastLoan]()
    
    func setEmployeeDetails(empLoan: LoanApprovalModul) -> EmployeeDetails{
        Emp_Name = Emp_Name == "" ? empLoan.Emp_Name : Emp_Name
        Join_Date = Join_Date == "" ? empLoan.Join_Date : Join_Date
        Start_Date = Start_Date == "" ? empLoan.Start_Date : Start_Date
        Company = Company == "" ? empLoan.Company : Company
        Manager = Manager == "" ? empLoan.Manager : Manager
        Job_Desc = Job_Desc == "" ? empLoan.Job_Desc : Job_Desc
        Sub_JobDesc = Sub_JobDesc == "" ? empLoan.Sub_JobDesc : Sub_JobDesc
        Department = Department == "" ? empLoan.Department : Department
        Nationality = Nationality == "" ? empLoan.Nationality : Nationality
        Basic_Sal = Basic_Sal == "" ? empLoan.Basic_Sal : Basic_Sal
        Package = Package == "" ? empLoan.Package : Package
        
        return EmployeeDetails(Emp_Name: Emp_Name,
                        Join_Date: Join_Date,
                        Start_Date: Start_Date,
                        Company: Company,
                        Manager: Manager,
                        Job_Desc: Job_Desc,
                        Sub_JobDesc: Sub_JobDesc,
                        Department: Department,
                        Nationality: Nationality,
                        Basic_Sal: Basic_Sal,
                        Package: Package)
    }
    
    func getLastLoan(empLoan: LoanApprovalModul) -> [LastLoan]{
        
        if empLoan.L_Date != ""{
            prevLoanArray.append(LastLoan(L_Date: empLoan.L_Date,
                                          L_StartDate: empLoan.L_StartDate,
                                          L_Guarantor: empLoan.L_Guarantor,
                                          L_LoanType: empLoan.L_LoanType,
                                          L_Amount: empLoan.L_Amount,
                                          L_MonthlyPay: empLoan.L_MonthlyPay,
                                          L_DeductedValue: empLoan.L_DeductedValue,
                                          L_BalAmount: empLoan.L_BalAmount))
        }
        return prevLoanArray
    }
    
    func getLoanDetails(empLoan: LoanApprovalModul) -> LoanDetails{
        LoanType = LoanType == "" ? empLoan.LoanType : LoanType
        CreatedDate = CreatedDate == "" ? empLoan.CreatedDate : CreatedDate
        AmountRequired = AmountRequired == "" ? empLoan.AmountRequired : AmountRequired
        Guarantor_Name = Guarantor_Name == "" ? empLoan.Guarantor_Name : Guarantor_Name
        PayPeriod = PayPeriod == "" ? empLoan.PayPeriod : PayPeriod
        Monthly_Pay = Monthly_Pay == "" ? empLoan.Monthly_Pay : Monthly_Pay
        
        return LoanDetails(LoanType: LoanType,
                    CreatedDate: CreatedDate,
                    AmountRequired: AmountRequired,
                    Guarantor_Name: Guarantor_Name,
                    PayPeriod: PayPeriod,
                    Monthly_Pay: Monthly_Pay)
    }
    
    func setValueToDefault(){
        LoanType = ""
        Emp_ID = ""
        AmountRequired = ""
        Guarantor_Name = ""
        PayPeriod  = ""
        Monthly_Pay = ""
        CreatedDate = ""
        Emp_Name = ""
        L_LoanType = ""
        Join_Date  = ""
        Start_Date = ""
        Company = ""
        Manager  = ""
        Job_Desc = ""
        Sub_JobDesc = ""
        Department = ""
        Nationality = ""
        Basic_Sal = ""
        Package = ""
        prevLoanArray = [LastLoan]()
    }
    
}












