//
//  RSTBElementDescriptor.swift
//  Pods
//
//  Created by James Kizer on 1/9/17.
//
//

import Gloss

open class RSTBElementDescriptor: Gloss.JSONDecodable {
    
    public let type: String
    public let identifier: String
    
    // MARK: - Deserialization
    
    required public init?(json: JSON) {
        guard let type: String = "type" <~~ json,
            let id: String = "identifier" <~~ json
            else {
                return nil
        }
        
        self.type = type
        self.identifier = id
    }
    
}
