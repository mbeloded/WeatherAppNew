//
//  UIApplication+Extensions.swift
//  weatherApp
//
//  Created by Michael Bielodied on 3/12/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import UIKit

extension UIApplication {
    class var statusBarBackgroundColor: UIColor? {
        get {
            return (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor
        } set {
            (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor = newValue
        }
    }
}
