//
//  ItemsSelectedViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 07/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

protocol ItemCountAddedDelegate {
    func setCount(count: Int)
}

class ItemsSelectedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    // -- MARK: Variables
    
    let cellId = "cell_addedItem"
    let webservice = Sales()
    var count: Int = 0
    var delegate: ItemCountAddedDelegate?
    var unoits = [SalesModel]()
    var itemSentStatus = [SalesModel]()
    var sentStatus = [SalesModel]()
    var error: String = ""
    
    // -- MARk: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Items".localize()
        setViewAlignment()
        setDelegate()
    }
    
    func setDelegate(){
        if delegate != nil{
            delegate?.setCount(count: itemAddedArray.count)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // -- MARK: Tableview data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if itemAddedArray.count == 0 {
            emptyMessage(message: "No data".localize(), viewController: self, tableView: itemsTableView)
        }
        return itemAddedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ItemsSelectedCell{
            cell.unoits = webservice.BindSalesOrderUnitofMeasure(itemid: itemAddedArray[indexPath.row].Grid_Desc)
            
            cell.num.text = "\(indexPath.row + 1)"
            cell.desc.text = itemAddedArray[indexPath.row].Grid_Desc
            cell.PCSTextfield.text = itemAddedArray[indexPath.row].Grid_UOM
            cell.qtyTextfield.text = itemAddedArray[indexPath.row].Grid_Qty
            cell.unitPriceTextfield.text = itemAddedArray[indexPath.row].Grid_UnitPrice
            cell.totalPrice.text = itemAddedArray[indexPath.row].Grid_TotalPrice
            
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(handleDeleteAction(sender:)), for: .touchUpInside)
            cell.indexpathRow = indexPath.row
            
            cell.qtyTextfield.tag = indexPath.row
            cell.unitPriceTextfield.tag = indexPath.row
            
            return cell
        }
        return UITableViewCell()
    }
    
    @objc func handleDeleteAction(sender: UIButton){
        itemAddedArray.remove(at: sender.tag)
        itemsTableView.reloadData()
        setDelegate()
    }
    
    // -- MARK: IBOutlets
    
}

extension ItemsSelectedViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers(onShow: { frame in
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height - 81, right: 0)
            self.itemsTableView.contentInset = contentInset
        }, onHide: { _ in
            self.itemsTableView.contentInset = UIEdgeInsets.zero
        })
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
}


