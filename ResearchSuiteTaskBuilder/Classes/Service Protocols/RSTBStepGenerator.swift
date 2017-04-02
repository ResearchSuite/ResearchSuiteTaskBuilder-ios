//
//  RSTBStepGenerator.swift
//  Pods
//
//  Created by James Kizer on 1/9/17.
//
//

import Foundation
import ResearchKit
import Gloss

//this is used to support step generation
public protocol RSTBStepGenerator {
    
    @available(*, deprecated)
    func generateStep(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> ORKStep?
    func generateSteps(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> [ORKStep]?
    func supportsType(type: String) -> Bool
    func supportedStepTypes() -> [String]
    
    func processStepResult(type: String,
                           jsonObject: JsonObject,
                           result: ORKStepResult,
                           helper: RSTBTaskBuilderHelper) -> JSON?
    
}
