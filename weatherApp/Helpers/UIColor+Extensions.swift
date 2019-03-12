//
//  UIColor+Extensions.swift
//  weatherApp
//
//  Created by Michael Bielodied on 3/12/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    public convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    public static let navigationBar = UIColor(netHex: 0xEE4743)
    public static let navigationBarTint = UIColor.white
    public static let statusBar  = UIColor(netHex: 0x9A36AC)
    public static let errorView = UIColor(netHex: 0xE8E072)
    public static let mainBg = UIColor.white
    public static let text = UIColor(netHex: 0x595959)
}
