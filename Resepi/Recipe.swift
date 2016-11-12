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
    var sourceUrl: URL
    var calories: Double
    var ingredients: [String]
    
    
    init(dataDict: NSDictionary) {
        name = dataDict["label"] as! String
        
        let imageUrlString = dataDict["image"] as! String
        imageUrl = URL(string: imageUrlString)!
        
        let sourceUrlString = dataDict["url"] as! String
        sourceUrl = URL(string: sourceUrlString)!
        
        
        sourceName = dataDict["source"] as! String
        calories = dataDict["calories"] as! Double
        ingredients = dataDict["ingredientLines"] as! [String]
    }
}
