//
//  RecipeCell.swift
//  Resepi
//
//  Created by Harpreet Singh on 11/11/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit
import AFNetworking

class RecipeCell: UICollectionViewCell {
    @IBOutlet var recipeImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var sourceNameLabel: UILabel!
    
    
    var recipe: Recipe! {
        didSet {
            nameLabel.text = recipe.name
            sourceNameLabel.text = recipe.sourceName
            
            let request = URLRequest(url: recipe.imageUrl)
            recipeImageView.setImageWith(request, placeholderImage: nil, success: {(request:URLRequest!,response:HTTPURLResponse?, image:UIImage!) -> Void in
                self.recipeImageView.image = image
            }, failure: nil)
            
        }
    }
}
