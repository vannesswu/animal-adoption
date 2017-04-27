//
//  FBViewFooter.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/4/27.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import UIKit

class FBViewHeader: UITableViewHeaderFooterView {
    
    var fbViewController:FBViewController?
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        searchTextField.delegate = self
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
    let searchTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "搜尋... 多條件請用空格分開"
        return tf
    }()
    lazy var searchButton:UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(performSearch), for: .touchUpInside)
        btn.setImage(#imageLiteral(resourceName: "search").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = UIColor.mainBlue
        return btn
    }()
    
    
    func setupViews() {
        addSubview(searchView)
        addSubview(resultLabel)
        addSubview(searchTextField)
        addSubview(searchButton)
        
        searchView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: frame.width, heightConstant: 30)
        resultLabel.anchor(searchView.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        resultLabel.anchorCenterXToSuperview()
        searchTextField.anchor(resultLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 40, widthConstant: 0, heightConstant: 40)
        searchButton.anchor(searchTextField.topAnchor, left: searchTextField.rightAnchor, bottom: searchTextField.bottomAnchor, right: rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 5, rightConstant: 10, widthConstant: 40, heightConstant: 0 )
        
    }
    
    func performSearch() {
        fbViewController?.performFilter()
        
    }

}
extension FBViewHeader: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        searchTextField.resignFirstResponder()
        return true;
    }
    
}

