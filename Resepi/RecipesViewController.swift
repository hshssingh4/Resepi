//
//  RecipesViewController.swift
//  Resepi
//
//  Created by Harpreet Singh on 11/8/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let dataManager: DataManager = DataManager()
    
    @IBOutlet var recipesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = ColorPalette.BrandColor
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: ColorPalette.WhiteColor]
        
        // Now since the view has loaded, initialize the data manager
        self.initData()
        
        recipesCollectionView.delegate = self
        recipesCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /**
     This method reads data from the databse and does everything to populate the
     data manager.
     */
    func initData() {
        ResepiClient.getRecepies(searchTerm: "food", { (resultsDict: [NSDictionary]) in

            for resultDict in resultsDict {
                let recipeDict = resultDict["recipe"] as! NSDictionary
                let recipe = Recipe(dataDict: recipeDict)
                
                self.dataManager.addRecipe(recipe: recipe)
            }
            self.recipesCollectionView.reloadData()
        }) { (error: Error) in
            print(error.localizedDescription)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recipesCollectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        cell.recipe = dataManager.recipes[indexPath.row]
        return cell
    }
    
    
    
    
    
    
}
