//
//  Recipe.swift
//  Resepi
//
//  Created by Harpreet Singh on 11/11/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit
import Parse

class Recipe: NSObject, NSCoding {
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
    
    // Using NSCoding to store the dict and to load it back in
    
    // Decodes the values
    required init(coder decoder: NSCoder) {
        name = decoder.decodeObject(forKey: "\(PFUser.current()?.username!)name") as! String
        imageUrl = decoder.decodeObject(forKey: "\(PFUser.current()?.username!)imageURL") as! URL
        sourceName = decoder.decodeObject(forKey: "\(PFUser.current()?.username!)sourceName") as! String
        sourceUrl = decoder.decodeObject(forKey: "\(PFUser.current()?.username!)sourceURL") as! URL
        calories = decoder.decodeDouble(forKey: "\(PFUser.current()?.username!)calories")
        ingredients = decoder.decodeObject(forKey: "\(PFUser.current()?.username!)ingredients") as! [String]
    }
    
    // Encodes the values
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "\(PFUser.current()?.username!)name")
        coder.encode(self.imageUrl, forKey: "\(PFUser.current()?.username!)imageURL")
        coder.encode(self.sourceName, forKey: "\(PFUser.current()?.username!)sourceName")
        coder.encode(self.sourceUrl, forKey: "\(PFUser.current()?.username!)sourceURL")
        coder.encode(self.calories, forKey: "\(PFUser.current()?.username!)calories")
        coder.encode(self.ingredients, forKey: "\(PFUser.current()?.username!)ingredients")
    }
}
