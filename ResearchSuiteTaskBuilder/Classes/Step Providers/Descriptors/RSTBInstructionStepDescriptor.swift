//
//  RSTBInstructionStepDescriptor.swift
//  Pods
//
//  Created by James Kizer on 1/9/17.
//
//

import Gloss

open class RSTBInstructionStepDescriptor: RSTBStepDescriptor {
    public let detailText: String?
    public let imageTitle: String?
    public let auxImageTitle: String?
    
    required public init?(json: JSON) {
        
        self.detailText = "detailText" <~~ json
        self.imageTitle = "image" <~~ json
        self.auxImageTitle = "auxImage" <~~ json
        super.init(json: json)
        
    }
}
