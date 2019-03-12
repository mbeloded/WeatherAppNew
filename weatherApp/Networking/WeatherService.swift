//
//  WeatherService.swift
//  weatherApp
//
//  Created by Michael Bielodied on 3/11/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import Foundation

protocol WeatherServiceProtocol : class {
    func fetchItems(for group:[Int], completion: @escaping ((Result<BulkWeatherInfo, ErrorResult>) -> Void))
}

final class WeatherService : RequestHandler, WeatherServiceProtocol {
    
    static let shared = WeatherService()
    
    func fetchItems(for group:[Int], completion: @escaping ((Result<BulkWeatherInfo, ErrorResult>) -> Void)) {
        
        let groupIds = group.map{String($0)}.joined(separator: ",")
        let url = String(format: Common.getGroupCities, groupIds)
        
        APIService.init().get(urlString: url,
                              completion: self.networkResult(completion: completion))
    }
}
