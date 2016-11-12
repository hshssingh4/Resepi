//
//  ColorPalette.swift
//  Resepi
//
//  Created by Harpreet Singh on 11/11/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import Foundation
import UIKit

// Custom class to manage and abstract out the color scheme of our app.
struct ColorPalette {
    static let BrandColor = UIColor(red: 33.0/255.0, green: 39.0/255.0, blue: 107.0/255.0, alpha: 1.0)
    static let WhiteColor = UIColor.white
    static let NewColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
    
    struct GradientColors {
        static let ClearBlack = [UIColor.clear.cgColor, ColorPalette.NewColor.cgColor]
    }
}

