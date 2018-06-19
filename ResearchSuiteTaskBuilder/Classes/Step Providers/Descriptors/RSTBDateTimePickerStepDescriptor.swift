//
//  RSTBDateTimePickerStepDescriptor.swift
//  ResearchSuiteTaskBuilder
//
//  Created by James Kizer on 6/19/18.
//

import UIKit
import Gloss

open class RSTBDateTimePickerStepDescriptor: RSTBQuestionStepDescriptor {
    
    public let defaultDate: Date?
    public let minimumDate: Date?
    public let maximumDate: Date?
    
    public required init?(json: JSON) {
        
        self.defaultDate = "defaultDate" <~~ json
        self.minimumDate = "minimumDate" <~~ json
        self.maximumDate = "maximumDate" <~~ json
        
        super.init(json: json)
        
    }

}
