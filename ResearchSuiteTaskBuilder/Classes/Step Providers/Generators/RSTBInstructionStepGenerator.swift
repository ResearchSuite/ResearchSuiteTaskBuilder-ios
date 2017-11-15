//
//  RSTBInstructionStepGenerator.swift
//  Pods
//
//  Created by James Kizer on 1/9/17.
//
//

import ResearchKit
import Gloss

open class RSTBInstructionStepGenerator: RSTBBaseStepGenerator {
    public init(){}
    
    let _supportedTypes = [
        "instruction"
    ]
    
    public var supportedTypes: [String]! {
        return self._supportedTypes
    }
    
    open func generateStep(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> ORKStep? {
        
        guard let element = RSTBInstructionStepDescriptor(json: jsonObject) else {
            return nil
        }
        
        let step = ORKInstructionStep(identifier: element.identifier)
        step.title = element.title
        step.text = element.text
        step.detailText = element.detailText
        if let imageTitle = element.imageTitle { step.image = UIImage(named: imageTitle) }
        if let auxImageTitle = element.auxImageTitle { step.auxiliaryImage = UIImage(named: auxImageTitle) }
        return step
    }
    
    open func processStepResult(type: String,
                                jsonObject: JsonObject,
                                result: ORKStepResult,
                                helper: RSTBTaskBuilderHelper) -> JSON? {
        return nil
    }
}
