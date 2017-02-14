//
//  MapView.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/2/13.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import UIKit
import LBTAComponents

class MapViewController:UIViewController {
    
    var myActivityIndicator = UIActivityIndicatorView()
    var shelterName:String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "地圖"
        mapView.delegate = self
        
    }
    let mapView = UIWebView()
    
    override func viewWillLayoutSubviews() {
        setupmapView()
    }
    
    func setupmapView() {
        view.addSubview(mapView)
        view.addSubview(myActivityIndicator)
        mapView.fillSuperview()
        myActivityIndicator.anchorCenterSuperview()
        myActivityIndicator.startAnimating()
        if let address = shelterName {
        let url = NSURL(string:"https://www.google.com.tw/maps/place/\(address.addEncoding())")
        let urlRequest = URLRequest(url: url! as URL)
        mapView.loadRequest(urlRequest)
        

        }
    }
    
    
}

extension MapViewController : UIWebViewDelegate{
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
        myActivityIndicator.activityIndicatorViewStyle = .gray
        myActivityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        myActivityIndicator.stopAnimating()
        
        
    }
}
