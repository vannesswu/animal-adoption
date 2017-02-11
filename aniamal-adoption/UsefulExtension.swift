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
}

extension UIColor {
    static let mainBlue = {
        return UIColor(r: 93, g: 201, b: 234)
    }()
    static let darkBlue = {
        return UIColor(r: 12, g: 75, b: 94)
    }()
    
}
