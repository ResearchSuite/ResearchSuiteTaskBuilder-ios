//
//  RSTBDateTimePickerStepGenerator.swift
//  ResearchSuiteTaskBuilder
//
//  Created by James Kizer on 6/19/18.
//

import ResearchKit
import Gloss

open class RSTBDateTimePickerStepGenerator: RSTBQuestionStepGenerator {
    
    override public init() {}
    
    override open var supportedTypes: [String]! {
        return ["dateTimePicker"]
    }
    
    override open func generateAnswerFormat(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> ORKAnswerFormat? {
        
        guard let stepDescriptor = RSTBDateTimePickerStepDescriptor(json: jsonObject) else {
            return nil
        }
        
        return ORKAnswerFormat.dateTime(
            withDefaultDate: stepDescriptor.defaultDate,
            minimumDate: stepDescriptor.minimumDate,
            maximumDate: stepDescriptor.maximumDate,
            calendar: nil
        )
        
    }
    
    open override func processQuestionResult(type: String, result: ORKQuestionResult, helper: RSTBTaskBuilderHelper) -> JSON? {
        return  nil
    }

}
