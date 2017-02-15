//
//  adoptShelterView.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/2/15.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import Foundation
import UIKit

class AdoptShelterView : NoteBaseView {
    
    override init() {
        super.init()
    }
    var webView:UIWebView!
    let adress:String = "http://animal-adoption.coa.gov.tw/index.php/mobile/shelter/index/2"
    var myActivityIndicator = UIActivityIndicatorView.spinner
    override func showup() {
        super.showup()
        webView = UIWebView()
        webView.delegate = self
        blackView.addSubview(webView)
        blackView.addSubview(myActivityIndicator)
        webView.anchor(popView.topAnchor, left: popView.leftAnchor, bottom: nil, right: popView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 40, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        myActivityIndicator.anchorCenterSuperview()
        blackView.addSubview(dismissButton)
        dismissButton.anchor(webView.bottomAnchor, left: popView.leftAnchor, bottom: popView.bottomAnchor, right: popView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        myActivityIndicator.startAnimating()
        webViewStartLoading()
        
    }
    
    func webViewStartLoading() {
        let url = NSURL(string:adress)
        let urlRequest = URLRequest(url: url! as URL)
        webView?.loadRequest(urlRequest)
    }
}
extension AdoptShelterView : UIWebViewDelegate{
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
        
     //   myActivityIndicator.stopAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        myActivityIndicator.stopAnimating()
        
        
    }
}

