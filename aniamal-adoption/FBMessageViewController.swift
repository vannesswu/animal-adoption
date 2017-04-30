//
//  FBMessageViewController.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/4/28.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import Foundation
import UIKit

class FBMessageViewController:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFBView()
    }
    
    var url = ""
    
    let fbView = UIWebView()
    
    func setupFBView() {
        view.addSubview(fbView)
        fbView.fillSuperview()
        let url = NSURL(string:"https://www.facebook.com/\(self.url)")
        let urlRequest = URLRequest(url: url! as URL)
        fbView.loadRequest(urlRequest)

    }
    
    
}
