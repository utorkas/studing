//
//  Weather.swift
//  HomeWork14
//
//  Created by Сергей Кузнецов on 26.05.2020.
//  Copyright © 2020 Сергей Кузнецов. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    var main: NSDictionary?
    var weather: NSArray?
    @objc dynamic var dt_txt: String?
    @objc dynamic var temp: String?
    convenience init?(data: NSDictionary){
        self.init()
        guard let main = data["main"] as? NSDictionary,
            let weather = data["weather"] as? NSArray,
            let temp = main["temp"] as? Double,
            let dx_txt = data["dt_txt"] as? String else  { return }
        self.main = main
        self.weather = weather
        self.dt_txt = dx_txt
        self.temp = String(format: "%.0f", temp - 273.15)
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

class AddOrUpdate {
    static let addOrUpdate = AddOrUpdate()
    private let realm = try! Realm()
    lazy var weatherObjects: Results<Category> = {self.realm.objects(Category.self)}()
    func deleteData(){
        try! realm.write{
            realm.deleteAll()
        }
    }
}
