//
//  WeatherItemsListDataSource.swift
//  weatherApp
//
//  Created by Michael Bielodied on 3/11/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import UIKit

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

class WeatherItemsListDataSource : GenericDataSource<WeatherListItem>, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherItemTableViewCell.identifierCell, for: indexPath) as! WeatherItemTableViewCell
        
        let weatherItem = data.value[indexPath.row]
        cell.viewModel = WeatherItemViewModel(weatherItem)
        
        return cell
    }
}
