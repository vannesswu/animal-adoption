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
    

    var animal:Animal? {
        didSet {
            self.cityLabel.text = animal?.animal_area_pkid ?? ""
            self.sexualLabel.text = "性別 : \(animal?.animal_sex ?? "")"
            self.loctionLabel.text = animal?.shelter_name ?? ""
            self.spinner.startAnimating()
            if let urlString = animal?.album_file {
                self.animalView.loadImage(urlString: urlString, completion: {
                    self.spinner.stopAnimating()
                })
            }
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    
   let spinner: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        return aiv
    }()
    
    let animalView: CachedImageView = {
       let imageView = CachedImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let cityLabel = UILabel.makeWhiteBackoundLabel()
    let sexualLabel = UILabel.makeWhiteBackoundLabel()
    let loctionLabel: UILabel = {
        let label = UILabel.makeWhiteBackoundLabel()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let separatorView = UIView.makeSeparatorView()

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        addSubview(animalView)
        addSubview(cityLabel)
        addSubview(sexualLabel)
        addSubview(loctionLabel)
        addSubview(separatorView)
        animalView.addSubview(spinner)
        
        

        
        animalView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 0, widthConstant: 84*4/3, heightConstant: 0)
        cityLabel.anchor(animalView.topAnchor, left: animalView.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 40)
        sexualLabel.anchor(cityLabel.topAnchor, left: cityLabel.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 40)
        loctionLabel.anchor(cityLabel.bottomAnchor, left: animalView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        separatorView.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        spinner.anchorCenterXToSuperview()
        spinner.anchorCenterYToSuperview()
        
        
    }
    
    
}
