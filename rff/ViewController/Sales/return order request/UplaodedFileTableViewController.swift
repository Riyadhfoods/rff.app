//
//  UplaodedFileTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 07/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit
import QuickLook

class UplaodedFileTableViewController: UITableViewController{

    let cellId = "cell_uploadFile"
    var indexSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fileInfo.count == 0 {
            emptyMessage(message: "No Data", viewController: self, tableView: tableView)
        }
        return fileInfo.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? UploadedFileCell{
            let fileInfoRow = fileInfo[indexPath.row]
            
            if fileInfoRow.image != nil{
                if fileInfoRow.fileName == ""{
                    cell.fileName.text = fileInfoRow.imageUrl?.lastPathComponent
                } else {
                    cell.fileName.text = fileInfoRow.imageName
                }
            } else {
                cell.fileName.text = fileInfoRow.fileName
            }
            
            cell.viewFile.addTarget(self, action: #selector(viewButtonCTapped(sender:)), for: .touchUpInside)
            cell.viewFile.tag = indexPath.row
            
            return cell
        }
        return UITableViewCell()
    }
    
    
    var urlSent: URL?
    @objc func viewButtonCTapped(sender: UIButton){
        performSegue(withIdentifier: "showFilePreview", sender: nil)
        
        let fileInfoRow = fileInfo[sender.tag]
        if fileInfoRow.imageUrl != nil{
            urlSent = fileInfoRow.imageUrl
        } else {
            urlSent = fileInfoRow.filePath
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFilePreview"{
            if let vc = segue.destination as? FilePreviewViewController{
                vc.urlReceived = urlSent
            }
        }
    }

}
