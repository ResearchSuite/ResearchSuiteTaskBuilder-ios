//
//  RSTBBooleanStepGenerator.swift
//  Pods
//
//  Created by James Kizer on 1/10/17.
//
//

import ResearchKit
import Gloss

open class RSTBBooleanStepGenerator: RSTBQuestionStepGenerator {
    override public init() {}
    
    override open var supportedTypes: [String]! {
        return ["boolean"]
    }
    
    override open func generateAnswerFormat(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> ORKAnswerFormat? {
        
        guard let descriptor = RSTBBooleanStepDescriptor(json: jsonObject) else {
            return nil
        }
        
        let yesString = helper.localizationHelper.localizedString(descriptor.yesString ?? "Yes")
        let noString = helper.localizationHelper.localizedString(descriptor.noString ?? "No")
        
        return ORKAnswerFormat.booleanAnswerFormat(withYesString: yesString, noString: noString)
    }
    
    open override func processQuestionResult(type: String, result: ORKQuestionResult, helper: RSTBTaskBuilderHelper) -> JSON? {
        if let result = result as? ORKBooleanQuestionResult,
            let answer = result.booleanAnswer {
            return [
                "identifier": result.identifier,
                "type": type,
                "answer": answer
            ]
        }
        return  nil
    }
}
