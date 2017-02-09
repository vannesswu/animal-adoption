//
//  ViewController.swift
//  aniamal-adoption
//
//  Created by 吳建豪 on 2017/2/6.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import UIKit
import LBTAComponents

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    let headerId = "headerId"
    let footerId = "footerId"
    let menuBarHeight:CGFloat = 70
    var performSearch:Bool = false
    var resultCount:Int? {
        didSet {
            menuBar.searchConditions = searchConditions
            menuBar.result = resultCount
        }
    }
    var searchConditions:[String:String?] = ["區域":"台南市", "分類":"狗", "體型":nil, "年紀":nil, "毛色":nil, "性別":nil] {
        
        didSet{
            if performSearch {
            self.collectionView?.reloadData()
                performSearch = false
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "動物認領養"
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
         navigationController?.navigationBar.isTranslucent = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)

        setupBarbutton()
        setupMenuBar()
        setupCollectionView()
              
    }
    func setupCollectionView(){
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView?.backgroundColor = .white
        collectionView?.register(BaseCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.contentInset = UIEdgeInsetsMake(56+menuBarHeight , 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(56+menuBarHeight, 0, 0, 0)
        collectionView?.isPagingEnabled = true

    }
    
    func setupBarbutton(){
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        navigationItem.rightBarButtonItems = [searchBarButtonItem]
        
        
        let backBarButtonItem = UIBarButtonItem(title: "回前頁", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        backBarButtonItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.white], for: .normal)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    lazy var menuBar:MenuBar = {
       let mb = MenuBar()
        mb.homeViewController = self
        return mb
    }()
    func setupMenuBar() {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.red
        view.addSubview(bgView)
        view.addSubview(menuBar)
        bgView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: menuBarHeight)
        menuBar.anchor(bgView.topAnchor, left: bgView.leftAnchor, bottom: nil, right: bgView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: menuBarHeight)
        
        
    }
    
    
    lazy var searchLauncher: SearchLauncher = {
        let launcher = SearchLauncher()
        return launcher
    }()
    
    
    
    
    
    func handleSearch(){
        searchLauncher.conditionDelegate = self
        searchLauncher.showSearching()
    }
    
    func scrollToMenuIndex(_ menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition(), animated: true)
        
        //setTitleForIndex(menuIndex)
    }
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition())
        
        }

    
    func pushDetailViewController(_ animal:Animal){
        let animalDetailViewController = AnimalDetailViewController()
        animalDetailViewController.animal = animal
        navigationController?.pushViewController(animalDetailViewController, animated: true)
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
       menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 2
        
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseCell
        cell.delegateController = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}

    


