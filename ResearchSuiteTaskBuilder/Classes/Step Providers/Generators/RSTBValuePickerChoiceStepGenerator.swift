//
//  RSTBValuePickerChoiceStepGenerator.swift
//  ResearchSuiteTaskBuilder
//
//  Created by James Kizer on 11/8/17.
//

import UIKit
import ResearchKit
import Gloss

open class RSTBValuePickerChoiceStepGenerator: RSTBQuestionStepGenerator {
    
    public override init(){}
    
    override open var supportedTypes: [String]! {
        return ["valuePickerTextChoice"]
    }
    
    public typealias ChoiceItemFilter = ( (RSTBChoiceItemDescriptor) -> (Bool))
    
    open func generateFilter(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> ChoiceItemFilter? {
        
        return { choiceItem in
            return true
        }
    }
    
    open class func generateChoices(items: [RSTBChoiceItemDescriptor], shouldShuffle: Bool?) -> [ORKTextChoice] {
        let shuffledItems = items.shuffled(shouldShuffle: shouldShuffle ?? false)
        
        return shuffledItems.map { item in
            return ORKTextChoice(
                text: item.text,
                detailText: item.detailText,
                value: item.value,
                exclusive: item.exclusive)
        }
    }
    
    open func generateChoices(items: [RSTBChoiceItemDescriptor], shouldShuffle: Bool?) -> [ORKTextChoice] {
        return RSTBValuePickerChoiceStepGenerator.generateChoices(items: items, shouldShuffle: shouldShuffle)
    }
    
    override open func generateAnswerFormat(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> ORKAnswerFormat? {
        guard let choiceStepDescriptor = RSTBValuePickerChoiceStepDescriptor(json: jsonObject) else {
            return nil
        }
        
        let filteredItems: [RSTBChoiceItemDescriptor] = {
            
            if let itemFilter = self.generateFilter(type: type, jsonObject: jsonObject, helper: helper) {
                return choiceStepDescriptor.items.filter(itemFilter)
            }
            else {
                return choiceStepDescriptor.items
            }
            
        }()
        
        let choices = self.generateChoices(items: filteredItems, shouldShuffle: choiceStepDescriptor.shuffleItems)
        
        guard choices.count > 0 else {
            return nil
        }
        
        let answerFormat = ORKAnswerFormat.valuePickerAnswerFormat(with: choices)
        
        return answerFormat
    }
    
    

}
