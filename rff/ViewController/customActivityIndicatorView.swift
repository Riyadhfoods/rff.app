//
//  customActivityIndicatorView.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 01/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class customActivityIndicatorView: UIView {

    @IBOutlet weak var superView: UIView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    private func setUpView(){
        Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)
        addSubview(superView)
        backgroundColor = UIColor.white.withAlphaComponent(0.95)
        superView.frame = self.bounds
        superView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": superView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": superView]))
        holderView.layer.cornerRadius = 5
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0).cgColor
        activityIndicator.startAnimating()
    }

}
