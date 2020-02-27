//
//  WeatherListViewModel.swift
//  GoodWeather
//
//  Created by 배상렬 on 2020/02/27.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation

struct WeatherListViewModel
{
    private var weatherViewModels = [WeatherViewModel]()
    
    mutating func addWeatherViewMode(_ vm: WeatherViewModel)
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
}


struct WeatherViewModel: Decodable
{
    let name: String
    let currentTemperature: TemperatureViewModel
    
    private enum CodingKeys: String, CodingKey
    {
        case name
        case currentTemperature = "main"
    }
}

struct TemperatureViewModel: Decodable
{
    let temperature: Double
    let temperatureMin: Double
    let temperatureMax: Double
    
    private enum CodingKeys: String, CodingKey
    {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
}
