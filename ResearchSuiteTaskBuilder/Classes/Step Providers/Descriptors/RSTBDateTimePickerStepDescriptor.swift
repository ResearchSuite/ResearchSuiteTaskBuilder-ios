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
    
    public static func date(from: String) -> Date? {
        if #available(iOS 10.0, *) {
            return ISO8601DateFormatter().date(from: from)
        } else {
            // Fallback on earlier versions
            let dateFormatter = DateFormatter()
            let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
            dateFormatter.locale = enUSPosixLocale
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            return dateFormatter.date(from:from)
        }
    }
    
    public required init?(json: JSON) {
        
        let dateSelector: (String) -> Date? = { key in
            if let dateString: String = key <~~ json {
                return RSTBDateTimePickerStepDescriptor.date(from: dateString)
            }
            else {
                return nil
            }
        }
        
        self.defaultDate = dateSelector("defaultDate")
        self.minimumDate = dateSelector("minimumDate")
        self.maximumDate = dateSelector("maximumDate")
        
        super.init(json: json)
        
    }

}
