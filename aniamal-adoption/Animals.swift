//
//  AnimalInformation.swift
//  aniamal-adoption
//
//  Created by 吳建豪 on 2017/2/6.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import Foundation


class Animal: NSObject, NSCoding {
    
    var animal_id: String?
    var animal_subid: String?
    var animal_area_pkid: String?
    var animal_place:String?
    var shelter_name:String?
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
    var animal_createtime:String?
    var favorite:Bool = false
    let propertyArray = ["animal_id","animal_subid","animal_area_pkid","animal_place","shelter_name","animal_kind","animal_sex","animal_bodytype","animal_colour","animal_age","animal_sterilization","animal_status","animal_opendate","shelter_address","shelter_tel","album_file","animal_remark","favorite","animal_createtime"]
    
    init(_ dict:NSDictionary) {
        
        self.animal_id = dict["animal_id"] as? String
        self.animal_subid = dict["animal_subid"] as? String
        if let city = dict["animal_area_pkid"] as? Int{
        self.animal_area_pkid = cityDict[String(city)]
        }else {
        self.animal_area_pkid = nil
        }
        self.animal_place = dict["animal_place"] as? String
        self.shelter_name = dict["shelter_name"] as? String
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
        self.animal_createtime = dict["animal_createtime"] as? String

    }
    required init?(coder aDecoder: NSCoder) {
        
        self.animal_id = aDecoder.decodeObject(forKey: "animal_id") as? String
        self.animal_subid = aDecoder.decodeObject(forKey: "animal_subid") as? String
        self.animal_area_pkid = aDecoder.decodeObject(forKey: "animal_area_pkid") as? String
        self.animal_place = aDecoder.decodeObject(forKey: "animal_place") as? String
        self.shelter_name = aDecoder.decodeObject(forKey: "shelter_name") as? String
        self.animal_kind = aDecoder.decodeObject(forKey: "animal_kind") as? String
        self.animal_sex = aDecoder.decodeObject(forKey: "animal_sex") as? String
        self.animal_bodytype = aDecoder.decodeObject(forKey: "animal_bodytype") as? String
        self.animal_colour = aDecoder.decodeObject(forKey: "animal_colour") as? String;
        self.animal_age = aDecoder.decodeObject(forKey: "animal_age") as? String;
        self.animal_sterilization = aDecoder.decodeObject(forKey: "animal_sterilization") as? String
        self.animal_status = aDecoder.decodeObject(forKey: "animal_status") as? String
        self.animal_opendate = aDecoder.decodeObject(forKey: "animal_opendate") as? String
        self.shelter_address = aDecoder.decodeObject(forKey: "shelter_address") as? String
        self.shelter_tel = aDecoder.decodeObject(forKey: "shelter_tel") as? String
        self.album_file = aDecoder.decodeObject(forKey: "album_file") as? String
        self.animal_remark = aDecoder.decodeObject(forKey: "animal_remark") as? String
        self.favorite = aDecoder.decodeBool(forKey: "favorite") as Bool
        self.animal_createtime = aDecoder.decodeObject(forKey: "animal_createtime") as? String
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.animal_id, forKey: "animal_id")
        aCoder.encode(self.animal_subid, forKey: "animal_subid")
        aCoder.encode(self.animal_area_pkid, forKey: "animal_area_pkid")
        aCoder.encode(self.animal_place, forKey: "animal_place")
        aCoder.encode(self.shelter_name, forKey: "shelter_name")
        aCoder.encode(self.animal_kind, forKey: "animal_kind")
        aCoder.encode(self.animal_sex, forKey: "animal_sex")
        aCoder.encode(self.animal_bodytype, forKey: "animal_bodytype")
        aCoder.encode(self.animal_colour, forKey: "animal_colour")
        aCoder.encode(self.animal_age, forKey: "animal_age")
        aCoder.encode(self.animal_sterilization, forKey: "animal_sterilization")
        aCoder.encode(self.animal_status, forKey: "animal_status")
        aCoder.encode(self.shelter_tel, forKey: "shelter_tel")
        aCoder.encode(self.shelter_address, forKey: "shelter_address")
        aCoder.encode(self.album_file, forKey: "album_file")
        aCoder.encode(self.animal_remark, forKey: "animal_remark")
        aCoder.encode(self.favorite, forKey: "favorite")
        aCoder.encode(self.animal_createtime, forKey: "animal_createtime")
        
    }
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


let cityDict = ["2":"臺北市",
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
                "10":"臺中市",
                "20":"臺東縣",
                "11":"彰化縣",
                "21":"澎湖縣",
                "22":"金門縣",
                "23":"連江縣",
]




let sexDict = ["M":"公","F":"母"]
let bodyDict = ["BIG":"大型","MEDIUM":"中型","SMALL":"小型","MINI":"迷你型"]
let ageDict = ["ADULT":"成年","CHILD":"幼年"]
let sterilizationDict = ["T":"已絕育", "N":"未絕育", "F":"未絕育"]

let cityArray = ["不限","臺北市","新北市","基隆市","宜蘭縣","桃園市","新竹縣","新竹市","苗栗縣","臺中市","彰化縣","南投縣","雲林縣","嘉義縣","嘉義市","台南市","高雄市","屏東縣","花蓮縣","臺東縣","澎湖縣","金門縣","連江縣"]
let kindArray = ["不限","狗", "貓"]
let bodyArray = ["不限","大型", "中型", "小型", "迷你型"]
let ageArray = ["不限","成年", "幼年"]
let colorArray = ["不限","白色", "黑色", "棕色", "黃色", "虎斑", "花色", "其他"]
let sexArray = ["不限", "公", "母"]

let searchOptions = ["區域", "分類", "體型", "年紀", "毛色", "性別"]
let searchDict = ["區域":cityArray, "分類":kindArray, "體型":bodyArray, "年紀":ageArray, "毛色":colorArray, "性別":sexArray]

let reverseCityDict:[String:String] = {
    var dict = [String:String]()
    for (key,value) in cityDict {
        dict[value] = key
    }
    return dict
}()
let reversesexDict = ["公":"M","母":"F"]
let reversebodyDict = ["大型":"BIG","中型":"MEDIUM","小型":"SMALL","迷你型":"MINI"]
let reverseageDict = ["成年":"ADULT","幼年":"CHILD"]










