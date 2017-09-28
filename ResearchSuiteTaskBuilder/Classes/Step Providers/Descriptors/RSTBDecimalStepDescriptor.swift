//
//  RSTBDecimalStepDescriptor.swift
//  Pods
//
//  Created by James Kizer on 4/10/17.
//
//

import UIKit
import Gloss

open class RSTBDecimalStepDescriptor: RSTBQuestionStepDescriptor {

    open class Range: Gloss.Decodable {
        public let min: Double!
        public let max: Double!
        public let unit: String?
        
        public required init?(json: JSON) {
            
            self.min = "min" <~~ json ?? -Double.infinity
            self.max = "max" <~~ json ?? Double.infinity
            self.unit = "unitLabel" <~~ json
            
        }
    }
    
    public let range: Range?
    public required init?(json: JSON) {
        
        self.range = "range" <~~ json
        
        super.init(json: json)
        
    }
    
}
