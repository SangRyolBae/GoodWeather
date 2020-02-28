//
//  WeatherListTableViewController.swift
//  GoodWeather
//
//  Created by Mohammad Azam on 12/1/18.
//  Copyright © 2018 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit

class WeatherListTableViewController: UITableViewController, AddWeatherDelegate, SettingsDelegate
{
    
    
    
    private var weatherListViewModel = WeatherListViewModel();
    private var datasource: TableViewDataSource<WeatherCell, WeatherViewModel>!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.datasource = TableViewDataSource(cellIdentifier: "WeatherCell", items: self.weatherListViewModel.weatherViewModels, configureCell: { (cell, vm) in
            
            cell.cityNameLabel.text = vm.name.value;
            cell.temperatureLabel.text = vm.currentTemperature.temperature.value.formatAsDegree;
            
        });
        
        
        self.tableView.dataSource = self.datasource
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
        }else if segue.identifier == "WeatherDetailsViewController"
        {
            prepareSugueForWeatherDetailsViewController(segue: segue);
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
    
    private func prepareSugueForWeatherDetailsViewController(segue: UIStoryboardSegue)
    {
        guard let weatherDetailsVC = segue.destination as? WeatherDetailsViewController,
            let indexPath = self.tableView.indexPathForSelectedRow else
        {
            return;
        }
        
        let weatherVM = self.weatherListViewModel.modelAt(indexPath.row);
        
        weatherDetailsVC.weatherViewModel = weatherVM;
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // MARK: - addWeatherDelegates funcions
    func addWeatherDidsave(vm: WeatherViewModel)
    {
        self.weatherListViewModel.addWeatherViewMode(vm);
        self.datasource.updateItems(self.weatherListViewModel.weatherViewModels);
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
