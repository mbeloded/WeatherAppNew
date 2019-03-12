//
//  WeatherItemViewModel.swift
//  weatherApp
//
//  Created by Michael Bielodied on 3/11/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import Foundation

struct WeatherItemViewModel {
    let title: String
    let subtitle: String
    let degrees: String?
    let icons: [String]
    
    init(_ item: WeatherListItem) {
        title = item.name + ", " + item.sys.country
        subtitle = item.weather.map{$0.main}.joined(separator: ", ")
        degrees = "\(Int(item.main.temp))°"
        icons = item.weather.map{$0.icon}
    }
}
