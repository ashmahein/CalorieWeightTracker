//
//  MacCalViewController.swift
//  MaheinAsh_Final
//
//  Created by Ash Mahein on 3/26/18.
//  Copyright © 2018 Ash Mahein. All rights reserved.
//

import UIKit
import CoreData

class MacCalViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var trackerInfo = [trackerSheet]()
    var newNums: trackerSheet!
    
    var BMR: Double = 0.0
    var calorieCount: Double = 0.0
    var maintenanceCalorieCount: Double = 0.0
    var gainCalorieCount: Double = 0.0
    var cutCalorieCount: Double = 0.0
    var mCal: String = ""
    var gCal: String = ""
    var cCal: String = ""
    var numSet: Bool = false

    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var bodyFatTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var activityLevelTextField: UITextField!
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var gainCalorieLabel: UILabel!
    @IBOutlet weak var cuttingCalorieLabel: UILabel!
    
    let activityLevel = ["Sedentary", "Lightly Active", "Moderately Active", "Very Active", "Active"]
    
    let activityLevelPicker = UIPickerView()
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneCalculatingData))
        self.navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.title = "Calculator"
        
        weightTextField.delegate = self
        heightTextField.delegate = self
        bodyFatTextField.delegate = self
        ageTextField.delegate = self
        
        activityLevelPicker.delegate = self
        activityLevelPicker.dataSource = self
        
        activityLevelTextField.inputView = activityLevelPicker
        activityLevelTextField.textAlignment = .center
        activityLevelTextField.placeholder = "Enter Activity Level"
        
        calorieLabel.text = "Maintenance Calories: \(mCal)"
        gainCalorieLabel.text = "Gain Calories: \(gCal)"
        cuttingCalorieLabel.text = "Cutting Calories: \(cCal)"
    }
    
    func addUserInfo(){
        let calorieInfo = NSEntityDescription.insertNewObject(forEntityName: "Calories", into: self.managedObjectContext)
        let userInfo = NSEntityDescription.insertNewObject(forEntityName: "UserInfo", into: self.managedObjectContext)
        
        if(weightTextField.text! != "") {
            userInfo.setValue(Double(weightTextField.text!), forKey: "weight")
        }
        calorieInfo.setValue(maintenanceCalorieCount, forKey: "maintainence")
        calorieInfo.setValue(gainCalorieCount, forKey: "gainCalories")
        calorieInfo.setValue(cutCalorieCount, forKey: "loseCalories")
        calorieInfo.setValue(0, forKey: "caloriesEaten")
        
        self.appDelegate.saveContext()
    }
    
    @objc func doneCalculatingData () {
        // Update local variables
        performSegue(withIdentifier:"unwindToMenu", sender:self)
    }

    func calculateBMR() -> Double {
        var cBMR = 0.0
        if (genderSegment.selectedSegmentIndex == 0) {
            //MALE BMR
            cBMR = (66 + (6.23 * (Double(weightTextField.text!)!) + (12.7 * Double (heightTextField.text!)!) - (6.8 * Double(ageTextField.text!)!)))
        }
        else {
            //FEMALE BMR
            cBMR = (655 + (4.35 * (Double(weightTextField.text!)!) + (4.7 * Double (heightTextField.text!)!) - (4.7 * Double(ageTextField.text!)!)))
        }
        return cBMR
    }
    
    func calculateTotalCal(bmr: Double) -> Double {
        var totalCal: Double = 0.0
        if(activityLevelTextField.text == "Sedentary") {
            print("Sedentary")
            totalCal = bmr * 1.2
        }
        else if (activityLevelTextField.text == "Lightly Active") {
            print("Lightly Active")
            totalCal = bmr * 1.37
        }
        else if (activityLevelTextField.text == "Moderately Active") {
            print("Moderately Active")
            totalCal = bmr * 1.55
        }
        else if(activityLevelTextField.text == "Active") {
            print("Active")
            totalCal = bmr * 1.725
        }
        else {
            print("Very Active")
            totalCal = bmr * 1.9
        }
        return totalCal
    }

    
    @IBAction func calculateTapped(_ sender: UIButton) {
        BMR = calculateBMR()
        calorieCount = calculateTotalCal(bmr: BMR)
        
        maintenanceCalorieCount = calorieCount
        gainCalorieCount = calorieCount + 250
        cutCalorieCount = calorieCount - 250
        
        newNums = trackerSheet(maintenanceCalories: maintenanceCalorieCount, gainingCalorie: gainCalorieCount, cuttingCalorie: cutCalorieCount)
   
        calorieLabel.text = "Maintenance Calories: \(maintenanceCalorieCount)"
        gainCalorieLabel.text = "Gain Calories: \(gainCalorieCount)"
        cuttingCalorieLabel.text = "Cutting Calories \(cutCalorieCount)"
        
        numSet = true
        
        addUserInfo()
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activityLevel.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activityLevel[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activityLevelTextField.text = activityLevel[row]
        activityLevelTextField.resignFirstResponder()
    }
    
    @IBAction func unwindFromAdjustCalories (sender: UIStoryboardSegue) {
        let adjustCalVC = sender.source as! AdjustCaloriesViewController
        if (adjustCalVC.gainCaloriesTextField.text == "") {
            gainCalorieLabel.text = "Gain Calories: \(gainCalorieCount)"
        }
        else {
            gainCalorieLabel.text = "Gain Calories: \(adjustCalVC.gainCaloriesTextField.text!)"
            gainCalorieCount = Double (adjustCalVC.gainCaloriesTextField.text!)!
        }
        if(adjustCalVC.cuttingCaloriesTextField.text == "") {
            cuttingCalorieLabel.text = "Cutting Calories: \(cutCalorieCount)"
        }
        else {
            cuttingCalorieLabel.text = "Cutting Calories: \(adjustCalVC.cuttingCaloriesTextField.text!)"
            cutCalorieCount = Double (adjustCalVC.cuttingCaloriesTextField.text!)!
        }
        addUserInfo()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "adjustNumbers") {
            let adjustCalVC = segue.destination as! AdjustCaloriesViewController
            adjustCalVC.gain = gainCalorieCount
            adjustCalVC.cut = cutCalorieCount
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

}
