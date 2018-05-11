//
//  MealViewController.swift
//  MaheinAsh_Final
//
//  Created by Ash Mahein on 4/22/18.
//  Copyright © 2018 Ash Mahein. All rights reserved.
//

import UIKit

class MealViewController: UIViewController {

    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var calorieNameLabel: UILabel!
    
    var mName: String = ""
    var cValue: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        mealNameLabel.text = "Meal: \(mName)"
        calorieNameLabel.text = "Calories: \(cValue)"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
