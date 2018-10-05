//
//  RSTBTimeIntervalStepGenerator.swift
//  ResearchSuiteTaskBuilder
//
//  Created by James Kizer on 6/20/18.
//

import UIKit
import ResearchKit
import Gloss

open class RSTBTimeIntervalStepGenerator: RSTBQuestionStepGenerator {
    
    override public init() {}
    
    override open var supportedTypes: [String]! {
        return ["timeInterval"]
    }
    
    override open func generateAnswerFormat(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> ORKAnswerFormat? {
        
        guard let stepDescriptor = RSTBTimeIntervalStepDescriptor(json: jsonObject) else {
            return nil
        }
        
        return ORKAnswerFormat.timeIntervalAnswerFormat(
            withDefaultInterval: stepDescriptor.defaultInterval,
            step: stepDescriptor.stepMins
        )
    }
    
    open override func processQuestionResult(type: String, result: ORKQuestionResult, helper: RSTBTaskBuilderHelper) -> JSON? {
        return  nil
    }
    
}
