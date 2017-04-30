//
//  handleingView.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/4/29.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import Foundation
import UIKit

class HandleingViewController:UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHandleingView()
    }
    
    let textLabel = UILabel()
    let spinner = UIActivityIndicatorView.spinner

    func setupHandleingView() {
        
        textLabel.text = "資料搜尋中請稍候..."
        view.addSubview(textLabel)
        view.addSubview(spinner)
        
        textLabel.anchorCenterSuperview()
        spinner.anchor(nil, left: textLabel.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        
        spinner.startAnimating()
        
        
        
        
    }
    
    
    
}
