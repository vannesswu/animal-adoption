//
//  FBAnimalCell.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/4/27.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import Foundation
import UIKit
import LBTAComponents

class FBAnimalCell: UITableViewCell {
    
    var fbAnimal:FBAnimal? {
        didSet {
            self.groupLabel.text = "FB社團 : \(fbAnimal?.group ?? "")"
            self.messageLabel.text = "內文 : \(fbAnimal?.message ?? "")"
            self.spinner.startAnimating()
            if let urlString = fbAnimal?.picture {
                self.animalView.loadImage(urlString: urlString, completion: {
                    self.spinner.stopAnimating()
                })
            }
        }

        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
           }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    let groupLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    let messageLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    func setupViews() {
        
        addSubview(animalView)
        addSubview(groupLabel)
        addSubview(messageLabel)
        
        animalView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 5, leftConstant: 5, bottomConstant: 5, rightConstant: 0, widthConstant: 60, heightConstant: 0)
        groupLabel.anchor(animalView.topAnchor, left: animalView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        messageLabel.anchor(groupLabel.bottomAnchor, left: groupLabel.leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
}
