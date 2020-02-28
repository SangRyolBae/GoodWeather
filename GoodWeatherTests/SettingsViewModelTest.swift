//
//  SettingsViewModelTest.swift
//  GoodWeatherTests
//
//  Created by 배상렬 on 2020/02/28.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import XCTest
@testable import GoodWeather

class SettingsViewModelTest: XCTestCase
{
    
    private var settingsVM: SettingsViewModel!

    override func setUp()
    {
        super.setUp();
        
        self.settingsVM = SettingsViewModel();
    }
    
    
    override func tearDown()
    {
        super.tearDown();
        
        let userDefaults = UserDefaults.standard;
        userDefaults.removeObject(forKey: "unit");
    }
    
    func test_should_return_current_display_name_for_fahrenheit()
    {
        XCTAssertEqual(self.settingsVM.selectedUnit.displayName, "Fahrenheit");
    }
    
    func test_should_make_sure_that_default_selected_unit_is_fahrenheit()
    {
        XCTAssertEqual(settingsVM.selectedUnit, .fahrenheit);
        
    }
    
    func test_should_be_able_to_save_user_unit_selection()
    {
        self.settingsVM.selectedUnit = .celsius;
        
        let userDefaults = UserDefaults.standard;
        
        XCTAssertNotNil(userDefaults.value(forKey: "unit"));
    }
}
