//
//  BaseCell.swift
//  aniamal-adoption
//
//  Created by 吳建豪 on 2017/2/6.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    var favoriteAnimals = [Animal]()
    var delegateController:HomeViewController? {
        didSet {
            self.searchConditions = (delegateController?.searchConditions)!
        }
    }
    var searchConditions:[String:String?] = ["區域":"台南市", "分類":"狗", "體型":nil, "年紀":nil, "毛色":nil, "性別":nil] {
        didSet {
            if self.cellIndex == 0 {
                self.featchAnimals(dict: searchConditions)
            }
        }
    }
    
    let cellId = "BaseCellId"
    var cellIndex:Int = 0 {
        didSet {
            let userDefault = UserDefaults.standard
            favoriteAnimals = NSKeyedUnarchiver.unarchiveObject(with: (userDefault.object(forKey: "favoriteAnimals") as! NSData) as Data) as! [Animal]
           self.animals = favoriteAnimals
        }
    }
    
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
    
    func featchAnimals(dict:[String:String?]){
        
        let parameters = ApiService.shareInstatance.transDictToUrlFormat(dict)
        ApiService.shareInstatance.fetchAnimals(parameters) { (animals:[Animal]) in
            
            self.animals = animals
            self.delegateController?.searchConditions = self.searchConditions
            self.delegateController?.resultCount = animals.count

        }
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let wordLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    func setupViews() {
  //      featchAnimals(dict:searchConditions)
        addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        
        collectionView.register(AnimalCell.self, forCellWithReuseIdentifier: cellId)
        
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
        cell.animal = animals?[indexPath.item]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let animal = animals?[indexPath.item]{
        delegateController?.pushDetailViewController(animal)
        }
    
    }
    
}
