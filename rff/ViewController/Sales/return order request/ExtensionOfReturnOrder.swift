//
//  ExtensionOfReturnOrder.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 11/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

extension ReturnOrderRequestsViewController{
    // -- MARK: Helper Function
    
    func getCustomers(salesperson: String){
        customerArray = webservice.BindSalesReturnCustomers(salesperson: salesperson)
        if customerArray.isEmpty {
            customerNamesArray = ["Select customer".localize()]
        } else {
            customerNamesArray = ["Select customer".localize()]
            customerIdArray = [""]
            for customer in customerArray{
                customerNamesArray.append(customer.CustomerName)
                customerIdArray.append(customer.CustomerId)
            }
        }
    }
    
    func getStoreId(customerId: String){
        storeArray = webservice.BindDdlStore(customerid: customerId)
        if storeArray.isEmpty {
            storeIdArray = ["Select store id".localize()]
        } else {
            storeIdArray = ["Select store id".localize()]
            for store in storeArray{
                storeIdArray.append(store.StoreID)
            }
        }
    }
    
    func getCreditDetails(customerId: String){
        creditDetailsArray = webservice.SRR_BindCustomerAging(customer_no: customerId)
        if !creditDetailsArray.isEmpty{
            creditLimitRight.text = creditDetailsArray[0].CreditLimit
            totalDueRight.text = creditDetailsArray[0].TotalDue
            upTo31Right.text = creditDetailsArray[0].ZeroTo31Days
            upTo60Right.text = creditDetailsArray[0].ThirtyOneto60Days
            upTo90Right.text = creditDetailsArray[0].SixtyOneTo90Days
            upTo120Right.text = creditDetailsArray[0].Nineoneto120Days
            moreThan90Right.text = creditDetailsArray[0].Above120Days
            statusRight.text = creditDetailsArray[0].Status
            
            if creditDetailsArray[0].Status == "Above Credit"{
                statusRight.textColor = .red
            } else { statusRight.textColor = mainBackgroundColor }
        }
    }
    
    func getInvoiceNumber(salesperson_id: String, customernumber: String, invoice_date: String){
        invoiceArray = webservice.SRR_BindInvoice(salesperson_id: salesperson_id, customernumber: customernumber, invoice_date: invoice_date)
        invoiceNameArray = ["Select invoce"]
        if invoiceArray.isEmpty{
            invoiceNameArray = ["Select invoce"]
        } else {
            invoiceNameArray = ["Select invoce"]
            for invoice in invoiceArray{
                invoiceNameArray.append(invoice.Sop_Number)
            }
        }
    }
    
    func getItems(invoiceNumber: String){
        itemArray = webservice.SRR_BindItemsonChangeofInvoice(invoicenumber: invoiceNumber)
        if itemArray.isEmpty {
            itemNameArray = [" "]
        } else {
            itemNameArray = [" "]
            for item in itemArray{
                itemNameArray.append(item.Items)
            }
        }
    }
    
    func HandleValuesForSalesPerson(name: String, id: String){
        setDependentValuesToDefault()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        getCustomers(salesperson: id)
        customerTextField.text = customerNamesArray[0]
        customerPickerView.selectRow(0, inComponent: 0, animated: false)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func HandleValuesForCustomer(name: String, id: String){
        setDependentValuesToDefault()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        getStoreId(customerId: name)
        getCreditDetails(customerId: name)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func HandleValuesForInvoiceNo(name: String){
        itemTextField.text = itemNameArray[0]
        itemPickerView.selectRow(0, inComponent: 0, animated: false)
        getItems(invoiceNumber: name)
        invoiceTextField.text = name
        
        showInvoicePickerView.resignFirstResponder()
    }
    
    func HandleValuesForStore(name: String){
        if salesSelecteedRow == 0 {
            cityTextfield.text = "Select city".localize()
            salesPersonStoreTextfield.text = "Select sales person".localize()
            merchandiserTextfield.text = "Select merchandiser".localize()
        } else {
            cityArray = webservice.BindCity(storevalue: name, customer: customerNamesArray[customerRow])
            if !cityArray.isEmpty{
                cityTextfield.text = cityArray[0].City
                salesPersonStoreArray = webservice.BindSalesPersonforStore(
                    customer: customerNamesArray[customerRow],
                    city: cityArray[0].City,
                    store: name)
                if !salesPersonStoreArray.isEmpty{
                    salesPersonStoreTextfield.text = salesPersonStoreArray[0].SalesPersonStore
                    merchandiserArray = webservice.BindMerchandiser(
                        customer: customerNamesArray[customerRow],
                        city: cityArray[0].City,
                        store: name,
                        salesperson: salesPersonStoreArray[0].SalesPersonStore)
                    if !merchandiserArray.isEmpty{
                        merchandiserTextfield.text = merchandiserArray[0].Merchandiser
                    }
                }
            }
        }
    }
    
    func HandleValuesForCity(name: String){
        if  !cityArray.isEmpty{
            salesPersonStoreArray = webservice.BindSalesPersonforStore(
                customer: customerNamesArray[customerRow],
                city: name,
                store: storeIdArray[salesSelecteedRow])
            if !salesPersonStoreArray.isEmpty{
                salesPersonStoreTextfield.text = salesPersonStoreArray[0].SalesPersonStore
                merchandiserArray = webservice.BindMerchandiser(
                    customer: customerNamesArray[customerRow],
                    city: name,
                    store: storeIdArray[salesSelecteedRow],
                    salesperson: salesPersonStoreArray[0].SalesPersonStore)
                if !merchandiserArray.isEmpty{
                    merchandiserTextfield.text = merchandiserArray[0].Merchandiser
                }
            }
        }
        
        cityTextfield.text = cityArray.isEmpty ? "Select city".localize() : name
        showCityPickerViewTextfield.resignFirstResponder()
    }
    
    func HandleValuesForSalesPersonStore(name: String){
        if !salesPersonStoreArray.isEmpty{
            merchandiserArray = webservice.BindMerchandiser(
                customer: customerNamesArray[customerRow],
                city: cityArray[citySelectedRow].City,
                store: storeIdArray[salesSelecteedRow],
                salesperson: name)
            if !merchandiserArray.isEmpty{
                merchandiserTextfield.text = merchandiserArray[0].Merchandiser
            }
        }
        
        salesPersonStoreTextfield.text = salesPersonStoreArray.isEmpty ? "Select sales person".localize() : name
        showSalesPersonPickerViewTextfield.resignFirstResponder()
    }
    
    func HandleValuesForMerchandiser(name: String){
        merchandiserTextfield.text = merchandiserArray.isEmpty ? "Select merchandiser".localize() : name
        showMerchandiserPickerViewTextfield.resignFirstResponder()
    }
    
    
}











