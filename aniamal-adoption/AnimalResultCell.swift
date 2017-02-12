//
//  BaseCell.swift
//  aniamal-adoption
//
//  Created by 吳建豪 on 2017/2/6.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import UIKit

class AnimalResultCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    var favoriteAnimals = [Animal]()
    var oldSearchConditions:[String:String?] = [:]
    var animateIsNeed:Bool = true
    var delegateController:HomeViewController? {
        didSet {
            self.searchConditions = (delegateController?.searchConditions)!
        }
    }
    var searchConditions:[String:String?] = ["區域":"台南市", "分類":"狗", "體型":nil, "年紀":nil, "毛色":nil, "性別":nil] {
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
        
    
    
    var animals:[Animal]? = nil {
        didSet {
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
        ApiService.shareInstatance.fetchAnimals(parameters) { (animals:[Animal]) in
            
            self.handleingView.removeFromSuperview()
            self.animals = animals
            self.delegateController?.searchConditions = self.searchConditions
            self.delegateController?.resultCount = animals.count

        }
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
//        setupHandleingView()
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
        return animals?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AnimalCell
        let animal = animals?[indexPath.item]
        cell.animal = animal

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // pass transition image frame and data
        if let animal = animals?[indexPath.item]{
            let cell = collectionView.cellForItem(at: indexPath) as! AnimalCell
            if let image = cell.animalView.image {
                delegateController?.transitionImage = image
            }
            if let window = UIApplication.shared.keyWindow {
                let frame = cell.animalView.superview?.convert(cell.animalView.frame, to: window)
                delegateController?.transitionImageFrame = frame
            }
        delegateController?.pushDetailViewController(animal)
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if animateIsNeed {
            let frame = cell.frame
            cell.frame = CGRect(x: 0, y: self.collectionView.frame.height, width: frame.width, height: frame.height)
            UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.transitionCrossDissolve, animations: { () -> Void in
                cell.frame = frame
            }, completion: {(bool:Bool) in
                if bool {
                    self.animateIsNeed = false
                }
            } )
        }
    }
    
    
    
    
}
