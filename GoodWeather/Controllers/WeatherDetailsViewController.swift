//
//  WeatherDetailsViewController.swift
//  GoodWeather
//
//  Created by 배상렬 on 2020/02/28.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit


class WeatherDetailsViewController: UIViewController
{
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    var weatherViewModel: WeatherViewModel?
 
    override func viewDidLoad()
    {
        super.viewDidLoad();
        
        setupVMBindings();
        
//        if let weatherVM = self.weatherViewModel
//        {
//            self.cityNameLabel.text = weatherVM.name.value;
//            self.currentTemperatureLabel.text = weatherVM.currentTemperature.temperature.value.formatAsDegree;
//            self.maxTempLabel.text = weatherVM.currentTemperature.temperatureMax.value.formatAsDegree;
//            self.minTempLabel.text = weatherVM.currentTemperature.temperatureMin.value.formatAsDegree;
//        }
//
    }
    
    private func setupVMBindings()
    {
        if let weatherVM = self.weatherViewModel
        {
            weatherVM.name.bind { (value) in
                self.cityNameLabel.text = value;
            }
            
            weatherVM.currentTemperature.temperature.bind { (value) in
                self.currentTemperatureLabel.text = value.formatAsDegree;
            }
            
            weatherVM.currentTemperature.temperatureMax.bind { (value) in
                self.maxTempLabel.text = value.formatAsDegree;
            }
            
            weatherVM.currentTemperature.temperatureMin.bind { (value) in
                self.minTempLabel.text = value.formatAsDegree;
            }
            
            // change the value after few seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                
                self.weatherViewModel?.name.value = "Boston";
                
            }
        }
    }
}
