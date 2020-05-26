//
//  AlamoLoader.swift
//  HomeWork14
//
//  Created by Сергей Кузнецов on 26.05.2020.
//  Copyright © 2020 Сергей Кузнецов. All rights reserved.
//

import Foundation
import Alamofire

protocol  AlamoCurrentWeatherDelegate {
    func cities (city: String, temp: Double)
}

class AlamoLoader {
    var city = ""
    var temp = 0.0
    var delegate: AlamoCurrentWeatherDelegate?
    
    func loadWeather( completion: @escaping ([Category]) -> Void ){
        AF.request("https://api.openweathermap.org/data/2.5/forecast?q=Moscow&appid=133abbdb38a2cae900c7599f329803ed").responseJSON{
            response in
           debugPrint(response)
            if let objects = response.value,
            let jsonDict = objects as? NSDictionary{
                    var categories: [Category] = []
                    
                    let array = jsonDict["list"] as! NSArray
                    for item in array {
                        if let category = Category(data: item as! NSDictionary)
                        { categories.append(category)}
                    }
                DispatchQueue.main.async {
                    completion(categories)
                }
            }
        }
    }
    
    func loadCurrentWeather () {
        AF.request("https://api.openweathermap.org/data/2.5/weather?q=Moscow&appid=133abbdb38a2cae900c7599f329803ed").responseJSON { response in
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

