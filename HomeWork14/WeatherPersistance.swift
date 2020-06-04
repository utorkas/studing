//
//  WeatherPersistance.swift
//  HomeWork14
//
//  Created by Сергей Кузнецов on 26.05.2020.
//  Copyright © 2020 Сергей Кузнецов. All rights reserved.
//

import Foundation


class WeatherPersistance: WeatherViewController{
    static let shared = WeatherPersistance()
    private let kCurrentTempKey = "Persistance.kCurrentTempKey"
    private let kCityKey = "Persistance.kCityKey"
    private let kTempKey = "Persistance.kTempKey"
    private let kDateKey = "Persistance.kDateKey"
    var currentTemp: String? {
        set {UserDefaults.standard.set(newValue, forKey: kCurrentTempKey)}
        get {return UserDefaults.standard.string(forKey: kCurrentTempKey)}
    }
    var cityName: String? {
        set {UserDefaults.standard.set(newValue, forKey: kCityKey)}
        get {return UserDefaults.standard.string(forKey: kCityKey)}
    }
    var futureTemp: String? {
        set {UserDefaults.standard.set(newValue, forKey: kTempKey)}
        get {return UserDefaults.standard.string(forKey: kTempKey)}
    }
    var date: String? {
        set {UserDefaults.standard.set(newValue, forKey: kDateKey)}
        get {return UserDefaults.standard.string(forKey: kDateKey)}
    }
}
