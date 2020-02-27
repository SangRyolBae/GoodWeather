//
//  WeatherListTableViewController.swift
//  GoodWeather
//
//  Created by Mohammad Azam on 12/1/18.
//  Copyright © 2018 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit

class WeatherListTableViewController: UITableViewController, AddWeatherDelegate, SettingsDelegate {
    
    
    
    private var weatherListViewModel = WeatherListViewModel();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // 뷰컨트롤러간 데이터 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "AddWeatherCityViewController"
        {
            prepareSugueForAddWeatherCityViewController(segue: segue);
        }else if segue.identifier == "SettingsTableViewController"
        {
            prepareSugueForSettingsTableViewController(segue: segue);
        }
    }
    
    private func prepareSugueForSettingsTableViewController(segue: UIStoryboardSegue)
    {
        guard let nav = segue.destination as? UINavigationController else
        {
            fatalError("Navigation Controller not found");
        }
        
        guard let settingsTableVC = nav.viewControllers.first as? SettingsTableViewController else
        {
            fatalError("SettingsTableViewController not found");
        }
        
        settingsTableVC.delegate = self;
    }
    
    private func prepareSugueForAddWeatherCityViewController(segue: UIStoryboardSegue)
    {
        guard let nav = segue.destination as? UINavigationController else
        {
            fatalError("Navigation Controller not found");
        }
        
        guard let addWeatherCityVC = nav.viewControllers.first as? AddWeatherCityViewController else
        {
            fatalError("AddWeatherCityController not found");
        }
        
        addWeatherCityVC.delegate = self;
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherListViewModel.numberOfRows(section);
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        
        let weatherVM = self.weatherListViewModel.modelAt(indexPath.row);
        
        cell.configure(weatherVM);
        
        return cell
    }
    
    
    // MARK: - addWeatherDelegates funcions
    func addWeatherDidsave(vm: WeatherViewModel)
    {
        self.weatherListViewModel.addWeatherViewMode(vm);
        self.tableView.reloadData();
        
        print( vm.name );
    }
    
    // MARK: - SettingsDelegates funcions
    func settingsDone(vm: SettingsViewModel)
    {
        self.weatherListViewModel.updateUnit(to: vm.selectedUnit);
        self.tableView.reloadData();
        
        print("ASDF");
    }
    
}
