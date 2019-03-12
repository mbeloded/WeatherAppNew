//
//  UITableView+Extensions.swift
//  weatherApp
//
//  Created by Michael Bielodied on 3/11/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import UIKit

extension UITableViewCell {
    class var identifierCell: String {
        return String(describing: self)
    }
    
    class var nibCell: UINib {
        return UINib(nibName: identifierCell, bundle: nil)
    }
}
