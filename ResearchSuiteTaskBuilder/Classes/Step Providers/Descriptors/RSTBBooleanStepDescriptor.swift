//
//  RSTBBooleanStepDescriptor.swift
//  ResearchSuiteTaskBuilder
//
//  Created by James Kizer on 10/6/18.
//

import UIKit
import Gloss

open class RSTBBooleanStepDescriptor: RSTBStepDescriptor {
    
    public let yesString: String?
    public let noString: String?
    
    public required init?(json: JSON) {
        
        self.yesString = "yesString" <~~ json
        self.noString = "noString" <~~ json
        
        super.init(json: json)
    }

}
