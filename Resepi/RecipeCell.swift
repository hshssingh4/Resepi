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
    @IBOutlet var favoriteRecipeButton: UIButton!
    
    var recipe: Recipe! {
        didSet {
            nameLabel.text = recipe.name
            sourceNameLabel.text = recipe.sourceName
            
            let request = URLRequest(url: recipe.imageUrl)
            recipeImageView.setImageWith(request, placeholderImage: nil, success: {(request:URLRequest!,response:HTTPURLResponse?, image:UIImage!) -> Void in
                self.recipeImageView.image = image
            }, failure: nil)
            
            
            // Also set the gradient colors
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = recipeImageView.bounds
            gradientLayer.colors = ColorPalette.GradientColors.ClearBlack
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            recipeImageView.layer.sublayers?[0].removeFromSuperlayer()
            recipeImageView.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}
