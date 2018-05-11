//
//  TrackWeightViewController.swift
//  MaheinAsh_Final
//
//  Created by Ash Mahein on 4/21/18.
//  Copyright © 2018 Ash Mahein. All rights reserved.
//

import UIKit
import CoreData

class TrackWeightViewController: UIViewController, UITextFieldDelegate {
    
    var userInformation: [NSManagedObject]!
    
    @IBOutlet weak var currentWeight: UILabel!
    @IBOutlet weak var updateWeightTextField: UITextField!
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserInfo")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
        
        
        updateWeightTextField.delegate = self
        
        do {
            userInformation = try self.managedObjectContext.fetch(fetchRequest)
        }
        catch {
                print("getInformation error: \(error)")
        }
        
        for info in userInformation {
            userInformation.removeAll()
            let weight = info.value(forKey: "weight")
            currentWeight.text = "Current Weight: \(weight!)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveNewWeight(_ sender: UIButton) {
        let userInfo = NSEntityDescription.insertNewObject(forEntityName: "UserInfo", into: self.managedObjectContext)
        
        if(updateWeightTextField.text! != "") {
            userInfo.setValue(Double(updateWeightTextField.text!), forKey: "weight")
        }
        currentWeight.text = "Current Weight: \(updateWeightTextField.text!)"

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
