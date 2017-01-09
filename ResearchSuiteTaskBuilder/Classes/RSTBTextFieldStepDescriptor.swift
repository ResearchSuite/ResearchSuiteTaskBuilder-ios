//
//  RSTBTextFieldStepDescriptor.swift
//  Pods
//
//  Created by James Kizer on 1/9/17.
//
//

import Gloss

open class RSTBTextFieldStepDescriptor: RSTBQuestionStepDescriptor {
    public let maximumLength: Int?
    public let multipleLines: Bool
    public let validationRegex: String?
    public let invalidMessage: String?
    
    required public init?(json: JSON) {
        
        self.maximumLength = "maximumLength" <~~ json
        self.multipleLines = "multipleLines" <~~ json ?? false
        self.validationRegex = "validationRegex" <~~ json
        self.invalidMessage = "invalidMessage" <~~ json
        super.init(json: json)
        
    }
}
