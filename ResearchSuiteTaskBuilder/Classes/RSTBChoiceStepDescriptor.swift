//
//  RSTBChoiceStepDescriptor.swift
//  Pods
//
//  Created by James Kizer on 1/9/17.
//
//

import Gloss

open class RSTBChoiceStepDescriptor: RSTBQuestionStepDescriptor {
    
    open class ChoiceItem: Decodable {
        public let text: String!
        public let detailText: String?
        public let value: NSCoding & NSCopying & NSObjectProtocol!
        public let exclusive: Bool
        
        
        public required init?(json: JSON) {
            
            guard let prompt: String = "prompt" <~~ json,
                let value: NSCoding & NSCopying & NSObjectProtocol = "value" <~~ json
                else {
                    return nil
            }
            
            
            self.text = prompt
            self.value = value
            self.detailText = "detailText" <~~ json
            self.exclusive = "exclusive" <~~ json ?? false
            
        }
    }
    
    public let items: [ChoiceItem]
    public let valueSuffix: String?
    public let shuffleItems: Bool
    public let maximumNumberOfItems: Int?
    
    public required init?(json: JSON) {
        
        guard let items: [ChoiceItem] = "items" <~~ json else {
            return nil
        }
        
        self.items = items
        self.valueSuffix = "valueSuffix" <~~ json
        self.shuffleItems = "shuffleItems" <~~ json ?? false
        self.maximumNumberOfItems = "maximumNumberOfItems" <~~ json
        super.init(json: json)
        
    }
    
}
