//
//  UsefulExtension.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/2/11.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import Foundation
import UIKit
public func ==(lhs: [String:String?], rhs: [String:String?] ) -> Bool {
    return NSDictionary(dictionary: lhs).isEqual(to: rhs)
}
public func !=(lhs: [String:String?], rhs: [String:String?] ) -> Bool {
    return !(NSDictionary(dictionary: lhs).isEqual(to: rhs))
}

extension UserDefaults {
    static func fetchFavoriteAnimals() -> [Animal] {
             if let data = UserDefaults.standard.object(forKey: "favoriteAnimals") as? NSData {
            return NSKeyedUnarchiver.unarchiveObject(with: (data as Data)) as? [Animal] ?? [Animal]()
        }
        
        return [Animal]()
    }
    static func fetchSearchSetting() -> NSDictionary? {
        let userDefault = UserDefaults.standard
        if let setting = userDefault.object(forKey: "searchingSetting") as? NSDictionary {
            return setting
        }
        return nil
    }
    static func fetchisRemeberSetting() -> Bool {
        if let bool = UserDefaults.standard.object(forKey: "rememberSetting") as? Bool {
            return bool
        }
        return false
    }
}

extension UIColor {
    static let mainBlue = {
        return UIColor(r: 93, g: 201, b: 234)
    }()
    static let darkBlue = {
        return UIColor(r: 12, g: 75, b: 94)
    }()
    static let selectGreen = {
        return UIColor(r: 57, g: 199, b: 50)
    }()
    static let htmlBlue = {
        return UIColor(r: 85, g: 135, b: 253)
    }()
    static let lightGray = {
        return UIColor(r: 211, g: 211, b: 211)
    }()
    static let superLightGray = {
        return UIColor(r: 233, g: 233, b: 233)
    }()
    static let midleGray = {
        return UIColor(r: 135, g: 135, b: 135)
    }()
    
    static let adoptBlue = {
        return UIColor(r: 51, g: 139, b: 227)
    }()
    static let adoptGreen = {
        return UIColor(r: 21, g: 175, b: 132)
    }()
    static let adoptPupple = {
        return UIColor(r: 116, g: 72, b: 212)
    }()
    static let adoptRed = {
        return UIColor(r: 254, g: 88, b: 128)
    }()
    
    
    
}

extension UIView {
    
    static func makeSeparatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        return view
    }
    
    static let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        return view
    }()
}

extension UIActivityIndicatorView {
    static let spinner: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        return aiv
    }()
}

extension UILabel {
    static func makeWhiteBackoundLabel() -> UILabel {
     let label = UILabel()
 //    label.textAlignment = .center
     label.alpha = 0.87
    return label
    }    
}
extension UIWindow {
    static func addStatusBar(){
        let statusBarBackgroundView = UIView()
        statusBarBackgroundView.backgroundColor = UIColor.darkBlue
        if let window = UIApplication.shared.keyWindow {
        window.addSubview(statusBarBackgroundView)
       statusBarBackgroundView.anchor(window.topAnchor, left: window.leftAnchor, bottom: nil, right: window.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20 + iphoneXHeight)
        }
    }
    static func removeStatusBar(){
        if let window = UIApplication.shared.keyWindow {
            for view in window.subviews {
                if view.backgroundColor == UIColor.darkBlue {
                    view.removeFromSuperview()
                }
            }
        }
    }
}

extension String {
    static func judgeDateIsQualified(_ date:String) -> Bool {
        let dateFormatter = DateFormatter()
        let zeroKillDate = "2017-02-07 00:00:00"
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let createDate = dateFormatter.date(from: date) , let zeroKillAnimalDate = dateFormatter.date(from: zeroKillDate) {
        return createDate  > zeroKillAnimalDate
        }
        return false
    }
    
    
    
}
