//
//  FiltersViewController.swift
//  Resepi
//
//  Created by Harpreet Singh on 12/5/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit


@objc protocol AddFiltersViewControllerDelegate  {
    func addFiltersData(dietType: String, foodType: String)
}

class FiltersViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var dietPickerView: UIPickerView!
    @IBOutlet var foodPickerView: UIPickerView!
    
    let dietTypesArray = ["None", "balanced", "high-protein", "low-fat", "low-carb"]
    let foodTypesArray = ["None", "vegan", "vegetarian", "peanut-free"]
    
    weak var delegate: AddFiltersViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = ColorPalette.BrandColor
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: ColorPalette.WhiteColor]
        
        dietPickerView.delegate = self
        dietPickerView.dataSource = self
        foodPickerView.delegate = self
        foodPickerView.dataSource = self
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

    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onSubmitButton(_ sender: Any) {
        let diet = dietTypesArray[dietPickerView.selectedRow(inComponent: 0)]
        let food = foodTypesArray[foodPickerView.selectedRow(inComponent: 0)]
        
        delegate?.addFiltersData(dietType: diet, foodType: food)
        
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1) {
            return dietTypesArray.count
        }
        
        if (pickerView.tag == 2) {
            return foodTypesArray.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1) {
            return dietTypesArray[row]
        }
    
        if (pickerView.tag == 2) {
            return foodTypesArray[row]
        }
        
        return "nil"
    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if (pickerView.tag == 1) {
//             print(dietTypesArray[row])
//        }
//        
//        if (pickerView.tag == 2) {
//            print(foodTypesArray[row])
//        }
//    }
}
