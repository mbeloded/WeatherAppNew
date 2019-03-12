//
//  Common.swift
//  weatherApp
//
//  Created by Michael Bielodied on 3/11/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import Foundation

public class Common : NSObject
{
    
    struct Global{
        static let API_URL = "https://api.openweathermap.org/data/2.5"
        
        static let API_WEATHER_CONDITIONS = "http://openweathermap.org/img/w/%@.png"
        static let API_GET_GROUP_CITIES_INFO = "/group?id=%@&units=metric"
        
        static let KYIV_CITY_ID = 703448
        static let TORONTO_CITY_ID = 6167865
        static let LONDON_CITY_ID = 2643741
        static let APP_ID = "&appid=a1d1dc41d71e2b1c1d329e64770bf088"
    }
    
    static var getGroupCities: String {
        return Common.Global.API_URL + Common.Global.API_GET_GROUP_CITIES_INFO + Common.Global.APP_ID
    }
    
    static var getWeatherConditionIcon: String {
        return Common.Global.API_WEATHER_CONDITIONS
    }
    
}
