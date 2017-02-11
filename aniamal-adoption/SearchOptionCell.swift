//
//  SearchOptionCell.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/2/11.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import UIKit

class SearchOptionCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        return label
    }()
    
    let selectView:UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            self.selectView.image = isSelected ? UIImage(named: "selected")?.withRenderingMode(.alwaysTemplate) : UIImage(named: "unselected")?.withRenderingMode(.alwaysTemplate)
            self.selectView.tintColor = UIColor.mainBlue
        }
    }
    override var isHighlighted: Bool {
        didSet {
            print("here")
        }
    }
    
    func setupViews() {
        addSubview(selectView)
        addSubview(titleLabel)
        selectView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 10, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 40, heightConstant: 0)
        titleLabel.anchor(topAnchor, left: selectView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
    }
    
    
}
