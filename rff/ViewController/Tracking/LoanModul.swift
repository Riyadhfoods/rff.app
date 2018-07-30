//
//  LoanModul.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 28/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

struct EmployeeDetails{
    var Emp_Name: String
    var Join_Date: String
    var Start_Date: String
    var Company: String
    var Manager: String
    var Job_Desc: String
    var Sub_JobDesc: String
    var Department: String
    var Nationality: String
    var Basic_Sal: String
    var Package: String
}

struct LastLoan{
    var L_Date: String
    var L_StartDate: String
    var L_Guarantor: String
    var L_LoanType: String
    var L_Amount: String
    var L_MonthlyPay: String
    var L_DeductedValue: String
    var L_BalAmount: String
}

struct LoanDetails{
    var LoanType: String
    var CreatedDate: String
    var AmountRequired: String
    var Guarantor_Name: String
    var PayPeriod: String
    var Monthly_Pay: String
}
