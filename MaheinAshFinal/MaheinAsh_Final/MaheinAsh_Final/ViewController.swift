//
//  ViewController.swift
//  MaheinAsh_Final
//
//  Created by Ash Mahein on 3/24/18.
//  Copyright © 2018 Ash Mahein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var trackerInfo = [trackerSheet]()
    var index: Int = 0
    var userNums: trackerSheet!

    @IBOutlet var optionsButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func dropDownMenuButton(_ sender: UIButton) {
        optionsButtons.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "getNumbers") {
            let calculatorVC = segue.destination as! MacCalViewController
            if(trackerInfo.count > 0) {
                calculatorVC.mCal = String(trackerInfo[index].maintenanceCalories)
                calculatorVC.gCal = String(trackerInfo[index].gainingCalorie)
                calculatorVC.cCal = String(trackerInfo[index].cuttingCalorie)
            }
        }
    }
    
    @IBAction func unwindFromMacCalView (sender: UIStoryboardSegue) {
        let macCalVC = sender.source as! MacCalViewController
        let newTrackInfo = macCalVC.newNums
        if(macCalVC.numSet == true) {
            trackerInfo.append(newTrackInfo!)
        }
        print("count: \(trackerInfo.count)")
    }
}

