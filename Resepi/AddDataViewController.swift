//
//  AddDataViewController.swift
//  Resepi
//
//  Created by Harpreet Singh on 11/12/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit
import Parse

@objc protocol AddDataViewControllerDelegate  {
    func graphValues(moneyArray: [Int], timeArray: [Int])
}

class AddDataViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let daysArray = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var moneyArray: [Int] = [0, 0, 0, 0, 0, 0, 0]
    var timeArray: [Int] = [0, 0, 0, 0, 0, 0, 0]
    
    @IBOutlet var dayPickerView: UIPickerView!
    @IBOutlet var moneyField: UITextField!
    @IBOutlet var timeField: UITextField!
    
    let defaults = UserDefaults.standard

    weak var delegate: AddDataViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = ColorPalette.BrandColor
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: ColorPalette.WhiteColor]
        
        dayPickerView.delegate = self
        dayPickerView.dataSource = self
        let row = dayPickerView.selectedRow(inComponent: 0)
        updateTextFields(row: row)
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
        delegate?.graphValues(moneyArray: moneyArray, timeArray: timeArray)
        dismiss(animated: true, completion: nil)
        defaults.set(moneyArray, forKey: "\(PFUser.current()?.username)moneyArray")
        defaults.set(timeArray, forKey: "\(PFUser.current()?.username)timeArray")
        defaults.synchronize()
    }
    
    @IBAction func onSaveButton(_ sender: Any) {
        let row = dayPickerView.selectedRow(inComponent: 0)
        var money: Int
        var time: Int
        if (moneyField.text?.isEmpty)! {
            money = 0
        }
        else {
            money = Int(moneyField.text!)!
        }
        if (timeField.text?.isEmpty)! {
            time = 0
        }
        else {
            time = Int(timeField.text!)!
        }
        
        moneyArray[row] = money
        timeArray[row] = time
        
        self.moneyField.resignFirstResponder()
        self.timeField.resignFirstResponder()
        
        let alert = UIAlertController(title: "Save Data", message: "Saved Succesfully!", preferredStyle:UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onScreenTapGesture(_ sender: UITapGestureRecognizer) {
        moneyField.resignFirstResponder()
        timeField.resignFirstResponder()
    }
    
    
    // Picker View Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return daysArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return daysArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateTextFields(row: row)
    }
    
    func updateTextFields(row: Int) {
        if (moneyArray[row] != 0) {
            let money = String(moneyArray[row])
            moneyField.text = money
        }
        else {
            moneyField.text = nil
        }
        if (timeArray[row] != 0) {
            let time = String(timeArray[row])
            timeField.text = time
        }
        else {
            timeField.text = nil
        }
    }
    
    /**func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let string = daysArray[row]
        return NSAttributedString(string: string, attributes: [NSForegroundColorAttributeName: ColorPalette.WhiteColor])
    }*/

}
