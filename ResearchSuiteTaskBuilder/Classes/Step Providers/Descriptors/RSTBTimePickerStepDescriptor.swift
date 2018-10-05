//
//  RSTBTimePickerStepDescriptor.swift
//  ResearchSuiteTaskBuilder
//
//  Created by James Kizer on 10/4/18.
//

import UIKit
import Gloss

class RSTBTimePickerStepDescriptor: RSTBStepDescriptor {
    
    public let defaultComponents: DateComponents?
    
    public required init?(json: JSON) {
        
        let defaultComponents: DateComponents? = {
            
            guard let defaultComponentsString: String = "defaultComponents" <~~ json else {
                return nil
            }
            
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "HH:mm"
            
            guard let date = formatter.date(from: defaultComponentsString) else {
                return nil
            }
            
            return Calendar.current.dateComponents([.hour, .minute], from: date)

        }()
        
        self.defaultComponents = defaultComponents
        
        super.init(json: json)
        
    }
    
    
    

}
