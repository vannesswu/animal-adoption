//
//  AniamalCell.swift
//  aniamal-adoption
//
//  Created by 吳建豪 on 2017/2/6.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import UIKit
import  LBTAComponents

class AnimalCell: UICollectionViewCell {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    
    
    let animalView: CachedImageView = {
       let imageView = CachedImageView()
        imageView.image = UIImage(named: "dog")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let cityLabel: UILabel = {
       let label = UILabel()
        label.text = "台南市"
        return label
    }()
    let sexualLabel: UILabel = {
        let label = UILabel()
        label.text = "性別：男"
        return label
    }()
    let loctionLabel: UILabel = {
        let label = UILabel()
        label.text = "台南市流浪動物中途之家"
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        addSubview(animalView)
        addSubview(cityLabel)
        addSubview(sexualLabel)
        addSubview(loctionLabel)
        animalView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 0, widthConstant: 84*16/9, heightConstant: 0)
        cityLabel.anchor(animalView.topAnchor, left: animalView.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 40)
        sexualLabel.anchor(cityLabel.topAnchor, left: cityLabel.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 40)
        loctionLabel.anchor(cityLabel.bottomAnchor, left: animalView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
        
        
    }
    
    
}
