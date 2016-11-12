//
//  RecipeDetailsViewController.swift
//  Resepi
//
//  Created by Harpreet Singh on 11/11/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController {
    var recipe: Recipe!
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var recipeImageView: UIImageView!
    @IBOutlet var ingredientsLabel: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet var infoView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = ColorPalette.BrandColor
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: ColorPalette.WhiteColor]
        self.title = "Details"
        navigationController?.navigationBar.tintColor = ColorPalette.WhiteColor
        let barButton = UIBarButtonItem(title: "Instructions", style: UIBarButtonItemStyle.plain, target: self, action: #selector(RecipeDetailsViewController.onInstructionsButton))
        self.navigationItem.setRightBarButton(barButton, animated: false)

        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height + 5)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func initView() {
        
        let request = URLRequest(url: recipe.imageUrl)
        recipeImageView.setImageWith(request, placeholderImage: nil, success: {(request:URLRequest!,response:HTTPURLResponse?, image:UIImage!) -> Void in
            self.recipeImageView.image = image
        }, failure: nil)

        for ingredient in recipe.ingredients {
            ingredientsLabel.text = "\(ingredientsLabel.text!) \(ingredient)\n"
        }
    }
    
    func onInstructionsButton() {
        UIApplication.shared.open(recipe.sourceUrl, options: [:], completionHandler: nil)
    }
    

}
