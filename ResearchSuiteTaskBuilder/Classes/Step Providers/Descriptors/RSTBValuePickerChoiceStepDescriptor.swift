//
//  RSTBValuePickerChoiceStepDescriptor.swift
//  ResearchSuiteTaskBuilder
//
//  Created by James Kizer on 11/8/17.
//

import Gloss

open class RSTBValuePickerChoiceStepDescriptor<ChoiceItem: RSTBChoiceItemDescriptor>: RSTBQuestionStepDescriptor {
    
    public let items: [ChoiceItem]
    public let shuffleItems: Bool
    
    public required init?(json: JSON) {
        
        guard let items: [ChoiceItem] = "items" <~~ json else {
            return nil
        }
        
        self.items = items
        self.shuffleItems = "shuffleItems" <~~ json ?? false
        super.init(json: json)
        
    }

}
