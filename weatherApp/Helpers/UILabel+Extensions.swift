//
//  UILabel+Extensions.swift
//  weatherApp
//
//  Created by Michael Bielodied on 3/12/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import UIKit

/// UILabel base styles for project
enum LabelStyle: String {
    
    case title = "title"
    //
    case subtitle = "subtitle"
    //
    case degree = "degree"
    
    var font: UIFont {
        switch self {
        case .title:    return UIFont.title
        case .subtitle: return UIFont.subtitle
        case .degree:   return UIFont.main
        }
    }
    
    var fontColor: UIColor {
        switch self {
        default:
            return UIColor.text
        }
    }
    
}

extension UILabel {
    
    /// Button style
    @IBInspectable var style: String? {
        set { setupWithStyle(named:newValue) }
        get { return nil }
    }
    /// Apply style by style name
    private func setupWithStyle(named: String?){
        if let styleName = named, let style = LabelStyle(rawValue: styleName) {
            setupWith(style: style)
        }
    }
    /// Apply style by ID
    func setupWith(style: LabelStyle){
        self.font = style.font
        self.textColor = style.fontColor
    }
}
