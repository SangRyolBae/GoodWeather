//
//  WeatherCell.swift
//  GoodWeather
//
//  Created by Mohammad Azam on 12/1/18.
//  Copyright © 2018 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func configure(_ weatherVM:WeatherViewModel)
    {
        self.cityNameLabel.text = weatherVM.name.value;
        self.temperatureLabel.text = weatherVM.currentTemperature.temperature.value.formatAsDegree;
    }
}
