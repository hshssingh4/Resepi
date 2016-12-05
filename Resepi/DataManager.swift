//
//  DataManager.swift
//  Resepi
//
//  Created by Harpreet Singh on 11/11/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    var recipes: [Recipe] = []
    var filteredRecipes: [Recipe] = []
    var foodType: String?
    var dietType: String?
    
    func addRecipe(recipe: Recipe) {
        recipes.append(recipe)
    }
}
