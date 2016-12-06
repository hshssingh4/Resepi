//
//  RecipesViewController.swift
//  Resepi
//
//  Created by Harpreet Singh on 11/8/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, AddFiltersViewControllerDelegate, CAAnimationDelegate {
    
    let dataManager: DataManager = DataManager()
    
    @IBOutlet var recipesCollectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    
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
        else if ((sender as? UIBarButtonItem)?.tag == 1) {
            let addFiltersViewController = segue.destination.childViewControllers[0] as! FiltersViewController
            addFiltersViewController.delegate = self
            addFiltersViewController.dietType = dataManager.dietType
            addFiltersViewController.foodType = dataManager.foodType
        }
    }
    
    func addFiltersData(dietType: String, foodType: String) {
        // Get recipes only with filters if they are not none
        var dietParam: String?
        var foodParam: String?
        if (dietType != "None") {
            dietParam = dietType
        }
        if (foodType != "None") {
            foodParam = foodType
        }
        
        dataManager.foodType = foodParam
        dataManager.dietType = dietParam
        
        var searchText = searchBar.text
        if (searchText?.isEmpty)! {
            searchText = "food"
        }
        
        dataManager.filteredRecipes = []
        ResepiClient.getRecepies(searchTerm: searchText!, dietType: dataManager.dietType , foodType: dataManager.foodType, { (resultsDict: [NSDictionary]) in
            for resultDict in resultsDict {
                let recipeDict = resultDict["recipe"] as! NSDictionary
                let recipe = Recipe(dataDict: recipeDict)
                
                self.dataManager.filteredRecipes.append(recipe)
            }
            self.recipesCollectionView.reloadData()
        }) { (error: Error) in
            print(error.localizedDescription)
        }
        
        self.recipesCollectionView.reloadData()
    }
    
    
    /**
     This method reads data from the databse and does everything to populate the
     data manager.
     */
    func initData() {
        ResepiClient.getRecepies(searchTerm: "food", dietType: dataManager.dietType, foodType: dataManager.foodType, { (resultsDict: [NSDictionary]) in

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
    
    @IBAction func onLogoutButton(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure you want to log out?", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        // Two Actions Added.
        alert.addAction(UIAlertAction(title: "Log Out", style: UIAlertActionStyle.destructive, handler: logoutUser))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        // Present the Alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    func logoutUser(_ alert: UIAlertAction) {
        UserClient.logout()
    }
    
    
    /******* COLLECTION VIEW METHODS *******/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.filteredRecipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recipesCollectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        cell.recipe = dataManager.filteredRecipes[indexPath.row]
        
        if dataManager.isFavorite(dataManager.recipes[(indexPath as NSIndexPath).row]) {
            cell.favoriteRecipeButton.setImage(UIImage(named: "Favorite Image"), for: UIControlState())
        }
        else {
            cell.favoriteRecipeButton.setImage(UIImage(named: "Unfavorite Image"), for: UIControlState())
        }
        
        return cell
    }
    
    /**
     This just highlights and unhighlights the cell when user selects and releases a cell to notify them of the touch using an animation.
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = ColorPalette.LightGrayColor
        UIView.animate(withDuration: 0.3, animations: {
            cell?.backgroundColor = ColorPalette.CellColor
        })
        
    }
    
    /**
     This just highlights the cell when user selects it to notify them of the touch.
     */
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = ColorPalette.LightGrayColor
    }
    
    /**
     This method is used for unhilighting the collection view cell's background color.
     */
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = ColorPalette.CellColor
    }
    
    // Favorite Button Pressed
    @IBAction func onFavoriteButtonPressed(_ sender: UIButton) {
        let cell = sender.superview?.superview as! RecipeCell
        let indexPath = self.recipesCollectionView.indexPath(for: cell)
        let recipe = dataManager.recipes[((indexPath as NSIndexPath?)?.row)!]
        
        if dataManager.isFavorite(recipe) {
            let alertController = UIAlertController(title: "Are you sure you want to unfavorite?", message: nil, preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "Unfavorite", style: .destructive, handler: { (action) in
                let index = self.dataManager.indexOfFavorite(recipe)
                self.dataManager.removeFavorite(index)
                sender.setImage(UIImage(named: "Unfavorite Image"), for: UIControlState())
                let transition = CATransition()
                transition.delegate = self
                transition.duration = 0.2
                transition.type = kCATransitionFade
                sender.imageView?.layer.add(transition, forKey: kCATransition)
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            dataManager.addFavorite(recipe)
            
            sender.setImage(UIImage(named: "Favorite Image"), for: UIControlState())
            let transition = CATransition()
            transition.delegate = self
            transition.duration = 0.2
            transition.type = kCATransitionFade
            sender.imageView?.layer.add(transition, forKey: kCATransition)
        }
    }
    
    
    // Search bar functions.
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            dataManager.filteredRecipes = dataManager.recipes
        }
        else {
            // Search here for filtered content
            dataManager.filteredRecipes = []
            
            ResepiClient.getRecepies(searchTerm: searchText, dietType: dataManager.dietType , foodType: dataManager.foodType, { (resultsDict: [NSDictionary]) in
                
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
