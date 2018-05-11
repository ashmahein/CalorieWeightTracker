//
//  TrackCaloriesViewController.swift
//  MaheinAsh_Final
//
//  Created by Ash Mahein on 4/21/18.
//  Copyright © 2018 Ash Mahein. All rights reserved.
//

import UIKit
import CoreData

class TrackCaloriesViewController: UIViewController, UITextFieldDelegate {
    
    var calorieInformation: [NSManagedObject]!
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    var calValue: Double!

    @IBOutlet weak var goalGain: UILabel!
    @IBOutlet weak var goalCut: UILabel!
    @IBOutlet weak var calEatenToday: UILabel!
    @IBOutlet weak var updateCalEaten: UITextField!
    
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Calories")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
        
        updateCalEaten.delegate = self
        
        do {
            calorieInformation = try self.managedObjectContext.fetch(fetchRequest)
        }
        catch {
            print("getInformation error: \(error)")
        }
        
        for info in calorieInformation {
            print("Count: \(calorieInformation.count)")
            let gain = info.value(forKey: "gainCalories")
            let cut = info.value(forKey: "loseCalories")
            let eaten = info.value(forKey: "caloriesEaten")

            goalGain.text = "Goal Gain: \(gain!)"
            goalCut.text = "Goal Cut \(cut!)"
            calEatenToday.text = "Calories Eaten Today: \(eaten!)"
        }
        
        if(calorieInformation.count > 5){
            clearDatabase()
        }
    }

    func clearDatabase() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Calories")
        var items: [NSManagedObject]!
        do {
            items = try self.managedObjectContext.fetch(fetchRequest) }
        catch {
                print("removeWeight error: \(error)")
        }
        for item in items {
            self.managedObjectContext.delete(item)
        }
        print("Count: \(items.count)")
        self.appDelegate.saveContext()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func updateCalories(_ sender: UIButton) {
        for info in calorieInformation {
            let eaten = info.value(forKey: "caloriesEaten") as! Double
            calValue = eaten + Double(updateCalEaten.text!)!
            calEatenToday.text = "Calories Eaten Today: \(calValue!)"
            save(eatenCals: calValue)
        }
    }
    
    func save(eatenCals: Double) {
        let userInfo = NSEntityDescription.insertNewObject(forEntityName: "Calories", into: self.managedObjectContext)
        
        userInfo.setValue(eatenCals, forKey: "caloriesEaten")
        
        self.appDelegate.saveContext()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
