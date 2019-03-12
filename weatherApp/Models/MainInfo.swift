//
//  MainInfo.swift
//  weatherApp
//
//  Created by Michael Bielodied on 3/11/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import Foundation

//{"temp":-10.5,"pressure":1028,"humidity":66,"temp_min":-11,"temp_max":-10}

struct MainInfo: Decodable {
    let temp: Double
    let pressure: Int
}
