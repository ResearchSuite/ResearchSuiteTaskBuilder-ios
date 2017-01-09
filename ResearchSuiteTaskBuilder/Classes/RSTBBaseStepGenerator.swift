//
//  RSTBBaseStepGenerator.swift
//  Pods
//
//  Created by James Kizer on 1/9/17.
//
//

import ResearchKit
import Gloss

public protocol RSTBBaseStepGenerator: RSTBStepGenerator {
    var supportedTypes: [String]! {get}
}

extension RSTBBaseStepGenerator {
    public func supportsType(type: String) -> Bool {
        return self.supportedTypes.contains(type)
    }
    
    public func supportedStepTypes() -> [String] {
        return self.supportedTypes
    }
}

