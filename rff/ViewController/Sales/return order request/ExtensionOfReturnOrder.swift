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
    }
    
    func getStoreId(customerId: String){
        storeArray = webservice.commonSalesService.BindDdlStore(customerid: customerId)
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
            totalDueRight.text = creditDetailsArray[0].ToTalDue
            upTo31Right.text = creditDetailsArray[0].ZEROTO31days
            upTo60Right.text = creditDetailsArray[0].ThirtyOneTo60Days
            upTo90Right.text = creditDetailsArray[0].SIXTYOneTo90Days
            upTo120Right.text = creditDetailsArray[0].NINETYOneTo120Days
            moreThan90Right.text = creditDetailsArray[0].Above120DAYS
            statusRight.text = creditDetailsArray[0].CustomerAgying_Status
            
            if creditDetailsArray[0].CustomerAgying_Status == "Above Credit"{
                statusRight.textColor = .red
            } else { statusRight.textColor = mainBackgroundColor }
        }
    }
    
    func getInvoiceNumber(salesperson_id: String, customernumber: String, invoice_date: String){
        start()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            
            self.invoiceArray = self.webservice.SRR_BindInvoice(salesperson_id: salesperson_id, customernumber: customernumber, invoice_date: invoice_date)
            self.invoiceNameArray = ["Select invoce"]
            if self.invoiceArray.isEmpty{
                self.invoiceNameArray = ["Select invoce"]
            } else {
                self.invoiceNameArray = ["Select invoce"]
                for invoice in self.invoiceArray{
                    self.invoiceNameArray.append(invoice.Sop_Number)
                }
            }
            self.stop()
            
        }
    }
    
    func getItems(invoiceNumber: String){
        start()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            
            self.itemArray = self.webservice.SRR_BindItemsonChangeofInvoice(invoicenumber: invoiceNumber)
            if self.itemArray.isEmpty {
                self.itemNameArray = [" "]
            } else {
                self.itemNameArray = [" "]
                for item in self.itemArray{
                    self.itemNameArray.append(item.Items)
                }
            }
            self.stop()
            
        }
    }
    
    func HandleValuesForSalesPerson(name: String, id: String){
        setDependentValuesToDefault()
        
        start()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.getCustomers(salesperson: id)
            self.customerTextField.text = "Select customer".localize()
            self.setUpDefaultValueForStore()
            self.storeStackView.isHidden = true
            self.viewHolder.isHidden = true
            self.stop()
        }
    }
    
    func HandleValuesForCustomer(name: String, id: String){
        setDependentValuesToDefault()
        
        start()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.getStoreId(customerId: name)
            self.getCreditDetails(customerId: name)
            self.stop()
        }
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
            cityArray = webservice.commonSalesService.BindCity(storevalue: name, customer: customerName)
            if !cityArray.isEmpty{
                cityTextfield.text = cityArray[0].City
                salesPersonStoreArray = webservice.commonSalesService.BindSalesPersonforStore(
                    customer: customerName,
                    city: cityArray[0].City,
                    store: name)
                if !salesPersonStoreArray.isEmpty{
                    salesPersonStoreTextfield.text = salesPersonStoreArray[0].SalesPersonStore
                    merchandiserArray = webservice.commonSalesService.BindMerchandiser(
                        customer: customerName,
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
            salesPersonStoreArray = webservice.commonSalesService.BindSalesPersonforStore(
                customer: customerName,
                city: name,
                store: storeIdArray[salesSelecteedRow])
            if !salesPersonStoreArray.isEmpty{
                salesPersonStoreTextfield.text = salesPersonStoreArray[0].SalesPersonStore
                merchandiserArray = webservice.commonSalesService.BindMerchandiser(
                    customer: customerName,
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
            merchandiserArray = webservice.commonSalesService.BindMerchandiser(
                customer: customerName,
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











