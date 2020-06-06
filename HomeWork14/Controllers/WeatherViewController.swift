//
//  WeatherViewController.swift
//  HomeWork14
//
//  Created by Сергей Кузнецов on 19.05.2020.
//  Copyright © 2020 Сергей Кузнецов. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class WeatherViewController: UIViewController {

 var categories: [Category] = []
    private let realm = try! Realm()
    
    @IBOutlet weak var alamoCity: UILabel!
    @IBOutlet weak var alamoTempCurrent: UILabel!
    @IBOutlet weak var alamoTableView: UITableView!
    
    @IBAction func updateData(_ sender: Any) {
        AlamoLoader().loadWeather { categories in
        self.categories = categories
            self.alamoTableView.reloadData() }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loader = AlamoLoader()
        loader.delegate = self
        loader.loadCurrentWeather()
        alamoCity.text = WeatherPersistance.shared.cityName
        alamoTempCurrent.text = WeatherPersistance.shared.currentTemp
        
    }
    
}
extension WeatherViewController: AlamoCurrentWeatherDelegate {
    func cities(city: String, temp: Double) {
        //WeatherPersistance.shared.cityName = city
        WeatherPersistance.shared.currentTemp = String(format: "%.0f", temp-273.15)
        print(WeatherPersistance.shared.cityName!)
        print(WeatherPersistance.shared.currentTemp!)
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.realm.objects(Category.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlamoCell") as! AlamoCell
        let model = self.realm.objects(Category.self)[indexPath.row]
       // WeatherPersistance.shared.date = model.dt_txt
        cell.alamoDate.text = model.dt_txt
        //WeatherPersistance.shared.futureTemp = model.temp!
        cell.alamoTemp.text = model.temp!
        return cell
    }
}


