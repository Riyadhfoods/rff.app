//
//  FilePreviewViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 08/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit
import QuickLook

class FilePreviewViewController: UIViewController, QLPreviewControllerDataSource {

    let previewController = QLPreviewController()
    var urlReceived: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewController.dataSource = self
        present(previewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        guard let url = urlReceived else {
            fatalError("Could not load \(urlReceived?.lastPathComponent ?? "file")")
        }
        
        return url as QLPreviewItem
    }

}
