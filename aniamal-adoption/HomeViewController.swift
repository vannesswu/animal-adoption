//
//  ViewController.swift
//  aniamal-adoption
//
//  Created by 吳建豪 on 2017/2/6.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import UIKit
import LBTAComponents
import GoogleMobileAds

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var isFirstLaunchForSettingCondition = true
    let animalResultcellId = "animalResultCellId"
    let favoriteAnimalCellId = "favoriteAnimalCellId"
    let adoptNoteCellId = "AdoptNoteCellId"
    let menuBarHeight:CGFloat = 70
    var performSearch:Bool = false
    var transitionImageFrame:CGRect?
    var transitionImage:UIImage?
    var resultCount:Int? {
        didSet {
            menuBar.searchConditions = searchConditions
            menuBar.result = resultCount
        }
    }
    var searchConditions:[String:String?] = ["區域":"臺北市", "分類":"狗", "體型":nil, "年紀":nil, "毛色":nil, "性別":nil] {
        
        didSet{
            if performSearch {
                self.collectionView?.reloadData()
          //      performSearch = false
            }
        }
    }
    var conut = 0
    override func viewWillAppear(_ animated: Bool) {
        
        collectionView?.reloadData()
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   //     navigationController?.delegate = self
        navigationItem.title = "動物認領養"
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
         navigationController?.navigationBar.isTranslucent = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        setupBarbutton()
        setupMenuBar()
        setupCollectionView()
        
        // for setting conditio
        if isFirstLaunchForSettingCondition && UserDefaults.fetchisRemeberSetting() {
            if let conditions = UserDefaults.fetchSearchSetting(){
                 searchConditions = conditions as! [String : String?]
                isFirstLaunchForSettingCondition = false
            }
        }
        
    }
    
    func setupCollectionView(){
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView?.backgroundColor = .white
        collectionView?.register(AnimalResultCell.self, forCellWithReuseIdentifier: animalResultcellId)
        collectionView?.register(FavoriteAnimalCell.self, forCellWithReuseIdentifier: favoriteAnimalCellId)
        collectionView?.register(AdoptNoteCell.self, forCellWithReuseIdentifier: adoptNoteCellId)
        collectionView?.contentInset = UIEdgeInsetsMake(58+menuBarHeight , 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(58+menuBarHeight, 0, 0, 0)
        
        collectionView?.isPagingEnabled = true

    }
    
    func setupBarbutton(){
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
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
        bgView.backgroundColor = UIColor.mainBlue
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
        searchLauncher.searchConditions = searchConditions
        searchLauncher.showSearching()
        // move to AnimalResultCell
        let indexPath = IndexPath(item: 0, section: 0)
        scrollToMenuIndex(0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition())
    }
    
    func scrollToMenuIndex(_ menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition(), animated: true)
        
        setTitleForIndex(indexPath)
    }
    
    fileprivate func setTitleForIndex(_ index: IndexPath) {
        if index.item == 0 {
            let cityLabel:String = self.menuBar.searchConditions["區域"]!! == "不限" ? "不限地區" : searchConditions["區域"]!!
            self.menuBar.resultLabel.text = "\(cityLabel)共有\(self.menuBar.result ?? 0)筆資料"
        } else if index.item == 1{
            self.menuBar.resultLabel.text = "收藏共有\(UserDefaults.fetchFavoriteAnimals().count)筆資料"
        } else {
            self.menuBar.resultLabel.text = ""
            
        }
        
    }
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition())
        setTitleForIndex(indexPath)

    }
    
    func pushDetailViewController(_ animal:Animal){
        let animalDetailViewController = AnimalDetailViewController()
        animalDetailViewController.animal = animal
        navigationController?.pushViewController(animalDetailViewController, animated: true)
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
       menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 3
        
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell:AnimalResultCell
        
        if indexPath.item == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: animalResultcellId, for: indexPath) as! AnimalResultCell
            cell.cellIndex = indexPath.item
            if performSearch {
            cell.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
                                             at: .top,
                                             animated: true)
                performSearch = false

            }
            cell.delegateController = self
            
        } else if indexPath.item == 1{
             cell = collectionView.dequeueReusableCell(withReuseIdentifier: favoriteAnimalCellId, for: indexPath) as! FavoriteAnimalCell
            cell.animals = UserDefaults.fetchFavoriteAnimals()
            cell.cellIndex = indexPath.item
            cell.delegateController = self
        } else {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: adoptNoteCellId, for: indexPath) as! AdoptNoteCell
            return cell
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}

//extension HomeViewController: UINavigationControllerDelegate {
//    
//    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        let animation = AnimalAnimation()
//        animation.profileimage = transitionImage
//        animation.cellProfileViewFrame = transitionImageFrame!
//        if fromVC is HomeViewController {
//            animation.presenting  =  true
//        } else {
//            animation.presenting  =  false
//        }
//        
//        return animation
//    }
//    
//}


    


