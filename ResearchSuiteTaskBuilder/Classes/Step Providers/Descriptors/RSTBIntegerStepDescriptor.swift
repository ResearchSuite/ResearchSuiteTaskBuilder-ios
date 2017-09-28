//
//  RSTBIntegerStepDescriptor.swift
//  Pods
//
//  Created by James Kizer on 1/9/17.
//
//

import Gloss

open class RSTBIntegerStepDescriptor: RSTBQuestionStepDescriptor {
    
    open class Range: Gloss.Decodable {
        public let min: Int!
        public let max: Int!
        public let unit: String?
        
        public required init?(json: JSON) {
            
            self.min = "min" <~~ json ?? Int.min
            self.max = "max" <~~ json ?? Int.max
            self.unit = "unitLabel" <~~ json
            
        }
    }
    
    public let range: Range!
    public required init?(json: JSON) {
        
        self.range = "range" <~~ json
        
        super.init(json: json)
        
    }

}
