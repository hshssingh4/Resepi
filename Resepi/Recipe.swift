//
//  Recipe.swift
//  Resepi
//
//  Created by Harpreet Singh on 11/11/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit

class Recipe: NSObject {
    var name: String
    var imageUrl: URL
    var sourceName: String
    var calories: Double
    
    init(dataDict: NSDictionary) {
        name = dataDict["label"] as! String
        
        let imageUrlString = dataDict["image"] as! String
        imageUrl = URL(string: imageUrlString)!
        
        sourceName = dataDict["source"] as! String
        calories = dataDict["calories"] as! Double
        
        
        
    }
}
