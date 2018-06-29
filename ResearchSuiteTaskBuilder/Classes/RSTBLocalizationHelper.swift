//
//  RSTBLocalizationHelper.swift
//  ResearchSuiteTaskBuilder
//
//  Created by James Kizer on 6/28/18.
//

import UIKit

open class RSTBLocalizationHelperLanguageMap: NSObject {
    
    let language: String
    let map: [String: String]
    
    public init(language: String, map: [String: String]) {
        self.language = language
        self.map = map
        super.init()
    }
    
    open subscript(key: String) -> String? {
        get {
            return self.map[key]
        }
    }
    
}

open class RSTBLocalizationHelper: NSObject {
    
    //need to have a few maps, base + one per language
    
    public override init() {
        self.baseMap = nil
        self.languageMap = nil
        super.init()
    }
    
    public var configuredLanguage: String? {
        return self.languageMap?.language
    }
    
    let baseMap: [String: String]?
    let languageMap: RSTBLocalizationHelperLanguageMap?
    public init(baseMap: [String: String], languageMap: RSTBLocalizationHelperLanguageMap) {
        self.baseMap = baseMap
        self.languageMap = languageMap
        super.init()
    }
    
    open func localizedString(_ string: String) -> String {
        
        if let languageString = self.languageMap?[string] {
            return languageString
        }
        
        if let baseString = self.baseMap?[string] {
            return baseString
        }
        
        return NSLocalizedString(string, comment: "")
    }
    
    open func localizedString(_ string: String?) -> String? {
        guard let string = string else {
            return nil
        }
        
        return self.localizedString(string)
    }

}
