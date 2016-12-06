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
    var favoriteRecipes: [Recipe] = []
    var foodType: String?
    var dietType: String?
    
    func addRecipe(recipe: Recipe) {
        recipes.append(recipe)
    }
    
    /**
     This method add a recipe to the favories array.
     */
    func addFavorite(_ recipe: Recipe) {
        favoriteRecipes.append(recipe)
    }
    
    /**
     This method removes a recipe from the favories array.
     */
    func removeFavorite(_ index: Int) {
        favoriteRecipes.remove(at: index)
    }
    
    
    func isFavorite(_ recipe: Recipe) -> Bool {
        for favorite in favoriteRecipes {
            if favorite.name == recipe.name {
                return true
            }
        }
        return false
    }
    
    /**
     This method returns the index of the recipe passed as the argument in favorites array.
     */
    func indexOfFavorite(_ recipe: Recipe) -> Int {
        for index in 0...(favoriteRecipes.count-1) {
            if favoriteRecipes[index].name == recipe.name {
                return index
            }
        }
        return -1
    }
}
