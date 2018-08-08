//
//  AttachmentReturnViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 03/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class AttachmentReturnViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIDocumentInteractionControllerDelegate {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var attachmentTableView: UITableView!
    
    // -- MARK: Variables
    
    let cellId = "cell_attachmentReturn"
    var attachmentArray = [ReturnApproveAttachment]()
    var url : URL?
    var docController : UIDocumentInteractionController?
    
    // -- MARK: viewDidLaod
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Attachment Files".localize()
        docController?.delegate = self
        setViewAlignment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: TableView data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyMessage(viewController: self, tableView: attachmentTableView, isEmpty: true)
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? AttachmentReturnCell{
            
            let attachment = attachmentArray[indexPath.row]
            cell.indexLabel.text = attachment.INDEX
            cell.filenemeLabel.text = attachment.FILENAME
            cell.filetypeLabel.text = attachment.FILETYPE
            cell.showAttachmentFile.addTarget(self, action: #selector(showAttachmentFileButtonTapped(sender:)), for: .touchUpInside)
            cell.showAttachmentFile.tag = indexPath.row
            
            return cell
        }
        return UITableViewCell()
    }
    
    @objc func showAttachmentFileButtonTapped(sender: UIButton){
//        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(attachmentArray[sender.tag].FILENAME)
//        self.docController = UIDocumentInteractionController(url: fileURL)
//        docController?.presentPreview(animated: true)
    }
    
}
