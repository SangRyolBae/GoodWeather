//
//  Double+Extensions.swift
//  GoodWeather
//
//  Created by 배상렬 on 2020/02/27.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation

extension Double
{
    var formatAsDegree: String
    {
        return String(format: "%.0fº", self);
    }
}
