//
//  MealsTableViewController.swift
//  MaheinAsh_Final
//
//  Created by Ash Mahein on 4/20/18.
//  Copyright © 2018 Ash Mahein. All rights reserved.
//

import UIKit
import CoreData

class MealsTableViewController: UITableViewController {
    
    struct mealInfo {
        var mealName: String!
        var mealCalories: Double!
    }
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    var myIndex: Int = 0
    var mealArr = [mealInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedObjectContext = appDelegate.persistentContainer.viewContext

        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMeal))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let presetMeal = mealInfo(mealName: "Eggs", mealCalories: 90)
        mealArr.append(presetMeal)
        
        if(mealArr.count >= 1){
            getMeals()
        }
    }
    
    func getMeals() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Meal")
        var meals: [NSManagedObject]!
        do {
            meals = try self.managedObjectContext.fetch(fetchRequest) }
        catch {
                print("getMeals error: \(error)")
        }
        print("Found \(meals.count) players")
        for meal in meals {
            let mealName = meal.value(forKey: "mealName") as! String
            let mealCalories = meal.value(forKey: "mealCals") as! Double
            
            let newMeal = mealInfo(mealName: mealName, mealCalories: mealCalories)
            
            mealArr.append(newMeal)
        }
    }
    
    @objc func addMeal () {
        performSegue(withIdentifier: "toAddMeal", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell") as! MealCell
        
        cell.mealCellName.text = mealArr[indexPath.row].mealName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "showMeal", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showMeal") {
            let showMealVC = segue.destination as! MealViewController
            
            showMealVC.mName = mealArr[myIndex].mealName
            showMealVC.cValue = mealArr[myIndex].mealCalories
        }
    }
 
    @IBAction func unwindFromAddMeal (sender: UIStoryboardSegue) {
        let addMealVC = sender.source as! NewMealViewController
        
        let newMealName = addMealVC.mealNameTextField.text
        let newCalCount = Double(addMealVC.calorieCountTextField.text!)!
        
        let newMeal = mealInfo(mealName: newMealName, mealCalories: newCalCount)
        
        mealArr.append(newMeal)
        
        self.tableView.reloadData()
    }
    
}
