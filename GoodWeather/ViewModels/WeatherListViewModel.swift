//
//  WeatherListViewModel.swift
//  GoodWeather
//
//  Created by 배상렬 on 2020/02/27.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation

class WeatherListViewModel
{
    private(set) var weatherViewModels = [WeatherViewModel]()
    
    func addWeatherViewMode(_ vm: WeatherViewModel)
    {
        self.weatherViewModels.append(vm);
    }
    
    func numberOfRows(_ section: Int) -> Int
    {
        return self.weatherViewModels.count;
    }
    
    func modelAt(_ index:Int) -> WeatherViewModel
    {
        return self.weatherViewModels[index];
    }
    
    func updateUnit(to unit:Unit)
    {
        
        switch unit
        {
        case .celsius:
            toCelsius();
        case .fahrenheit:
            toFahrenheir();
        }
    }
    
    private func toCelsius()
    {
        weatherViewModels = weatherViewModels.map { vm in
        
            let weatherModel = vm;
            weatherModel.currentTemperature.temperature.value = (weatherModel.currentTemperature.temperature.value - 32) * 5/9;
            return weatherModel;
            
        }
        
    }
    
    private func toFahrenheir()
    {
        weatherViewModels = weatherViewModels.map { vm in
            
            let weatherModel = vm;
            weatherModel.currentTemperature.temperature.value = (weatherModel.currentTemperature.temperature.value * 9/5) + 32;
            return weatherModel;
            
        }
    }
    
}

// Type Eraser

class Dynamic<T>: Decodable where T: Decodable
{
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    var value: T
    {
        didSet
        {
            listener?(value);
        }
    }
    
    func bind(listener: @escaping Listener)
    {
        self.listener = listener;
        self.listener?(self.value);
    }
    
    init(_ value: T)
    {
        self.value = value;
    }
    
    private enum CodingKeys: CodingKey
    {
        case value
    }
}



struct WeatherViewModel: Decodable
{
    let name: Dynamic<String>
    var currentTemperature: TemperatureViewModel
    
    private enum CodingKeys: String, CodingKey
    {
        case name
        case currentTemperature = "main"
    }
    
    init(name name: String, currentTemperature temperature: TemperatureViewModel)
    {
        self.name = Dynamic(name);
        self.currentTemperature = temperature;
    }
    
    init(from decoder:Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self);
        name = Dynamic(try container.decode(String.self, forKey: .name))
        currentTemperature = try container.decode(TemperatureViewModel.self, forKey: .currentTemperature);
    }
    
}

struct TemperatureViewModel: Decodable
{
    var temperature: Dynamic<Double>
    let temperatureMin: Dynamic<Double>
    let temperatureMax: Dynamic<Double>
    
    private enum CodingKeys: String, CodingKey
    {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
    
    init(temperature temperature: Double, temperatureMin temp_min: Double, temperatureMax temp_max: Double)
    {
        self.temperature = Dynamic(temperature);
        self.temperatureMin = Dynamic(temp_min);
        self.temperatureMax = Dynamic(temp_max);
    }
    
    init(from decoder:Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self);
        temperature = Dynamic(try container.decode(Double.self, forKey: .temperature));
        temperatureMin = Dynamic(try container.decode(Double.self, forKey: .temperatureMin));
        temperatureMax = Dynamic(try container.decode(Double.self, forKey: .temperatureMax));
    }
}
