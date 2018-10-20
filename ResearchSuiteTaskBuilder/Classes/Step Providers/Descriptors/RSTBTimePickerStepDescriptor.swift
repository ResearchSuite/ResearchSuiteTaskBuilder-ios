//
//  RSTBTimePickerStepDescriptor.swift
//  ResearchSuiteTaskBuilder
//
//  Created by James Kizer on 10/4/18.
//

import UIKit
import Gloss
import ResearchKit

open class RSTBTimePickerStepDescriptor: RSTBStepDescriptor {

    public let defaultComponents: DateComponents?
    
    public required init?(json: JSON) {

        self.defaultComponents = {
            guard let defaultComponentsString: String = "defaultComponents" <~~ json else {
                return nil
            }
            
            return ORKTimeOfDayComponentsFromString(defaultComponentsString)
        }()
        
        super.init(json: json)
        
    }
    
    
    

}
