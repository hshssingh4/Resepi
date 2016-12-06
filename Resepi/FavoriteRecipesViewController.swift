//
//  FavoriteRecipesViewController.swift
//  Resepi
//
//  Created by Harpreet Singh on 12/5/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit

class FavoriteRecipesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var favoritesCollectionView: UICollectionView!
    
    var dataManager: DataManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = ColorPalette.BrandColor
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: ColorPalette.WhiteColor]
        
        favoritesCollectionView.dataSource = self
        favoritesCollectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     This method populates the collection view before the view becomes visible to the user.
     */
    override func viewWillAppear(_ animated: Bool) {
        let recipesViewController = (tabBarController?.viewControllers![0] as! UINavigationController).topViewController as! RecipesViewController
        dataManager = recipesViewController.dataManager
        
        if (dataManager?.favoriteRecipes.count == 0) {
            favoritesCollectionView.isHidden = true
        }
        else {
            favoritesCollectionView.isHidden = false
        }
        
        self.favoritesCollectionView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /*****  Collection View Methods  *****/
    
    /**
     Return favorite wallpapers count.
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager!.favoriteRecipes.count
    }
    
    /**
     Populates the cell with the correct wallpapers by reusing cells.
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoritesCollectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        
        cell.recipe = dataManager?.favoriteRecipes[(indexPath as NSIndexPath).row]
        cell.favoriteRecipeButton.isHidden = true
        
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

}
