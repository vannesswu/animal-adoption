//
//  SearchViewController.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/2/8.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import UIKit
import LBTAComponents

class SearchLauncher: NSObject {
    
    
    let cellId = "SearchcellId"
    let headerId = "SearchheaderId"
    let footerId = "SearchfooterId"
    let cellHeight: CGFloat = 50
    var conditionDelegate: HomeViewController?
    
    var searchConditions:[String:String?] = ["區域":nil, "分類":nil, "體型":nil, "年紀":nil, "毛色":nil, "性別":nil]
    
//    let searchDict = ["區域":cityArray, "分類":kindArray, "體型":bodyArray, "年紀":ageArray, "毛色":colorArray, "性別":sexArray]
    
    let blackView = UIView()
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainBlue
        return view
    }()
    let SearchView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    lazy var performButton:UIButton = {
        let button = UIButton()
        button.setTitle("搜尋", for: .normal)
        button.backgroundColor = UIColor.mainBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(performSearch), for: .touchUpInside)
        return button
    }()

    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    let rememberButton:UIButton = {
        let btn = UIButton()
        btn.layer.borderWidth = 4
        btn.layer.borderColor = UIColor.selectGreen.cgColor
        btn.setImage(UserDefaults.fetchisRemeberSetting() ? #imageLiteral(resourceName: "remember") : nil, for: .normal)
        return btn
    }()
    let rememberLabel:UILabel = {
        let label = UILabel()
        label.text = "記住此設定"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    func showSearching() {
        // remove the handleView
     //   if conditionDelegate.ha
        
        
        //show menu
    
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(SearchView)
            setupHeaderView()
            setupCollectionView()
            setupRememberButton()
            setupPerformButton()
           
            SearchView.frame = CGRect(x: window.frame.width, y: 0, width: window.frame.width/2, height: window.frame.height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                
                self.SearchView.frame = CGRect(x: window.frame.width/2, y: 0, width: self.SearchView.frame.width, height: self.SearchView.frame.height)
                
            }, completion: nil)
        }
        
    }
    func performSearch() {
        conditionDelegate?.performSearch = true
        conditionDelegate?.searchConditions = self.searchConditions
        if UserDefaults.fetchisRemeberSetting() {
            var condition = [String:String]()
            for (key, value) in searchConditions {
                condition[key] = value ?? "不限"
            }
            UserDefaults.standard.set(condition, forKey: "searchingSetting")
        }
        
        handleDismiss()
        
        
    }
    
    func handleDismiss() {
        
        if globalTableView.count > 0 {
            for view in globalTableView{
                view.removeFromSuperview()
            }
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.SearchView.frame = CGRect(x: window.frame.width, y: 0, width: self.SearchView  .frame.width, height: self.SearchView.frame.height)
            }
            
        }) { (completed: Bool) in }
        
    }
    
    func setupHeaderView() {
        SearchView.addSubview(headerView)
        headerView.anchor(SearchView.topAnchor, left: SearchView.leftAnchor, bottom: nil, right: SearchView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 44+20+70)
        let titleLabel = UILabel()
        titleLabel.text = "設定搜尋條件"
        titleLabel.textColor = UIColor.white
        headerView.addSubview(titleLabel)
        titleLabel.anchorCenterXToSuperview()
        titleLabel.anchorCenterYToSuperview()
        
        
    }
    func setupCollectionView() {
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: cellId)
        SearchView.addSubview(collectionView)
        collectionView.anchor(headerView.bottomAnchor, left: headerView.leftAnchor, bottom: nil, right: headerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: CGFloat(searchOptions.count) * cellHeight)
        
    }
    
    func setupRememberButton(){
        SearchView.addSubview(rememberButton)
        SearchView.addSubview(rememberLabel)
        rememberButton.addTarget(self, action: #selector(handleDefaultSetting), for: .touchUpInside)
        rememberButton.anchor(collectionView.bottomAnchor, left: collectionView.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 25, bottomConstant: 0, rightConstant: 0, widthConstant: 25, heightConstant: 25)
        rememberLabel.centerYAnchor.constraint(equalTo: rememberButton.centerYAnchor).isActive = true
        rememberLabel.anchor(nil, left: rememberButton.rightAnchor, bottom: nil, right: collectionView.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 15)
        
    }
    func setupPerformButton() {
        SearchView.addSubview(performButton)
        performButton.anchor(collectionView.bottomAnchor, left: collectionView.leftAnchor, bottom: nil, right: collectionView.rightAnchor, topConstant: 50, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: cellHeight)
        performButton.anchorCenterXToSuperview()
        
    }

    
    
    func handleDefaultSetting() {
        UserDefaults.standard.set(!UserDefaults.fetchisRemeberSetting(), forKey: "rememberSetting")
        rememberButton.setImage(UserDefaults.fetchisRemeberSetting() ? #imageLiteral(resourceName: "remember") : nil, for: .normal)
        
    }
    
    override init() {
        super.init()
    }

    
    
    
}

extension SearchLauncher: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCell
       
        if indexPath.item < searchOptions.count {
        let key = searchOptions[indexPath.item]
        cell.menuDict = [key:searchDict[key] as AnyObject]
        cell.conditionDelegate = self
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    
    
}
