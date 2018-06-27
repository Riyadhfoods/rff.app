//
//  WorkFlowReturnViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class WorkFlowReturnViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // -- MARK: IBOutlet
    
    @IBOutlet weak var workFlowReturnTableview: UITableView!
    
    
    // -- MARK: Variable
    
    let screenSize = AppDelegate().screenSize
    let cellId = "cell_workFlowReturn"
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewAlignment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? WorkFlowReturnCell{
            
            return cell
        }
        return UITableViewCell()
    }

}
