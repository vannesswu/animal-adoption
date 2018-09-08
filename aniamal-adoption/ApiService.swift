//
//  APIService.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/2/7.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import Foundation
import UIKit


class ApiService:NSObject {


  static let shareInstatance = ApiService()

  let baseUrl = "http://data.coa.gov.tw/Service/OpenData/TransService.aspx"
  let fbBaseUrl = "https://nodejs-fbanimal-server.herokuapp.com/api/fbanimals/"

  func fetchAnimals(_ parameter:String, completion:@escaping ([Animal], _ error:Error?) -> ()) {
    let urlWithParameter = baseUrl + "?UnitId=QcbUEzN6E6DL" + parameter

    let url = URL(string:urlWithParameter)
    var animals = [Animal]()

//        var str = "狗"
//        let utf8Data = str.addEncoding()
//        print(utf8Data)

    URLSession.shared.dataTask(with:url!) { (data, response, error) in
      if error != nil {
        DispatchQueue.main.async {
          completion([Animal](), error)
        }
        print(error ?? "")
        return
      }
      do {
        let jsonDict = try JSONSerialization.jsonObject(with:data!, options:.mutableContainers) as! [[String:AnyObject]]

        for dict in jsonDict {

          let animal = Animal(dict as NSDictionary)
          if let createDate = animal.animal_createtime, Animal.judgeDateIsQualified(createDate) {

            animals.append(animal)
          }
        }
        DispatchQueue.main.async {
          completion(animals, error)
        }

      } catch let error {
        print(error)
      }


    }.resume()

  }

  func fetchFBAnimal(completion:@escaping ([FBAnimal], _ error:Error?) -> ()) {

    let url = URL(string:fbBaseUrl)
    var fbAnimals = [FBAnimal]()

    URLSession.shared.dataTask(with:url!) { (data, response, error) in
      if error != nil {
        DispatchQueue.main.async {
          completion([FBAnimal](), error)
        }
        print(error ?? "")
        return
      }
      do {
        let jsonDict = try JSONSerialization.jsonObject(with:data!, options:.mutableContainers) as! [[String:AnyObject]]

        for dict in jsonDict {

          let animal = FBAnimal(dict as NSDictionary)
          fbAnimals.append(animal)

        }
        DispatchQueue.main.async {
          completion(fbAnimals, error)
        }

      } catch let error {
        print(error)
      }
    }.resume()
  }


  func transDictToUrlFormat(_ dict:[String:String?]) -> String {

    var parameterArray = [String]()
    for (key, value) in dict {
      if let value = value, value != "不限" {
        switch key {
        case "區域":
          let pkg_id = reverseCityDict[value]!
          parameterArray.append("animal_area_pkid=\(pkg_id)")
        case "分類":
          parameterArray.append("animal_kind=\(value.addEncoding())")
        case "體型":
          let body = reversebodyDict[value]!
          parameterArray.append("animal_bodytype=\(body.addEncoding())")
        case "年紀":
          let age = reverseageDict[value]!
          parameterArray.append("animal_age=\(age.addEncoding())")
        case "毛色":
          parameterArray.append("animal_colour=\(value.addEncoding())")
        case "性別":
          let sex = reversesexDict[value]!
          parameterArray.append("animal_sex=\(sex.addEncoding())")
        default:
          break

        }
      }
    }
    return parameterArray.isEmpty ? "" :"&\(parameterArray.joined(separator:"&"))"
  }


}

extension String {


  func addEncoding() -> String {

    return self.addingPercentEncoding(withAllowedCharacters:.urlHostAllowed)!

  }

}


