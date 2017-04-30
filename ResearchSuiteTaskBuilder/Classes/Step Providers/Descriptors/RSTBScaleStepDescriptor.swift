//
//  RSTBScaleStepDescriptor.swift
//  Pods
//
//  Created by James Kizer on 4/5/17.
//
//

import UIKit
import Gloss

open class RSTBScaleStepDescriptor: RSTBQuestionStepDescriptor {

    public let maximumValue: Int
    public let minimumValue: Int
    public let defaultValue: Int
    public let stepValue: Int
    public let vertical: Bool
    public let maximumDescription: String?
    public let minimumDescription: String?
    
    required public init?(json: JSON) {
        
        guard let maximumValue: Int = "maximumValue" <~~ json,
            let minimumValue: Int = "minimumValue" <~~ json,
            let defaultValue: Int = "defaultValue" <~~ json,
            let stepValue: Int = "stepValue" <~~ json else {
                return nil
        }
        
        self.maximumValue = maximumValue
        self.minimumValue = minimumValue
        self.defaultValue = defaultValue
        self.stepValue = stepValue
        self.vertical = "vertical" <~~ json ?? false
        self.maximumDescription = "maximumDescription" <~~ json
        self.minimumDescription = "minimumDescription" <~~ json
        super.init(json: json)
        
    }
    
}
