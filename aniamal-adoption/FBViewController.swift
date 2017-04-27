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
    
    let headerId = "fbheaderId"
    let cellId = "fbcellId"
    var fbAnimals = [FBAnimal]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "動物認領養(FB粉絲團)"
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
       tableView?.scrollIndicatorInsets = UIEdgeInsetsMake(70, 0, 0, 0)
        
        tableView.register(FBViewHeader.self, forHeaderFooterViewReuseIdentifier: headerId)
        tableView.register(FBAnimalCell.self, forCellReuseIdentifier: cellId)
        tableView.sectionHeaderHeight = 70
        performFetchFBAnimals()
        
    }
    
    
    func performFetchFBAnimals() {
        if fbAnimals.count == 0 {
        ApiService.shareInstatance.fetchFBAnimal { ( fbAnimals, error) in
         self.fbAnimals = fbAnimals
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
      }
    }
    
    
    func performFilter() {
        print("here")
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as? FBViewHeader
        header?.fbViewController = self
        header?.resultLabel.text = "共有\(fbAnimals.count)筆資料"
        return header
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fbAnimals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FBAnimalCell
        cell.fbAnimal = fbAnimals[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    
}



