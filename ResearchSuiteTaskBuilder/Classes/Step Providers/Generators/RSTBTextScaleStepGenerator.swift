//
//  RSTBTextScaleStepGenerator.swift
//  Pods
//
//  Created by James Kizer on 7/24/17.
//
//

import ResearchKit
import Gloss


open class RSTBTextScaleStepGenerator: RSTBQuestionStepGenerator {
    
    override open var supportedTypes: [String]! {
        return ["textScale"]
    }

    open func generateChoices(items: [RSTBChoiceItemDescriptor], helper: RSTBTaskBuilderHelper) -> [ORKTextChoice] {
        
        return items.map { item in
        
            return ORKTextChoice(
                text: helper.localizationHelper.localizedString(item.text),
                detailText: helper.localizationHelper.localizedString(item.detailText),
                value: item.value,
                exclusive: item.exclusive
            )
        }
    }
    
    override open func generateAnswerFormat(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> ORKAnswerFormat? {
        guard let stepDescriptor = RSTBTextScaleStepDescriptor(json: jsonObject) else {
            return nil
        }
        
        let choices = self.generateChoices(items: stepDescriptor.items, helper: helper)
        
        guard choices.count > 0 else {
            return nil
        }
        
        let answerFormat = ORKAnswerFormat.textScale(
            with: choices,
            defaultIndex: stepDescriptor.defaultIndex,
            vertical: stepDescriptor.vertical
        )
        
        return answerFormat
    }
    
   open override func processStepResult(type: String, jsonObject: JsonObject, result: ORKStepResult, helper: RSTBTaskBuilderHelper) -> JSON? {
        return nil
    }

}
