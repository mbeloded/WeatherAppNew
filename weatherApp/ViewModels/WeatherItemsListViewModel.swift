//
//  WeatherItemsListViewModel.swift
//  weatherApp
//
//  Created by Michael Bielodied on 3/11/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import Foundation

final class WeatherItemsListViewModel {
    weak var dataSource : GenericDataSource<WeatherListItem>?
    weak var service: WeatherServiceProtocol?
    
    private var isFetchInProgress = false
    
    init(service: WeatherServiceProtocol = WeatherService.shared, dataSource : GenericDataSource<WeatherListItem>?) {
        self.dataSource = dataSource
        self.service = service
    }
    
    func fetchItems(_ completion: ((Result<Bool, ErrorResult>) -> Void)? = nil) {
        
        guard let service = service else {
            completion?(Result.failure(ErrorResult.custom(string: "Missing service")))
            return
        }
        
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        service.fetchItems(for:[Common.Global.KYIV_CITY_ID, Common.Global.TORONTO_CITY_ID, Common.Global.LONDON_CITY_ID], completion: { result in
            
            switch result {
            case .success(let response) :
                
                DispatchQueue.main.async {
                    
                    // 1
                    self.isFetchInProgress = false
                    
                    // 2
                    self.dataSource?.data.value.removeAll()
                    // reload data
                    self.dataSource?.data.value.append(contentsOf: response.list)
                    
                    completion?(Result.success(true))
                    
                }
                break
            case .failure(let error) :
                
                DispatchQueue.main.async {
                    print("Parser error \(error)")
                    
                    var errorMsg = error.localizedDescription
                    
                    if let milisecond = self.dataSource?.data.value.first?.dt {
                        let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(milisecond)/1000)
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "hh:mm"
                        let dateStr = dateFormatter.string(from: dateVar)
                        errorMsg = "Offline mode. This weather was actual at " + dateStr
                    }
                    self.isFetchInProgress = false
                    
                    switch error {
                        case .offline( _):
                            completion?(Result.failure(ErrorResult.offline(string: errorMsg)))
                        case .network( _):
                            completion?(Result.failure(ErrorResult.network(string: errorMsg)))
                        default:
                            completion?(Result.failure(error))
                    }
                }
                break
            }
            
        })
    }
}
