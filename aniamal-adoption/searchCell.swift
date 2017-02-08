//
//  searchCell.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/2/8.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import UIKit
import LBTAComponents

var globalTableView = [UITableView]()
class SearchCell: UICollectionViewCell {
    
     let cellId = "optionCellId"
     let cellHeight = 40
     var optionArray:[String]?
     var titleKey:String?
     var conditionDelegate:SearchLauncher?
    var menuDict:[String:AnyObject]? {
        
        didSet {
            titleKey = menuDict?.keys.first
            categorylabel.text = titleKey
            optionButton.setTitle("不限", for: .normal)
        }
    }
    
    lazy var optionTabeleView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellId)
        
        return tableView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = false
        setupViews()
    }
    
    let categorylabel:UILabel = {
      let label = UILabel()
        return label
    }()
    lazy var optionButton:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(showOptions), for: .touchUpInside)
        return button
    }()
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        backgroundColor = UIColor.blue
        addSubview(categorylabel)
        addSubview(optionButton)
        categorylabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 0)
        optionButton.anchor(categorylabel.topAnchor, left: categorylabel.rightAnchor, bottom: categorylabel.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    
    func showOptions() {
        
        if globalTableView.count > 0 {
            for view in globalTableView{
                view.removeFromSuperview()
            }
        }
        
        if let window = UIApplication.shared.keyWindow {
        globalTableView.append(optionTabeleView)
        window.addSubview(optionTabeleView)
        let frame = optionButton.superview?.convert(optionButton.frame, to: window)
        var estimatedHeight = CGFloat(cellHeight * optionArray!.count)
            if estimatedHeight > (window.bounds.height - (frame?.origin.y)!) {
                estimatedHeight = (window.bounds.height - (frame?.origin.y)!)
            }
        optionTabeleView.frame = CGRect(x: (frame?.origin.x)!, y: (frame?.origin.y)!, width: optionButton.frame.width, height: 0)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.optionTabeleView.frame = CGRect(x: (frame?.origin.x)!, y: (frame?.origin.y)!, width: self.optionButton.frame.width, height: estimatedHeight)
        }, completion: nil )
        
        }
    }
    
    func performSearch() {
        
        
        
    }
    
    
    
}

extension SearchCell: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = menuDict?.values.first as? [String] {
            optionArray = array
        }
        return optionArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as UITableViewCell
        cell.textLabel?.text = optionArray?[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        optionButton.setTitle(optionArray?[indexPath.row], for: .normal)
        globalTableView.removeLast()
        optionTabeleView.removeFromSuperview()

        
            storeConditions((optionArray?[indexPath.row])!)
        
        
        
        
    }
    func storeConditions(_ value:String) {
        if value == "不限" {
       conditionDelegate?.searchConditions[titleKey!] = nil
        } else {
       conditionDelegate?.searchConditions[titleKey!] = value

        }
    
    }
}


