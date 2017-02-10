//
//  AnimalDetailViewController.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/2/7.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import UIKit
import LBTAComponents

class AnimalDetailViewController: UIViewController {

    let cellId = "DetailcellId"
    let headerId = "DetailheaderId"
    let footerId = "DetailfooterId"
    var favoriteAnimals = [Animal]()
    var favorite:Bool = false {
        didSet {
            self.navigationItem.rightBarButtonItem?.tintColor = favorite ? UIColor.white : UIColor(r: 91, g: 14, b: 13)
        }
    }

    var animal:Animal?
    
    let animalView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let backBarButtonItem = UIBarButtonItem(title: "回前頁", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        backBarButtonItem.tintColor = UIColor.white
        
        navigationItem.backBarButtonItem = backBarButtonItem

        
        setupBarbutton()
        setupImageView()
        setupCollectionView()
        }
    func setupBarbutton(){
        let favoriteImage = UIImage(named: "love-48")?.withRenderingMode(.alwaysTemplate)
        let favoriteBarButtonItem = UIBarButtonItem(image: favoriteImage, style: .plain, target: self, action: #selector(selectToFavorite))
        navigationItem.rightBarButtonItems = [favoriteBarButtonItem]
        favorite = (animal?.favorite)!
    }
    func selectToFavorite(){
        animal?.favorite = !(animal?.favorite)!
        favorite = (animal?.favorite)!
        
        let userDefault = UserDefaults.standard
        
        if userDefault.object(forKey: "favoriteAnimals") as? [Animal] == nil {
            
        }
        favoriteAnimals = NSKeyedUnarchiver.unarchiveObject(with: (userDefault.object(forKey: "favoriteAnimals") as! NSData) as Data) as? [Animal] ?? [Animal]()
        if favorite {
            favoriteAnimals.append(animal!)
        } else {
            favoriteAnimals = favoriteAnimals.filter({ (animals:Animal) -> Bool in
                animals.animal_id != animal?.animal_id
            })
        }
        userDefault.set(NSKeyedArchiver.archivedData(withRootObject: favoriteAnimals), forKey: "favoriteAnimals")
        userDefault.synchronize()
        let array = NSKeyedUnarchiver.unarchiveObject(with: (userDefault.object(forKey: "favoriteAnimals") as! NSData) as Data) as! [Animal]
      
        
    }
  
    
    
    
    
    func setupImageView(){
        let imageHeight = view.frame.size.height/3
        view.addSubview(animalView)
        animalView.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: imageHeight)
        if let urlString = animal?.album_file {
        animalView.loadImage(urlString: urlString)
        }
    }
    
    func setupCollectionView() {
        collectionView.register(DetailCell.self, forCellWithReuseIdentifier: cellId)
        view.addSubview(collectionView)
        collectionView.anchor(animalView.bottomAnchor, left: animalView.leftAnchor, bottom: self.view.bottomAnchor, right: animalView.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    
}

extension AnimalDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DetailCell
        cell.index = indexPath.item
        cell.animal = animal
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let remark = animal?.animal_remark, indexPath.item == 8, animal?.animal_remark! != "" {
        let approximateWidthOfTextView = view.frame.width - 100 - 8 - 8
        let size = CGSize(width: approximateWidthOfTextView, height: 1000)
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 15)]
        let estimatedFrame = NSString(string: remark).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            return CGSize(width: view.frame.width, height: estimatedFrame.size.height + 40)

        }
        
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
