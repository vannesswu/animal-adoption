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
     var titleKey:String!
     var conditionDelegate:SearchLauncher?
    var menuDict:[String:AnyObject]? {
        
        didSet {
            titleKey = menuDict?.keys.first
            categorylabel.text = titleKey
            
            if UserDefaults.fetchisRemeberSetting() {
                if let setting = UserDefaults.fetchSearchSetting() as? [String:String] {
                    optionButton.setTitle(setting[titleKey], for: .normal)
                }else { optionButton.setTitle("不限", for: .normal) }
            } else {
                optionButton.setTitle("不限", for: .normal)
            }
            
        }
    }
    
    lazy var optionTabeleView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchOptionCell.self, forCellReuseIdentifier: self.cellId)
        // inital the first row selected if remember setting is false
        if !UserDefaults.fetchisRemeberSetting() {
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        tableView.selectRow(at: selectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
        }
        return tableView
    }()
    
    var blackView = UIView()
    
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
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(showOptions), for: .touchUpInside)
        return button
    }()
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        return view
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
    //    backgroundColor = UIColor.darkGray
        addSubview(categorylabel)
        addSubview(optionButton)
        addSubview(separatorView)
        categorylabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 0)
        optionButton.anchor(categorylabel.topAnchor, left: categorylabel.rightAnchor, bottom: categorylabel.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 1, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        separatorView.anchor(nil, left: optionButton.leftAnchor, bottom: bottomAnchor, right: optionButton.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
        
    }
    
    
    func showOptions() {
        
        if globalTableView.count > 0 {
            for view in globalTableView{
                view.removeFromSuperview()
            }
        }
        
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            globalTableView.append(optionTabeleView)
            window.addSubview(blackView)
            window.addSubview(optionTabeleView)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            
            let frame = optionButton.superview?.convert(optionButton.frame, to: window)
            var estimatedHeight = CGFloat(cellHeight * optionArray!.count)
            if estimatedHeight > (window.bounds.height - (frame?.origin.y)!) {
                estimatedHeight = (window.bounds.height - (frame?.origin.y)!)
            }
            optionTabeleView.frame = CGRect(x: (frame?.origin.x)!, y: (frame?.origin.y)!, width: optionButton.frame.width, height: 0)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.optionTabeleView.frame = CGRect(x: (frame?.origin.x)!, y: (frame?.origin.y)!, width: self.optionButton.frame.width, height: estimatedHeight)
            }, completion: nil )
           
            // MARK: manually assign cell.isselected
            for (index ,element) in optionArray!.enumerated() {
                let selectedIndexPath = IndexPath(row: index, section: 0)
                let cell = optionTabeleView.cellForRow(at: selectedIndexPath)
                if optionButton.currentTitle == element {
                optionTabeleView.selectRow(at: selectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
                    cell?.isSelected = true
                } else {
                    cell?.isSelected = false
                }
                
            }
            
        }
    }
    
    
    func handleDismiss() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            self.optionTabeleView.removeFromSuperview()
            
        }) { (completed: Bool) in }
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SearchOptionCell
        cell.titleLabel.text = optionArray?[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        optionButton.setTitle(optionArray?[indexPath.row], for: .normal)
        globalTableView.removeLast()
        optionTabeleView.removeFromSuperview()
        self.blackView.alpha = 0
            storeConditions((optionArray?[indexPath.row])!)
    }

    
    func storeConditions(_ value:String) {
       conditionDelegate?.searchConditions[titleKey!] = value
         }
}


