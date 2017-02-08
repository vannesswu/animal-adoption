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
    
    var animal:Animal? {
        didSet{
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
            default:
                break
            }
            
        }
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setupViews()
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
    return textView
    }()
    
    
    
    
    func setupViews() {
       backgroundColor = UIColor.brown
        addSubview(keyLabel)
        addSubview(valueLabel)
        
        keyLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 0)
        valueLabel.anchor(keyLabel.topAnchor, left: keyLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
        
        
    }
    
    
    
    
    
}

