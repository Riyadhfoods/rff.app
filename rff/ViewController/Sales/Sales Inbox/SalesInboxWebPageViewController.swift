//
//  SalesInboxWebPageViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 06/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit
import WebKit

class SalesInboxWebPageViewController: UIViewController {

    var urlString: String = ""
    let ExpTime = TimeInterval(60 * 60 * 24 * 365)
    
    @IBOutlet weak var salesInboxWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("url string is \(urlString)")
        
        if let url = URL(string: urlString){
            let request = URLRequest(url: url)
            salesInboxWebView.load(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
