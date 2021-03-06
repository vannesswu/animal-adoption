//
//  AdoptNoteCell.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/2/14.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import Foundation
import LBTAComponents
import UIKit

class AdoptNoteCell:UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAdoptNoteButton()
        setupAdoptShelterButton()
        setupAdoptCuteVideosButton()
        setupAdoptAboutAppButton()
        
    }
        required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var adoptNoteButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("領養須知", for: .normal)
        btn.layer.cornerRadius = 5
        btn.backgroundColor = UIColor.adoptBlue
        return btn
    }()
    lazy var adoptShelterButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("各地收容所", for: .normal)
        btn.layer.cornerRadius = 5
        btn.backgroundColor = UIColor.adoptGreen
        return btn
    }()
    lazy var adoptCuteVideosButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("可愛動物影片", for: .normal)
        btn.layer.cornerRadius = 5
        btn.backgroundColor = UIColor.adoptPupple
        return btn
    }()
    lazy var adoptAboutAppButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("關於", for: .normal)
        btn.layer.cornerRadius = 5
        btn.backgroundColor = UIColor.adoptRed
        return btn
    }()
    
    func setupAdoptNoteButton() {
        
        addSubview(adoptNoteButton)
        adoptNoteButton.addTarget(self, action: #selector(showNote), for: .touchUpInside)
        adoptNoteButton.anchor(nil, left: nil, bottom: centerYAnchor   , right: centerXAnchor  , topConstant: 0 , leftConstant: 0, bottomConstant: 1, rightConstant: 1, widthConstant: 150, heightConstant: 150)
        let imageView = UIImageView(image: #imageLiteral(resourceName: "adoptnote"))
        imageView.alpha = 0.1
        adoptNoteButton.addSubview(imageView)
        imageView.fillSuperview()
    }
    var showNoteView = AdoptNoteView()
    var showShelterView = AdoptShelterView()
    var showCuteVideosView = AdoptCuteVideosView()
    var showAboutAppView = AdoptAboutAppView()
    func showNote() {
        showNoteView.showup()
    }
    
    
    func setupAdoptShelterButton() {
        addSubview(adoptShelterButton)
        adoptShelterButton.addTarget(self, action: #selector(showShelter), for: .touchUpInside)
        adoptShelterButton.anchor(nil , left: centerXAnchor, bottom: centerYAnchor, right: nil, topConstant: 0, leftConstant: 1, bottomConstant: 1, rightConstant: 0, widthConstant: 150, heightConstant: 150)
        let imageView = UIImageView(image: #imageLiteral(resourceName: "shelter"))
        imageView.alpha = 0.1
        adoptShelterButton.addSubview(imageView)
        imageView.fillSuperview()
    }
    func showShelter() {
        showShelterView.showup()
        
    }
    func setupAdoptCuteVideosButton() {
        addSubview(adoptCuteVideosButton)
        adoptCuteVideosButton.addTarget(self, action: #selector(showVideos), for: .touchUpInside)
        adoptCuteVideosButton.anchor(centerYAnchor, left: nil, bottom: nil, right: centerXAnchor, topConstant: 1, leftConstant: 0, bottomConstant: 0, rightConstant: 1, widthConstant: 150, heightConstant: 150)
        let imageView = UIImageView(image: #imageLiteral(resourceName: "video"))
        imageView.alpha = 0.1
        adoptCuteVideosButton.addSubview(imageView)
        imageView.fillSuperview()
    }
    func showVideos() {
        showCuteVideosView.showup()
    }
    func setupAdoptAboutAppButton() {
        addSubview(adoptAboutAppButton)
        adoptAboutAppButton.addTarget(self, action: #selector(showAboutApp), for: .touchUpInside)
        adoptAboutAppButton.anchor(centerYAnchor, left: centerXAnchor, bottom: nil, right: nil, topConstant: 1, leftConstant: 1, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 150)
        let imageView = UIImageView(image: #imageLiteral(resourceName: "aboutapp"))
        imageView.alpha = 0.1
        adoptAboutAppButton.addSubview(imageView)
        imageView.fillSuperview()
    }
    func showAboutApp() {
        showAboutAppView.showup()
    }
    
    
    
}
