//
//  RSTBStandardConsentDocumentDescriptor.swift
//  Pods
//
//  Created by James Kizer on 7/26/17.
//
//

import UIKit
import Gloss

open class RSTBStandardConsentDocumentDescriptor: RSTBElementDescriptor {
    
    public let sections: [JSON]
    public let signatures: [JSON]
    public let title: String
    
    // MARK: - Deserialization
    
    required public init?(json: JSON) {
        guard let sections: [JSON] = "sections" <~~ json,
            let signatures: [JSON] = "signatures" <~~ json,
            let title: String = "title" <~~ json
            else {
                return nil
        }
        
        self.sections = sections
        self.signatures = signatures
        self.title = title
        
        super.init(json: json)
    }

}
