//
//  RSTBCountdownStepGenerator.swift
//  ResearchSuiteTaskBuilder
//
//  Created by James Kizer on 6/14/18.
//

import UIKit

import ResearchKit
import Gloss

open class RSTBCountdownStepGenerator: RSTBBaseStepGenerator {
    
    public init(){}
    
    open var supportedTypes: [String]! {
        return ["countdown"]
    }
    
    open func generateStep(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> ORKStep? {
        
        guard let stepDescriptor = RSTBStepDescriptor(json:jsonObject) else {
            return nil
        }
        
        let step = ORKCountdownStep(identifier: stepDescriptor.identifier)
        if let duration: TimeInterval = "duration" <~~ jsonObject {
            step.stepDuration = duration
        }
        step.title = helper.localizationHelper.localizedString(stepDescriptor.title)
        step.text = helper.localizationHelper.localizedString(stepDescriptor.text)
        step.isOptional = stepDescriptor.optional
        
        return step
    }
    
    open func processStepResult(type: String,
                                jsonObject: JsonObject,
                                result: ORKStepResult,
                                helper: RSTBTaskBuilderHelper) -> JSON? {
        return nil
    }
    
}
