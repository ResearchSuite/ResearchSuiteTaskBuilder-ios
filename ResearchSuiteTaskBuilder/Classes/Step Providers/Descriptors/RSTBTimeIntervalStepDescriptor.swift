//
//  RSTBTimeIntervalStepDescriptor.swift
//  Pods
//
//  Created by James Kizer on 10/4/18.
//

import UIKit
import Gloss

class RSTBTimeIntervalStepDescriptor: RSTBStepDescriptor {
    
    public let defaultInterval: Double
    public let stepMins: Int
    
    public required init?(json: JSON) {
        
        self.defaultInterval = "defaultInterval" <~~ json ?? 0.0
        self.stepMins = "step" <~~ json ?? 1
        
        super.init(json: json)
        
    }

}
