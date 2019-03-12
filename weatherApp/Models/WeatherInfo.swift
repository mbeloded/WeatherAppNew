//
//  WeatherInfo.swift
//  weatherApp
//
//  Created by Michael Bielodied on 3/11/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import Foundation
//{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}

struct WeatherInfo: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
