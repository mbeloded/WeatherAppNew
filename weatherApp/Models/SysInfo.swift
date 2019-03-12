//
//  SysInfo.swift
//  weatherApp
//
//  Created by Michael Bielodied on 3/11/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import Foundation

//{"type":1,"id":7323,"message":0.0036,"country":"RU","sunrise":1485753940,"sunset":1485784855}

struct SysInfo: Decodable {
    let id: Int
    let type: Int
    let country: String
    let message: Double
}
