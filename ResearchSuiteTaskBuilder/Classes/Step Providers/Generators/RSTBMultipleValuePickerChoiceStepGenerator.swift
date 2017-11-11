//
//  RSTBMultipleValuePickerChoiceStepGenerator.swift
//  ResearchSuiteTaskBuilder
//
//  Created by James Kizer on 11/8/17.
//

import UIKit
import ResearchKit
import Gloss

open class RSTBMultipleValuePickerChoiceStepGenerator: RSTBQuestionStepGenerator {
    public override init(){}
    
    override open var supportedTypes: [String]! {
        return ["multipleValuePickerTextChoice"]
    }
    
//    public typealias ChoiceItemFilter = ( (RSTBChoiceItemDescriptor) -> (Bool))
    public typealias ChoiceItemFilter = ( (RSTBValuePickerChoiceGroup<RSTBChoiceItemDescriptor>) -> ((RSTBChoiceItemDescriptor) -> (Bool)))
    
    open func generateItemFilter(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> ChoiceItemFilter? {
        return { choiceGroup in
            return { choiceItem in
                return true
            }
        }
    }
    
    public typealias ChoiceGroupFilter = ( (RSTBValuePickerChoiceGroup<RSTBChoiceItemDescriptor>) -> (Bool))
    open func generateGroupFilter(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> ChoiceGroupFilter? {
        return { choiceGroup in
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
        guard let choiceStepDescriptor = RSTBMultipleValuePickerChoiceStepDescriptor(json: jsonObject) else {
            return nil
        }
        
        let filteredGroups: [RSTBValuePickerChoiceGroup<RSTBChoiceItemDescriptor>] = {
            
            if let groupFilter = self.generateGroupFilter(type: type, jsonObject: jsonObject, helper: helper) {
                return choiceStepDescriptor.groups.filter(groupFilter)
            }
            else {
                return choiceStepDescriptor.groups
            }
        }()
        
        let shuffledGroups = filteredGroups.shuffled(shouldShuffle: choiceStepDescriptor.shuffleGroups)
        
        let valuePickers: [ORKValuePickerAnswerFormat] = shuffledGroups.flatMap { group in
            
            let filteredItems: [RSTBChoiceItemDescriptor] = {
                
                if let itemFilter = self.generateItemFilter(type: type, jsonObject: jsonObject, helper: helper) {
                    return group.items.filter(itemFilter(group))
                }
                else {
                    return group.items
                }
                
            }()
            
            let choices = self.generateChoices(items: filteredItems, shouldShuffle: group.shuffleItems)
            
            guard choices.count > 0 else {
                return nil
            }
            
            return ORKAnswerFormat.valuePickerAnswerFormat(with: choices)
        }
        
        let answerFormat = ORKAnswerFormat.multipleValuePickerAnswerFormat(withValuePickers: valuePickers)
    
        return answerFormat
    }
}
