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
     label.alpha = 0.87
    return label
    }    
}

