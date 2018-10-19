//
//  RSTBVideoInstructionStepDescriptor.swift
//  ResearchSuiteTaskBuilder
//
//  Created by James Kizer on 10/18/18.
//

import Gloss

open class RSTBVideoInstructionStepDescriptor: RSTBInstructionStepDescriptor {
    
    public let urlBaseKey: String
    public let urlPath: String
    
    public required init?(json: JSON) {
        
        guard let urlBaseKey: String = "urlBaseKey" <~~ json,
            let urlPath: String = "urlPath" <~~ json else {
            return nil
        }
        
        self.urlBaseKey = urlBaseKey
        self.urlPath = urlPath
        super.init(json: json)
        
    }

}
