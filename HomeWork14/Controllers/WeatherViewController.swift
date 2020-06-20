//
//  WeatherViewController.swift
//  HomeWork14
//
//  Created by Сергей Кузнецов on 19.05.2020.
//  Copyright © 2020 Сергей Кузнецов. All rights reserved.
//

import UIKit

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
       alamoCity.text = WeatherPersistance.shared.cityName
       alamoTempCurrent.text = WeatherPersistance.shared.currentTemp
    }
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AddOrUpdate().weatherObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlamoCell") as! AlamoCell
        let model = AddOrUpdate().weatherObjects[indexPath.row]
        cell.alamoDate.text = model.dt_txt
        cell.alamoTemp.text = model.temp
        return cell
    }
}


