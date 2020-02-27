//
//  AddWeatherCityViewController.swift
//  GoodWeather
//
//  Created by Mohammad Azam on 12/1/18.
//  Copyright © 2018 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit

protocol AddWeatherDelegate
{
    func addWeatherDidsave(vm: WeatherViewModel);
    
}

class AddWeatherCityViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    
    var delegate: AddWeatherDelegate?
    
    
    @IBAction func saveCityButtonPressed() {
        
        if let city = cityNameTextField.text
        {
            let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=ed6e0287da157548a5c77786cb05bef7&units=imperial")!;
            
            let weatherResource = Resource<WeatherViewModel>(url: weatherURL) { data in
                
                let weatherVM = try? JSONDecoder().decode(WeatherViewModel.self, from: data);
                
                print( "insert data" );
                return weatherVM;
                
            }
            
            
            Webservice().load(resource: weatherResource) { [weak self](result) in
                
                print("response complete : \(result)");
                
                if let weatherVM = result
                {
                    if let delegate = self?.delegate
                    {
                        delegate.addWeatherDidsave(vm: weatherVM);
                        self?.dismiss(animated: true, completion: nil);
                    }
                }
                
            }
            
            
        }
        
    }
    
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
