//
//  NewMealViewController.swift
//  MaheinAsh_Final
//
//  Created by Ash Mahein on 4/22/18.
//  Copyright © 2018 Ash Mahein. All rights reserved.
//

import UIKit
import CoreData

class NewMealViewController: UIViewController, UITextFieldDelegate {

    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!

    @IBOutlet weak var mealNameTextField: UITextField!
    @IBOutlet weak var calorieCountTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
        
        mealNameTextField.delegate = self
        calorieCountTextField.delegate = self
        

    }

    @IBAction func saveMeal(_ sender: UIButton) {
        addNewMeal()
    }
    func addNewMeal(){
        let mealPlan = NSEntityDescription.insertNewObject(forEntityName:"Meal", into: self.managedObjectContext)
        
        mealPlan.setValue(mealNameTextField.text!, forKey: "mealName")
        mealPlan.setValue(Double(calorieCountTextField.text!)!, forKey: "mealCals")
        self.appDelegate.saveContext()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
