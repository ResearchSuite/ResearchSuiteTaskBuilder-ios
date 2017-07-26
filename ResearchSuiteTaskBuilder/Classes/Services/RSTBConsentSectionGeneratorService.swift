//
//  RSTBConsentSectionGeneratorService.swift
//  Pods
//
//  Created by James Kizer on 7/26/17.
//
//

import UIKit
import ResearchKit
import Gloss

open class RSTBConsentSectionGeneratorService: NSObject {
    
    let generators: [RSTBConsentSectionGenerator.Type]
    
    public override convenience init() {
        let generators: [RSTBConsentSectionGenerator.Type] = []
        self.init(generators: generators)
    }
    
    public init(generators: [RSTBConsentSectionGenerator.Type]) {
        self.generators = generators
        super.init()
    }
    
    public func generate(type: String,
                         jsonObject: JSON,
                         helper:RSTBTaskBuilderHelper) -> ORKConsentSection? {
        return self.generators
            .filter { $0.supportsType(type: type) }
            .flatMap { $0.generate(type: type, jsonObject: jsonObject, helper: helper) }
            .first
    }
    
}
