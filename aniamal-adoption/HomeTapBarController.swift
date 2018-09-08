//
//  HomeTapBarController.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/4/27.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import Foundation
import UIKit

class HomeTabBarController:UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    let layout = UICollectionViewFlowLayout()
    let shelterViewNavController = UINavigationController(rootViewController:ShelterViewController(collectionViewLayout:layout))
    shelterViewNavController.tabBarItem.title = "收容所"
    shelterViewNavController.tabBarItem.image = #imageLiteral(resourceName:"shelter2")
    let fbViewController = FBViewController()
    let fbViewNavController = UINavigationController(rootViewController:fbViewController)
    fbViewNavController.tabBarItem.title = "FB粉絲團"
    fbViewNavController.tabBarItem.image = #imageLiteral(resourceName:"facebook")

    tabBar.isTranslucent = false
    viewControllers = [shelterViewNavController]


  }


}
