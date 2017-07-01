//
//  RSTBDefaultStepGenerator.swift
//  Pods
//
//  Created by James Kizer on 1/9/17.
//
//

import ResearchKit
import Gloss

open class RSTBDefaultStepGenerator: RSTBStepGenerator {
    
    public init(){}
    
    public func supportsType(type: String) -> Bool {
        return true
    }
    
    public func supportedStepTypes() -> [String] {
        return ["*"]
    }
    
    public func generateStep(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> ORKStep? {
        
        guard let element = RSTBStepDescriptor(json: jsonObject) else {
            return nil
        }
        
        let step = ORKInstructionStep(identifier: element.identifier)
        step.text = element.identifier
        step.detailText = "Elements of type \(type) not yet supported."
        return step
    }
    
    public func generateSteps(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> [ORKStep]? {
        
        return [generateStep(type: type, jsonObject: jsonObject, helper: helper)].flatMap({$0})
    }
    
    public func generateSteps(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper, identifierPrefix: String) -> [ORKStep]? {
        guard let element = RSTBStepDescriptor(json: jsonObject) else {
            return nil
        }
        
        let step = ORKInstructionStep(identifier: "\(identifierPrefix).\(element.identifier)")
        step.text = element.identifier
        step.detailText = "Elements of type \(type) not yet supported."
        return [step]
    }
    
    public func processStepResult(type: String,
                                  jsonObject: JsonObject,
                                  result: ORKStepResult,
                                  helper: RSTBTaskBuilderHelper) -> JSON? {
        return nil
    }

}
