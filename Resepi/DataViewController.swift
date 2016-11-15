//
//  DataViewController.swift
//  Resepi
//
//  Created by Harpreet Singh on 11/8/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit
import PNChart

class DataViewController: UIViewController, AddDataViewControllerDelegate, EditOriginalDataViewControllerDelegate {
    
    @IBOutlet var moneyView: UIView!
    @IBOutlet var timeView: UIView!
    @IBOutlet var moneyLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    var moneyChart: PNBarChart!
    var timeChart: PNBarChart!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = ColorPalette.BrandColor
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: ColorPalette.WhiteColor]
        
        self.initMoneyChart()
        self.initTimeChart()
        
        var moneyValue = defaults.value(forKey: "moneyValue") as? Int
        if (moneyValue == nil) {
            moneyValue = 0
        }
        var timeValue = defaults.value(forKey: "timeValue") as? Int
        if (timeValue == nil) {
            timeValue = 0
        }
        self.updateMoneyTimeLabels(moneyValue: moneyValue!, timeValue: timeValue!)
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
        
        
        if ((sender as? UIBarButtonItem)?.tag == 2) {
            let addDataViewController = segue.destination.childViewControllers[0] as! AddDataViewController
            addDataViewController.delegate = self
            addDataViewController.moneyArray = moneyChart.yValues as! [Int]
            addDataViewController.timeArray = timeChart.yValues as! [Int]
        }
        else if ((sender as? UIBarButtonItem)?.tag == 1) {
            let editOriginalDataViewController = segue.destination.childViewControllers[0] as! EditOriginalDataViewController
            editOriginalDataViewController.delegate = self
            
            var moneyValue = defaults.value(forKey: "moneyValue") as? Int
            if (moneyValue == nil) {
                moneyValue = 0
            }
            var timeValue = defaults.value(forKey: "timeValue") as? Int
            if (timeValue == nil) {
                timeValue = 0
            }
            
            editOriginalDataViewController.moneyValue = moneyValue!
            editOriginalDataViewController.timeValue = timeValue!
        }
    }
    
    func graphValues(moneyArray: [Int], timeArray: [Int]) {
        moneyChart.updateData(moneyArray)
        timeChart.updateData(timeArray)
        
        var moneyValue = defaults.value(forKey: "moneyValue") as? Int
        if (moneyValue == nil) {
            moneyValue = 0
        }
        var timeValue = defaults.value(forKey: "timeValue") as? Int
        if (timeValue == nil) {
            timeValue = 0
        }
        self.updateMoneyTimeLabels(moneyValue: moneyValue!, timeValue: timeValue!)
    }
    
    func editOriginalData(moneyValue: Int, timeValue: Int) {
        self.updateMoneyTimeLabels(moneyValue: moneyValue, timeValue: timeValue)
    }
    
    func initMoneyChart() {
        moneyChart = PNBarChart(frame: CGRect(x: moneyView.frame.origin.x + 10, y: moneyView.frame.origin.y + 50, width: moneyView.frame.width - 20, height: moneyView.frame.height - 100))
        
        moneyChart.xLabels = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        moneyChart.yLabels = ["0", "10", "20", "30", "40", "50", "60"]

        let moneyArray = defaults.value(forKey: "moneyArray") as? [Int]
        if (moneyArray != nil) {
            moneyChart.yValues = moneyArray
        }
        else {
            moneyChart.yValues = [0, 0, 0, 0, 0, 0, 0]
        }
        
        moneyChart.labelFont = UIFont.boldSystemFont(ofSize: 12.0)
        moneyChart.backgroundColor = UIColor.clear
        moneyChart.barBackgroundColor = UIColor.white
        moneyChart.chartBorderColor = UIColor.white
        
        moneyChart.chartMarginTop = 0.0;
        moneyChart.yChartLabelWidth = 10.0
        
        moneyChart.showChartBorder = true
        moneyChart.strokeColors = [ColorPalette.BrandColor, ColorPalette.BrandColor, ColorPalette.BrandColor, ColorPalette.BrandColor, ColorPalette.BrandColor, ColorPalette.BrandColor, ColorPalette.BrandColor]
        moneyChart.isGradientShow = false
        moneyChart.isShowNumbers = false
        
        moneyChart.stroke()
        
        self.view.addSubview(moneyChart)
    }
    
    func initTimeChart() {
        timeChart = PNBarChart(frame: CGRect(x: timeView.frame.origin.x + 10, y: timeView.frame.origin.y + 50, width: timeView.frame.width - 20, height: timeView.frame.height - 100))
        
        timeChart.xLabels = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        timeChart.yLabels = ["0", "1", "2", "3", "4", "5", "6"]
        
        let timeArray = defaults.value(forKey: "timeArray") as? [Int]
        if (timeArray != nil) {
            timeChart.yValues = timeArray
        }
        else {
            timeChart.yValues = [0, 0, 0, 0, 0, 0, 0]
        }
        
        timeChart.labelFont = UIFont.boldSystemFont(ofSize: 12.0)
        timeChart.backgroundColor = UIColor.clear
        timeChart.barBackgroundColor = UIColor.white
        timeChart.chartBorderColor = UIColor.white
        
        timeChart.chartMarginTop = 0.0;
        
        timeChart.showChartBorder = true
        timeChart.strokeColors = [ColorPalette.BrandColor, ColorPalette.BrandColor, ColorPalette.BrandColor, ColorPalette.BrandColor, ColorPalette.BrandColor, ColorPalette.BrandColor, ColorPalette.BrandColor]
        timeChart.isGradientShow = false
        timeChart.isShowNumbers = false
        
        timeChart.stroke()
        
        self.view.addSubview(timeChart)
    }
    
    func updateMoneyTimeLabels(moneyValue: Int, timeValue: Int) {
        let moneyArray = moneyChart.yValues as! [Int]
        let timeArray = timeChart.yValues as! [Int]
        
        var moneySum: Int = 0
        var timeSum: Int = 0

        for value in moneyArray {
            moneySum += value
        }
        
        for value in timeArray {
            timeSum += value
        }
        
        let moneySaved = moneyValue - moneySum
        let timeSaved = timeValue - timeSum
                
        if (moneySaved >= 0) {
            moneyLabel.text = "Saved $\(moneySaved)"
        }
        else {
            moneyLabel.text = "Lost $\(-1*moneySaved)"
        }
        
        if (timeSaved >= 0) {
            timeLabel.text = "Saved \(timeSaved) Hrs."
        }
        else {
            timeLabel.text = "Lost \(-1*timeSaved) Hrs."
        }
    }
}
