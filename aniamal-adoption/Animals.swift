//
//  AnimalInformation.swift
//  aniamal-adoption
//
//  Created by 吳建豪 on 2017/2/6.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import Foundation


class Animal {
    
    var animal_id: String?
    var animal_subid: String?
    var animal_area_pkid: String?
    var animal_place:String?
    var animal_kind:String?
    var animal_sex:String?
    var animal_bodytype:String?
    var animal_colour:String?
    var animal_age:String?
    var animal_sterilization:String?
    var animal_status:String?
    var animal_opendate:String?
    var shelter_address:String?
    var shelter_tel:String?
    var album_file:String?
    var animal_remark:String?
    
    init(_ dict:NSDictionary) {
        
        self.animal_id = dict["animal_id"] as? String
        
        self.animal_subid = dict["animal_subid"] as? String
        
        if let city = dict["animal_area_pkid"] as? String{
        self.animal_area_pkid = cityDict[city]
        }else {
        self.animal_area_pkid = nil
        }
        
        self.animal_place = dict["animal_place"] as? String
        
        self.animal_kind = dict["animal_kind"] as? String
        
        if let sex = dict["animal_sex"] as? String {
        self.animal_sex = sexDict[sex]
        } else {
         self.animal_sex = nil
        }
        
        if let body = dict["animal_bodytype"] as? String {
        self.animal_bodytype = bodyDict[body]
        } else {
            self.animal_bodytype = nil
        }
        
        self.animal_colour = dict["animal_colour"] as? String
        
        if let age = dict["animal_age"] as? String {
        self.animal_age = ageDict[age]
        } else {
            self.animal_age = nil
        }
        
        if let  sterilization = dict["animal_sterilization"] as? String {
        self.animal_sterilization = sterilizationDict[sterilization]
        } else {
            self.animal_sterilization = nil
        }
        
        self.animal_status = dict["animal_status"] as? String
        
        self.animal_opendate = dict["animal_opendate"] as? String
        
        self.shelter_address = dict["shelter_address"] as? String
        
        self.shelter_tel = dict["shelter_tel"] as? String
        
        self.album_file = dict["album_file"] as? String
        
        self.animal_remark = dict["animal_remark"] as? String

        
        
        
    }
    
    
}


let cityDict = ["2":"台北市",
                "12":"南投縣",
                "3":"新北市",
                "13":"雲林縣",
                "4":"基隆市",
                "14":"嘉義縣",
                "5":"宜蘭縣",
                "15":"嘉義市",
                "6":"桃園市",
                "16":"台南市",
                "7":"新竹縣",
                "17":"高雄市",
                "8":"新竹市",
                "18":"屏東縣",
                "9":"苗栗縣",
                "19":"花蓮縣",
                "10":"台中市",
                "20":"台東縣",
                "11":"彰化縣",
                "21":"澎湖縣",
                "22":"金門縣",
                "23":"連江縣",
]
let sexDict = ["M":"公","F":"母"]
let bodyDict = ["BIG":"大","MEDIUM":"中","SMALL":"小","MINI":"幼"]
let ageDict = ["ADULT":"成犬","CHILD":"幼犬"]
let sterilizationDict = ["T":"已絕育", "N":"未絕育", "F":"未絕育"]












