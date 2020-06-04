//
//  WeatherViewController.swift
//  HomeWork14
//
//  Created by Сергей Кузнецов on 19.05.2020.
//  Copyright © 2020 Сергей Кузнецов. All rights reserved.
//

import UIKit
import Alamofire

class WeatherViewController: UIViewController {

 var categories: [Category] = []
    
    @IBOutlet weak var alamoCity: UILabel!
    @IBOutlet weak var alamoTempCurrent: UILabel!
    @IBOutlet weak var alamoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AlamoLoader().loadWeather { categories in
        self.categories = categories
            self.alamoTableView.reloadData() }
        let loader = AlamoLoader()
        loader.delegate = self
        loader.loadCurrentWeather()
        alamoCity.text = WeatherPersistance.shared.cityName
        alamoTempCurrent.text = WeatherPersistance.shared.currentTemp
    }
    
}
extension WeatherViewController: AlamoCurrentWeatherDelegate {
    func cities(city: String, temp: Double) {
        WeatherPersistance.shared.cityName = city
        WeatherPersistance.shared.currentTemp = String(format: "%.0f", temp-273.15)
        //alamoCity.text = WeatherPersistance.shared.cityName
        //alamoTempCurrent.text = WeatherPersistance.shared.currentTemp
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlamoCell") as! AlamoCell
        let model = categories[indexPath.row]
        //cell.alamoDate.text = model.dt_txt
        WeatherPersistance.shared.date = model.dt_txt
        cell.alamoDate.text = WeatherPersistance.shared.date
        let tempCels = model.temp! - 273.15
        //cell.alamoTemp.text = String(format: "%.0f", tempCels)
        WeatherPersistance.shared.futureTemp = String(format: "%.0f", tempCels)
        cell.alamoTemp.text = WeatherPersistance.shared.futureTemp
        return cell
    }
}


