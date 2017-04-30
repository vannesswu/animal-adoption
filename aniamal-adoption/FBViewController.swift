//
//  FBViewController.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/4/27.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import Foundation
import UIKit

class FBViewController:UITableViewController {
    
    var isNeedLoadBanner = false
    let headerId = "fbheaderId"
    let cellId = "fbcellId"
    var fbAnimals = [FBAnimal]()
    var filterFBAnimals = [FBAnimal]()
    var bannerViewHight:CGFloat = 70
    override func viewDidLoad() {
        super.viewDidLoad()
        isNeedLoadBanner = true
        view.backgroundColor = UIColor.white
        navigationItem.title = "動物認領養(FB粉絲團)"
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        navigationController?.navigationBar.isTranslucent = false
        
        let BarButtonItem = UIBarButtonItem(title: "回前頁", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        BarButtonItem.tintColor = UIColor.white
//        
        navigationItem.backBarButtonItem = BarButtonItem
        tableView?.scrollIndicatorInsets = UIEdgeInsetsMake(70+50 , 0, 0, 0)
        
        tableView.register(FBViewHeader.self, forHeaderFooterViewReuseIdentifier: headerId)
        tableView.register(FBAnimalCell.self, forCellReuseIdentifier: cellId)
        tableView.sectionHeaderHeight = 70 + 50  //banner height 50
        
        
        setupBarButton()
        performFetchFBAnimals()
        
        NotificationCenter.default.addObserver(self, selector: #selector(FBViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FBViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    
    func keyboardWillShow(_ notification: Notification) {
        tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
           }
    
    func keyboardWillHide(_ notification: Notification) {
        removeRecognizer()
    }

    

    func setupBarButton() {
        let searchImage = UIImage(named: "refresh")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(performFetchFBAnimals))
        navigationItem.rightBarButtonItems = [searchBarButtonItem]
        
    }

    
    let handleingLabel = UILabel()
    let spinner = UIActivityIndicatorView.spinner
    let backView = UIView()
    
    func setupHandleingView() {
        if let window = UIApplication.shared.keyWindow {
        handleingLabel.text = "資料搜尋中請稍候..."
        backView.backgroundColor = UIColor.white
        window.addSubview(backView)
        backView.addSubview(handleingLabel)
        backView.addSubview(spinner)
            
        backView.frame = CGRect(x: 0, y: 134, width: window.frame.width, height: window.frame.height-134)
        
        handleingLabel.anchorCenterSuperview()
        spinner.anchor(nil, left: handleingLabel.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        spinner.anchorCenterYToSuperview()
        spinner.startAnimating()
            
        }

    }
    

    
    func performFetchFBAnimals() {
        setupHandleingView()
        
        ApiService.shareInstatance.fetchFBAnimal { ( fbAnimals, error) in
         self.fbAnimals = fbAnimals
         self.filterFBAnimals = fbAnimals
            DispatchQueue.main.async {
                self.backView.removeFromSuperview()
                self.tableView.reloadData()
            }
        }
      
    }
    
    
    func performFilter(parameter:[String]) {
        removeRecognizer()
        if parameter.count != 0 {
        filterFBAnimals = fbAnimals
        filterFBAnimals = filterFBAnimals.filter({ (animal) -> Bool in
            
            for para in parameter {
                
                if let message = animal.message {
                    if (!message.contains(para)) {
                        return false
                    }
                }
                
              }
              return true
            })
        tableView.reloadData()
        tableView.reloadSections(IndexSet(integer: 0) , with: .automatic)
      }
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func removeRecognizer() {
        for recognizer in view.gestureRecognizers ?? [] {
            if recognizer.isKind(of: UITapGestureRecognizer.self) {
                view.removeGestureRecognizer(recognizer)
            }
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as? FBViewHeader
        header?.fbViewController = self
        if (isNeedLoadBanner) {
            header?.loadBanner()
            isNeedLoadBanner = false
        }
        
        header?.resultLabel.text = "共有\(filterFBAnimals.count)筆資料"
        return header
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterFBAnimals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FBAnimalCell
        cell.fbAnimal = filterFBAnimals[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = FBAnimalDetailViewController()
        vc.fbAnimal = filterFBAnimals[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}



