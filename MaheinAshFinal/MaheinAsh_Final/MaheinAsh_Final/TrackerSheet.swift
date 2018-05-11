//
//  TrackerSheet.swift
//  MaheinAsh_Final
//
//  Created by Ash Mahein on 3/30/18.
//  Copyright © 2018 Ash Mahein. All rights reserved.
//

import Foundation

class trackerSheet {
    var maintenanceCalories: Double!
    var gainingCalorie: Double!
    var cuttingCalorie: Double!
    
    init(maintenanceCalories: Double, gainingCalorie: Double, cuttingCalorie: Double) {
        self.maintenanceCalories = maintenanceCalories
        self.gainingCalorie = gainingCalorie
        self.cuttingCalorie = cuttingCalorie
    }
}
