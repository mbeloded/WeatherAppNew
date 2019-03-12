//
//  WeatherItem.swift
//  weatherApp
//
//  Created by Michael Bielodied on 3/11/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import Foundation

//{"coord":{"lon":37.62,"lat":55.75},"sys":{"type":1,"id":7323,"message":0.0036,"country":"RU","sunrise":1485753940,"sunset":1485784855},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"main":{"temp":-10.5,"pressure":1028,"humidity":66,"temp_min":-11,"temp_max":-10},"visibility":10000,"wind":{"speed":5,"deg":200},"clouds":{"all":0},"dt":1485793175,"id":524901,"name":"Moscow"}

struct WeatherListItem: Decodable {
    
    let id: Int
    let sys: SysInfo
    let weather: [WeatherInfo]
    let main: MainInfo
    let dt: Int
    let name: String
    
}
