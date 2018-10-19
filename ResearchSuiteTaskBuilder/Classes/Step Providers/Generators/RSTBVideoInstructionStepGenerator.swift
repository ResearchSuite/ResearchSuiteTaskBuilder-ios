//
//  RSTBVideoInstructionStepGenerator.swift
//  ResearchSuiteTaskBuilder
//
//  Created by James Kizer on 10/18/18.
//

import UIKit
import ResearchKit
import Gloss

open class RSTBVideoInstructionStepGenerator: RSTBBaseStepGenerator {

    public init(){}
    
    let _supportedTypes = [
        "videoInstructionStep"
    ]
    
    public var supportedTypes: [String]! {
        return self._supportedTypes
    }
    
    open func generateStep(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> ORKStep? {
        
        guard let element = RSTBVideoInstructionStepDescriptor(json: jsonObject),
            let urlBase = helper.stateHelper?.valueInState(forKey: element.urlBaseKey) as? String,
            let videoURL = URL(string: urlBase + element.urlPath) else {
            return nil
        }
        
        let step = ORKVideoInstructionStep(identifier: element.identifier)
        step.title = helper.localizationHelper.localizedString(element.title)
        step.text =  helper.localizationHelper.localizedString(element.text)
        step.videoURL = videoURL
        
        return step
    }
    
    open func processStepResult(type: String,
                                jsonObject: JsonObject,
                                result: ORKStepResult,
                                helper: RSTBTaskBuilderHelper) -> JSON? {
        return nil
    }
    
}
