//
//  DataViewController.swift
//  Resepi
//
//  Created by Harpreet Singh on 11/8/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit
import PNChart

class DataViewController: UIViewController, AddDataViewControllerDelegate {
    
    @IBOutlet var moneyView: UIView!
    @IBOutlet var timeView: UIView!
    
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
        let addDataViewController = segue.destination.childViewControllers[0] as! AddDataViewController
        addDataViewController.delegate = self
        addDataViewController.moneyArray = moneyChart.yValues as! [Int]
        addDataViewController.timeArray = timeChart.yValues as! [Int]
    }
    
    func graphValues(moneyArray: [Int], timeArray: [Int]) {
        moneyChart.updateData(moneyArray)
        timeChart.updateData(timeArray)
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
}
