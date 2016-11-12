//
//  RecipesViewController.swift
//  Resepi
//
//  Created by Harpreet Singh on 11/8/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    let dataManager: DataManager = DataManager()
    
    @IBOutlet var searchBar: UISearchBar!
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
        searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let cell = sender as? UICollectionViewCell {
            let indexPath = recipesCollectionView.indexPath(for: cell)
            let recipe = dataManager.filteredRecipes[(indexPath?.row)!]
            let detailsViewController = segue.destination as! RecipeDetailsViewController
            
            detailsViewController.recipe = recipe
        }
    }
    
    
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
            self.dataManager.filteredRecipes = self.dataManager.recipes
            self.recipesCollectionView.reloadData()
        }) { (error: Error) in
            print(error.localizedDescription)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.filteredRecipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recipesCollectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        cell.recipe = dataManager.filteredRecipes[indexPath.row]
        return cell
    }
    
    
    // Search bar functions.
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            dataManager.filteredRecipes = dataManager.recipes
        }
        else {
            // Search here for filtered content
            dataManager.filteredRecipes = []
            
            ResepiClient.getRecepies(searchTerm: searchText, { (resultsDict: [NSDictionary]) in
                
                for resultDict in resultsDict {
                    let recipeDict = resultDict["recipe"] as! NSDictionary
                    let recipe = Recipe(dataDict: recipeDict)
                    
                    self.dataManager.filteredRecipes.append(recipe)
                }
                self.recipesCollectionView.reloadData()
            }) { (error: Error) in
                print(error.localizedDescription)
            }
        }
        
        self.recipesCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        self.searchBar.endEditing(true)
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        self.searchBar.text = ""
        self.searchBar(searchBar, textDidChange: self.searchBar.text!)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
    }
}
