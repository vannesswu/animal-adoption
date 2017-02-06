//
//  APIService.swift
//  animal-adoption
//
//  Created by 吳建豪 on 2017/2/7.
//  Copyright © 2017年 吳建豪. All rights reserved.
//

import Foundation
import UIKit


class ApiService: NSObject {


static let shareInstatance = ApiService()
    
    let baseUrl = "http://data.coa.gov.tw/Service/OpenData/AnimalOpenData.aspx"
    
    
    func fetchAnimals(_ urlString:String, completion: @escaping ([Animal]) -> () ){
        
       
        let url = URL(string: "http://data.coa.gov.tw/Service/OpenData/AnimalOpenData.aspx?$top=5000&$skip=0&$filter=animal_kind+like+%E7%8B%97+and+animal_place+like+%E5%8F%B0%E5%8D%97")
        var animals = [Animal]()
        
//        var str = "狗"
//        let utf8Data = str.addEncoding()
//        print(utf8Data)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            do {
                let jsonDict = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [[String:AnyObject]]
            
                for dict in jsonDict {
                    
                   let animal = Animal(dict as NSDictionary)
                    animals.append(animal)
                }
                DispatchQueue.main.async {
                    completion(animals)
                }
            
            } catch let error{
                print(error)
            }
            
            
        }.resume()
        
    }



}

extension String {
    
    
    func addEncoding() ->String? {
        
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
    }
    
}


