//
//  WeatherListViewModelTests.swift
//  GoodWeatherTests
//
//  Created by 배상렬 on 2020/02/28.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import XCTest
@testable import GoodWeather

class WeatherListViewModelTests: XCTestCase
{
    
    private var weatherListVM: WeatherListViewModel!
    

    override func setUp()
    {
        super.setUp();
        
        self.weatherListVM = WeatherListViewModel();
        
        self.weatherListVM.addWeatherViewMode(WeatherViewModel(name: "Houston", currentTemperature: TemperatureViewModel(temperature: 32, temperatureMin: 0, temperatureMax: 0)));
        
        self.weatherListVM.addWeatherViewMode(WeatherViewModel(name: "Austin", currentTemperature: TemperatureViewModel(temperature: 72, temperatureMin: 0, temperatureMax: 0)));
        
    }

    override func tearDown()
    {
        super.tearDown();
    }

    func test_should_be_able_to_convert_to_calsius_successfully()
    {
        let celsiusTemperatures = [0, 22.2222];
        
        self.weatherListVM.updateUnit(to: .celsius);
        
        for( index, vm ) in self.weatherListVM.weatherViewModels.enumerated()
        {
            XCTAssertEqual(round(vm.currentTemperature.temperature.value), round(celsiusTemperatures[index]));
        }
    }
    

}
