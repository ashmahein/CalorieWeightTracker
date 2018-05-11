//
//  AdjustCaloriesViewController.swift
//  MaheinAsh_Final
//
//  Created by Ash Mahein on 3/28/18.
//  Copyright © 2018 Ash Mahein. All rights reserved.
//

import UIKit

class AdjustCaloriesViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var gainCaloriesTextField: UITextField!
    @IBOutlet weak var cuttingCaloriesTextField: UITextField!
    
    @IBOutlet weak var adjustGainLabel: UILabel!
    @IBOutlet weak var adjustCutLabel: UILabel!
    
    var gain: Double!
    var cut: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gainCaloriesTextField.delegate = self
        cuttingCaloriesTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkGainNumbers(_ sender: UIButton) {
        print("Gain: \(gainCaloriesTextField.text!)")
        if(Double (gainCaloriesTextField.text!)! < gain!) {
            adjustGainLabel.text = "Calorie for gain too low"
        }
        else {
            adjustGainLabel.text = "Adjusted Gain OK"
        }
    }
    
    @IBAction func checkCutNumbers(_ sender: UIButton) {
        if(Double (cuttingCaloriesTextField.text!)! > gain!) {
            adjustCutLabel.text = "Calorie for cut too high"
        }
        else {
            adjustCutLabel.text = "Adjusted Cut OK"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
