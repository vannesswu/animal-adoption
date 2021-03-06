//
//  DetailCell.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/2/7.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import UIKit
import LBTAComponents

class DetailCell: UICollectionViewCell {
    
    var index:Int?
    var mapviewDelegateController:AnimalDetailViewController?
    var animal:Animal? {
        didSet{
            setupViews()
            if let index = self.index {
            switch index {
            case 0:
                keyLabel.text = "類型"
                valueLabel.text = animal?.animal_kind ?? ""
            case 1:
                keyLabel.text = "所在地"
                valueLabel.text = animal?.animal_area_pkid ?? ""
            case 2:
                keyLabel.text = "性別"
                valueLabel.text = animal?.animal_sex ?? ""
            case 3:
                keyLabel.text = "年齡"
                valueLabel.text = animal?.animal_age ?? ""
            case 4:
                keyLabel.text = "體型"
                valueLabel.text = animal?.animal_bodytype ?? ""
            case 5:
                keyLabel.text = "毛色"
                valueLabel.text = animal?.animal_colour ?? ""
            case 6:
                keyLabel.text = "結紮"
                valueLabel.text = animal?.animal_sterilization ?? ""
            case 7:
                keyLabel.text = "區域編碼"
                valueLabel.text = animal?.animal_subid ?? ""
            case 8:
                keyLabel.text = "描述"
                if let remark = animal?.animal_remark, animal?.animal_remark != "" {
                    valueLabel.text = remark
                } else {
                    valueLabel.text = "無資料"
                }
                
            case 9:
                keyLabel.text = "所屬單位"
                valueLabel.text = animal?.shelter_name ?? ""
            case 10:
                keyLabel.text = "地址"
                valueLabel.text = animal?.shelter_address ?? ""
           case 11:
                keyLabel.text = "電話"
                valueLabel.text = animal?.shelter_tel ?? ""
            case 12:
                keyLabel.text = "注意事項"
                valueLabel.text = "因資料維護由各收容所負責 前往收容所前請先打電話詢問此編號是否仍在！"
                
            default:
                break
            }
            
        }
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
  //      setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let keyLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    let valueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    let valueTextView:LBTATextView = {
     let textView = LBTATextView()
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.backgroundColor = .clear
    return textView
    }()
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        return view
    }()
    lazy var showMapButton:UIButton = {
        let btn = UIButton()
    //btn.setTitle("前往地圖", for: .normal)
        btn.setTitleColor(UIColor.htmlBlue, for: .normal)
        btn.setImage(#imageLiteral(resourceName: "map"), for: .normal)
        btn.addTarget(self, action: #selector(showMap), for: .touchUpInside)
        return btn
    }()
    
    
    func setupViews() {
    //   backgroundColor = UIColor.brown
        addSubview(keyLabel)
        addSubview(valueLabel)
        
        keyLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 0)
        
        if index == 9 {
            addSubview(showMapButton)
            showMapButton.anchor(nil, left: nil, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 1, rightConstant: 20, widthConstant: 30, heightConstant: 30)
            valueLabel.anchor(keyLabel.topAnchor, left: keyLabel.rightAnchor, bottom: bottomAnchor, right: showMapButton.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 1, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        } else {
            valueLabel.anchor(keyLabel.topAnchor, left: keyLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 1, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        }
        addSubview(separatorView)
        separatorView.anchor(nil, left: valueLabel.leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0 , leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
        
        
    }
    
    func showMap() {
        mapviewDelegateController?.showMapView()
    }
    
    
}

