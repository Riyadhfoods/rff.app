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
    let webservice = SalesOrderRequestService.instance
    var count: Int = 0
    var delegate: ItemCountAddedDelegate?
    var unoits = [unitOfMeasurementModel]()
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
        emptyMessage(viewController: self, tableView: itemsTableView, isEmpty: itemAddedArray.count == 0)
        return itemAddedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ItemsSelectedCell{
            
            let row = indexPath.row
            let item = itemAddedArray[row]
            cell.unoits = webservice.BindSalesOrderUnitofMeasure(itemid: item.Grid_Desc)
            
            cell.num.text = "\(indexPath.row + 1)"
            cell.desc.text = item.Grid_Desc
            cell.PCSTextfield.text = item.Grid_UOM
            cell.qtyTextfield.text = item.Grid_Qty
            cell.unitPriceTextfield.text = item.Grid_UnitPrice
            cell.totalPrice.text = item.Grid_TotalPrice
            
            cell.deleteButton.tag = row
            cell.deleteButton.addTarget(self, action: #selector(handleDeleteAction(sender:)), for: .touchUpInside)
            cell.indexpathRow = row
            
            cell.qtyTextfield.tag = row
            cell.unitPriceTextfield.tag = row
            cell.delegate = self
            
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


