//
//  FBAnimalDetailViewController.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/4/28.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import Foundation
import UIKit
import LBTAComponents

class FBAnimalDetailViewController: UIViewController {
    
    var fbAnimal: FBAnimal? {
        didSet {
           dateLabel.text = "PO文日期 : \(fbAnimal?.created_time ?? "")"
           messageTextView.text = fbAnimal?.message ?? ""
            if let urlString = fbAnimal?.picture {
                if urlString == "nil" {
                    self.animalView.image = #imageLiteral(resourceName: "no_image")
                    } else {
                    self.animalView.loadImage(urlString: urlString, completion: {
            
                    })
                }
            }
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.tintColor = .white
        
        let BarButtonItem = UIBarButtonItem(title: "回前頁", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        BarButtonItem.tintColor = UIColor.white
        navigationItem.backBarButtonItem = BarButtonItem
        

    }
    override func viewWillAppear(_ animated: Bool) {
        setupImageView()
        setupMessage()
        setupFBButton()
    }
    
    let animalView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func setupImageView() {
        view.addSubview(animalView)
        animalView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 150)
        
    }
    
    let dateLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "PO文日期"
       return label
    }()
    let messageTextView:UITextView = {
        let tv = UITextView()
        tv.allowsEditingTextAttributes = false
        tv.isEditable = false
        tv.font = UIFont.systemFont(ofSize: 15)
        return tv
    }()
    
    
    func setupMessage() {
        view.addSubview(dateLabel)
        view.addSubview(messageTextView)
        
        dateLabel.anchor(animalView.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        dateLabel.anchorCenterXToSuperview()
        messageTextView.anchor(dateLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 5, leftConstant: 10, bottomConstant: 50, rightConstant: 10, widthConstant: 0, heightConstant: 0)
    }
    
    lazy var fbButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("前往FB看此認養文", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(openFBPost), for: .touchUpInside)
        btn.backgroundColor = UIColor.htmlBlue
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        return btn
    }()
    
    
    func setupFBButton() {
        view.addSubview(fbButton)
        fbButton.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 30, bottomConstant: 10, rightConstant: 30, widthConstant: 0, heightConstant: 30)
        
    }
    func openFBPost() {
        let fbVC = FBMessageViewController()
        fbVC.url = fbAnimal?.fbid ?? ""
        navigationController?.pushViewController(fbVC, animated: true)
        
    }
    
}
