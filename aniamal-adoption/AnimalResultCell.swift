//
//  BaseCell.swift
//  aniamal-adoption
//
//  Created by 吳建豪 on 2017/2/6.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AnimalResultCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var clickNumber = 0
    var favoriteAnimals = [Animal]()
    var oldSearchConditions:[String:String?] = [:]
    var animateIsNeed:Bool = true
    // admob click cell
    var interstitial: GADInterstitial!
    var isAdsadding:Bool = true
    var animalsCount = 0
    // Admob tableviewcell
    var adsToLoad = [GADNativeExpressAdView]()
    var loadStateForAds = [GADNativeExpressAdView: Bool]()
    let adUnitID = "ca-app-pub-8818309556860374/4392356844"
    // A Native Express ad is placed in the UITableView once per `adInterval`. iPads will have a
    // larger ad interval to avoid mutliple ads being on screen at the same time.
    let adInterval = 12
    // The Native Express ad height.
    let adViewHeight = CGFloat(135)
    
    
    
    
    var delegateController:HomeViewController? {
        didSet {
            self.searchConditions = (delegateController?.searchConditions)!
        }
    }
    var searchConditions:[String:String?] = ["區域":"臺北市", "分類":"狗", "體型":nil, "年紀":nil, "毛色":nil, "性別":nil] {
        didSet {
            if self.cellIndex == 0, oldSearchConditions != searchConditions {
                self.featchAnimals(dict: searchConditions)
                self.animateIsNeed = true
            }
            oldSearchConditions = searchConditions
        }
    }
    
    let cellId = "AnimalResultCellCellId"
    var cellIndex:Int = 0
        
    
    var mixanimals = [AnyObject]()
    var animals = [AnyObject]() {
        didSet {
            mixanimals = animals
            addNativeExpressAds()
            preloadNextAd()
            animals = mixanimals
            self.collectionView.reloadData()
        }
    }
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let handleingView:UIView = {
        let view = UIView()
        let label = UILabel()
        let spinner = UIActivityIndicatorView.spinner
        label.text = "資料搜尋中請稍候..."
        view.addSubview(label)
        view.addSubview(spinner)
        label.anchorCenterSuperview()
        spinner.anchor(label.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        spinner.anchorCenterXToSuperview()
        spinner.startAnimating()
        view.backgroundColor = UIColor(white: 1, alpha: 1)
        return view
    }()
    
    func featchAnimals(dict:[String:String?]){
        setupHandleingView()
        let parameters = ApiService.shareInstatance.transDictToUrlFormat(dict)
        ApiService.shareInstatance.fetchAnimals(parameters) { (animals:[Animal],error:Error?) in
            if error != nil {
                self.handleingError()
                return
            }
            self.handleingView.removeFromSuperview()
            self.animals = animals
            self.delegateController?.searchConditions = self.searchConditions
            self.delegateController?.resultCount = animals.count

        }
        
    }
    
    func handleingError(){
        handleingView.removeFromSuperview()
        let alertController = UIAlertController(title: "Oops! 出錯了", message: "網路連線異常請稍候再試", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        
        delegateController?.present(alertController, animated: true, completion: nil)
    
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        interstitial = createAndLoadInterstitial()
        setupCollectionView()
    
    }
     // regenerate interstitial request
    func createAndLoadInterstitial() -> GADInterstitial {
        var interstitial = GADInterstitial(adUnitID: "ca-app-pub-8818309556860374/7485424041")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
    
    
    
    let wordLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    func setupHandleingView() {
        addSubview(handleingView)
        handleingView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }

    
    
    
    func setupCollectionView() {
  //      featchAnimals(dict:searchConditions)
        addSubview(collectionView)
        
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        
        collectionView.register(AnimalCell.self, forCellWithReuseIdentifier: cellId)
        let nib = UINib(nibName: "NativeExpressAd", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "NativeExpressAdViewCell")
        
        // make botton more room for display
        collectionView.contentInset = UIEdgeInsetsMake( 0, 0, 70, 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 70, 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animals.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let nativeExpressAdView = animals[indexPath.item] as? GADNativeExpressAdView {
            let reusableAdCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NativeExpressAdViewCell",
                                                               for: indexPath)
            
            // Remove previous GADNativeExpressAdView from the content view before adding a new one.
            for subview in reusableAdCell.contentView.subviews {
                subview.removeFromSuperview()
            }
            
            reusableAdCell.contentView.addSubview(nativeExpressAdView)
            // Center GADNativeExpressAdView in the table cell's content view.
            nativeExpressAdView.center = reusableAdCell.contentView.center
            
            return reusableAdCell
            
        }else{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AnimalCell
        let animal = animals[indexPath.item]
        cell.animal = animal as? Animal

        return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let tableItem = animals[indexPath.item] as? GADNativeExpressAdView {
            let isAdLoaded = loadStateForAds[tableItem]
            let cellheight = isAdLoaded == true ? adViewHeight : 0
            return CGSize(width: frame.width, height: cellheight)
        }
        
        
        
        return CGSize(width: frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if interstitial.isReady ,adsNumber == clickNumber{
            UIWindow.removeStatusBar()
            interstitial.present(fromRootViewController: delegateController!)
            isAdsshown = true
            clickNumber = 0
//            UIWindow.addStatusBar()
        }
        
        
        
        // pass transition image frame and data
        if let animal = animals[indexPath.item] as? Animal {
            let cell = collectionView.cellForItem(at: indexPath) as! AnimalCell
            if let image = cell.animalView.image {
                delegateController?.transitionImage = image
            }
            if let window = UIApplication.shared.keyWindow {
                let frame = cell.animalView.superview?.convert(cell.animalView.frame, to: window)
                delegateController?.transitionImageFrame = frame
            }
        delegateController?.pushDetailViewController(animal as Animal)
        }
       clickNumber += 1
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if animateIsNeed {
            let frame = cell.frame
            cell.frame = CGRect(x: 0, y: self.collectionView.frame.height, width: frame.width, height: frame.height)
            UIView.animate(withDuration: 0.75, delay: 0.0, options: UIViewAnimationOptions.transitionCrossDissolve, animations: { () -> Void in
                cell.frame = frame
            }, completion: {(bool:Bool) in
                if bool {
                    self.animateIsNeed = false
                }
            } )
        }
    }
}

extension AnimalResultCell: GADInterstitialDelegate, GADNativeExpressAdViewDelegate{

// MARK: - GADNativeExpressAdView delegate methods

func nativeExpressAdViewDidReceiveAd(_ nativeExpressAdView: GADNativeExpressAdView) {
    // Mark native express ad as succesfully loaded.
    loadStateForAds[nativeExpressAdView] = true
    // Load the next ad in the adsToLoad list.
    preloadNextAd()
}

func nativeExpressAdView(_ nativeExpressAdView: GADNativeExpressAdView,
                         didFailToReceiveAdWithError error: GADRequestError) {
    print("Failed to receive ad: \(error.localizedDescription)")
    // Load the next ad in the adsToLoad list.
    preloadNextAd()
}

// MARK: - UITableView source data generation

/// Adds native express ads to the tableViewItems list.
func addNativeExpressAds() {
    var index = adInterval
    // Ensure subview layout has been performed before accessing subview sizes.
    
    collectionView.layoutIfNeeded()
    var totalcount = 0
    while index < animals.count && totalcount < 4{
        let adSize = GADAdSizeFromCGSize(
            CGSize(width: collectionView.contentSize.width, height: adViewHeight))
        guard let adView = GADNativeExpressAdView(adSize: adSize) else {
            print("GADNativeExpressAdView failed to initialize at index \(index)")
            return
        }
        adView.adUnitID = adUnitID
        adView.rootViewController = delegateController
        adView.delegate = self
        mixanimals.insert(adView, at: index)
        adsToLoad.append(adView)
        loadStateForAds[adView] = true
        
        index += adInterval
        totalcount += 1
    }
}

/// Preload native express ads sequentially. Dequeue and load next ad from `adsToLoad` list.
func preloadNextAd() {
    if !adsToLoad.isEmpty {
        let ad = adsToLoad.removeFirst()
        ad.load(GADRequest())
    }
}

}


