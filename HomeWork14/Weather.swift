//
//  Weather.swift
//  HomeWork14
//
//  Created by Сергей Кузнецов on 26.05.2020.
//  Copyright © 2020 Сергей Кузнецов. All rights reserved.
//

import Foundation

class Category {
    var main: NSDictionary?
    var weather: NSArray?
    var dt_txt: String?
    var temp: Double?
    init?(data: NSDictionary){
        guard let main = data["main"] as? NSDictionary,
            let weather = data["weather"] as? NSArray,
            let temp = main["temp"] as? Double,
            let dx_txt = data["dt_txt"] as? String else  { return }
        self.main = main
        self.weather = weather
        self.dt_txt = dx_txt
        self.temp = temp

    }
}

class CurrentWeather {
    var city: String?
    var currentTemp: Double?
    init?(data: NSDictionary){
        guard let currentTemp = data["temp"] as? Double,
            let city = data["name"] as? String else { return }
        self.city = city
        self.currentTemp = currentTemp
    }
}
