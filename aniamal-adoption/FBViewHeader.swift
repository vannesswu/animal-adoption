//
//  FBViewFooter.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/4/27.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Firebase

class FBViewHeader: UITableViewHeaderFooterView,GADBannerViewDelegate {
    
    var bannerView = GADBannerView()
    var fbViewController:FBViewController?
    fileprivate var parameter = [String]()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        searchTextField.delegate = self
        bannerView.backgroundColor = UIColor.white
        
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    let searchView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainBlue
        return view
    }()
    let resultLabel:UILabel = {
        let label = UILabel()
        label.text = "共幾筆資料"
        label.textColor = UIColor.white
        return label
    }()
    let searchBackView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = UIColor.white
        return view
    }()
    let searchTextField:UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor.white
        tf.placeholder = "搜尋... 多條件請用空格分開"
        return tf
    }()
    lazy var searchButton:UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(performSearch), for: .touchUpInside)
        btn.setImage(#imageLiteral(resourceName: "fbsearch").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = UIColor.midleGray
        btn.backgroundColor = UIColor.superLightGray
        return btn
    }()
    
   
    
    func setupViews() {
        addSubview(searchView)
        addSubview(searchBackView)
        addSubview(resultLabel)
        addSubview(bannerView)
        searchBackView.addSubview(searchTextField)
        searchBackView.addSubview(searchButton)
        
        searchView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: frame.width, heightConstant: 70)
        resultLabel.anchor(searchView.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        resultLabel.anchorCenterXToSuperview()
        searchBackView.anchor(resultLabel.bottomAnchor, left: leftAnchor, bottom: searchView.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 5, rightConstant: 5, widthConstant: 0, heightConstant: 35)
        
        searchTextField.anchor(searchBackView.topAnchor, left: searchBackView.leftAnchor, bottom: searchBackView.bottomAnchor, right: searchBackView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        searchButton.anchor(searchBackView.topAnchor, left: nil, bottom: searchTextField.bottomAnchor, right: searchBackView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0 )
        bannerView.anchor(searchView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    func performSearch() {
        if let para = searchTextField.text , para != "" {
            parameter = para.components(separatedBy: " ")
        }
        fbViewController?.performFilter(parameter: parameter)
        
    }
    
    func loadBanner() {
     //   bannerView = GADBannerView()
        bannerView.delegate = self
        bannerView.adUnitID = "ca-app-pub-8818309556860374/8453684847"
        
     //   bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = fbViewController
        let request = GADRequest()
        bannerView.load(request)

    }
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    
}
extension FBViewHeader: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        searchTextField.resignFirstResponder()
        return true;
    }
    
}

