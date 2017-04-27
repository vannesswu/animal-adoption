//
//  FBAnimal.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/4/27.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import Foundation

class FBAnimal {
    
    var fbid: String?
    var message: String?
    var picture: String?
    var created_time: String?
    var kind: String?
    var group: String?
    
   init(_ dict:NSDictionary) {
     self.fbid = dict["fbid"] as? String
     self.message = dict["message"] as? String
     self.picture = dict["picture"] as? String
     self.created_time = dict["created_time"] as? String
     self.kind = dict["kind"] as? String
     self.group = dict["group"] as? String
    
    
    
    }
    
    
    
    
}
