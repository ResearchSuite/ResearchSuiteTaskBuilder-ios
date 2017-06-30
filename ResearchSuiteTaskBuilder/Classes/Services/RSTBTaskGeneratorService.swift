//
//  RSTBTaskGeneratorService.swift
//  Pods
//
//  Created by James Kizer on 6/30/17.
//
//

import Foundation
import ResearchKit
import Gloss

public class RSTBTaskGeneratorService: NSObject {
    
    let taskGenerators: [RSTBTaskGenerator.Type]
    
    public init(taskGenerators: [RSTBTaskGenerator.Type]) {
        self.taskGenerators = taskGenerators
    }
    
    public func generateTask(type: String,
                              jsonObject: JSON,
                              helper:RSTBTaskBuilderHelper) -> ORKTask? {
        return self.taskGenerators
            .flatMap { $0.generateTask(type: type, jsonObject: jsonObject, helper: helper) }
            .first
    }
    
}
