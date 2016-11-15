//
//  EditOriginalDataViewController.swift
//  Resepi
//
//  Created by Harpreet Singh on 11/15/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit

@objc protocol EditOriginalDataViewControllerDelegate  {
    func editOriginalData(moneyValue: Int, timeValue: Int)
}

class EditOriginalDataViewController: UIViewController {
    
    @IBOutlet var moneyField: UITextField!
    @IBOutlet var timeField: UITextField!
    
    var moneyValue: Int = 0
    var timeValue: Int = 0
    
    let defaults = UserDefaults.standard
    
    weak var delegate: EditOriginalDataViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = ColorPalette.BrandColor
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: ColorPalette.WhiteColor]
        
        updateTextFields()
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
    
    @IBAction func onDoneButton(_ sender: Any) {
        delegate?.editOriginalData(moneyValue: moneyValue, timeValue: timeValue)
        dismiss(animated: true, completion: nil)
        defaults.set(moneyValue, forKey: "moneyValue")
        defaults.set(timeValue, forKey: "timeValue")
        defaults.synchronize()
    }
    
    @IBAction func onSaveEditButton(_ sender: Any) {
        moneyValue = Int(moneyField.text!)!
        timeValue = Int(timeField.text!)!
        
        self.moneyField.resignFirstResponder()
        self.timeField.resignFirstResponder()
        
        let alert = UIAlertController(title: "Save Data", message: "Saved Succesfully!", preferredStyle:UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateTextFields() {
        if (moneyValue != 0) {
            moneyField.text = String(moneyValue)
        }
        else {
            moneyField.text = nil
        }
        
        if (timeValue != 0) {
            timeField.text = String(timeValue)
        }
    }
    
    
    
    
    
}
