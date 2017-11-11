//
//  RSTBMultipleValuePickerChoiceStepDescriptor.swift
//  ResearchSuiteTaskBuilder
//
//  Created by James Kizer on 11/8/17.
//

import Gloss

open class RSTBValuePickerChoiceGroup<ChoiceItem: RSTBChoiceItemDescriptor>: Gloss.Decodable {
    
    public let items: [ChoiceItem]
    public let shuffleItems: Bool
    
    public required init?(json: JSON) {
        
        guard let items: [ChoiceItem] = "items" <~~ json else {
            return nil
        }
        
        self.items = items
        self.shuffleItems = "shuffleItems" <~~ json ?? false
    }
}

open class RSTBMultipleValuePickerChoiceStepDescriptor<ChoiceItem: RSTBChoiceItemDescriptor>: RSTBQuestionStepDescriptor {
    
    public let groups: [RSTBValuePickerChoiceGroup<ChoiceItem>]
    public let shuffleGroups: Bool
    
    public required init?(json: JSON) {
        
        guard let groups: [RSTBValuePickerChoiceGroup<ChoiceItem>] = "groups" <~~ json else {
            return nil
        }
        
        self.groups = groups
        self.shuffleGroups = "shuffleGroups" <~~ json ?? false
        super.init(json: json)
        
    }

}
