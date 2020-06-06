//
//  AlamoLoader.swift
//  HomeWork14
//
//  Created by Сергей Кузнецов on 26.05.2020.
//  Copyright © 2020 Сергей Кузнецов. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

protocol  AlamoCurrentWeatherDelegate {
    func cities (city: String, temp: Double)
}

class AlamoLoader {
    var city = ""
    var temp = 0.0
    var delegate: AlamoCurrentWeatherDelegate?
    var forecast = URLs()
    private let realm = try! Realm()
    func loadWeather( completion: @escaping ([Category]) -> Void ){
        AF.request(forecast.fiveDays).responseJSON{
            response in
           debugPrint(response)
            if let objects = response.value,
            let jsonDict = objects as? NSDictionary{
                    var categories: [Category] = []
                    
                    let array = jsonDict["list"] as! NSArray
                    for item in array {
                        if let category = Category(data: item as! NSDictionary)
                        { categories.append(category)
                            try! self.realm.write {
                                self.realm.add(categories)
                            }
                        }
                    }
                DispatchQueue.main.async {
                    completion(categories)
                }
            }
        }
    }
    
    func loadCurrentWeather () {
        AF.request(forecast.current).responseJSON { response in
            debugPrint(response)
            if let objects = response.value,
            let jsonDict = objects as? NSDictionary{
                
                let array = jsonDict["main"] as! NSDictionary
                let temp = array["temp"] as! Double
                self.temp = temp

                let cityDict = jsonDict["name"] as! String
                self.city = cityDict
                DispatchQueue.main.async {
                    self.delegate?.cities(city: self.city, temp: self.temp)
                }
            }
        }
    }
}

