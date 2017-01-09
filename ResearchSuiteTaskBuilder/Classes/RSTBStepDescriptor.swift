//
//  RSTBStepDescriptor.swift
//  Pods
//
//  Created by James Kizer on 1/9/17.
//
//

import Gloss

open class RSTBStepDescriptor: RSTBElementDescriptor {
    
    public let optional: Bool
    public let title: String?
    public let text: String?
    
    // MARK: - Deserialization
    
    required public init?(json: JSON) {
        
        self.optional = "optional" <~~ json ?? true
        self.title = "title" <~~ json
        self.text = "text" <~~ json
        
        super.init(json: json)
        
    }
    
}
