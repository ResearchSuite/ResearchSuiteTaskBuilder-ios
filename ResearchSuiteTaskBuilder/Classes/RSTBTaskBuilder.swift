//
//  RSTBTaskBuilder.swift
//  Pods
//
//  Created by James Kizer on 1/9/17.
//
//

import Gloss
import ResearchKit

public typealias JsonElement = AnyObject
public typealias JsonObject = JSON
public typealias JsonArray = [JSON]

public protocol RSTBStateHelper: class {
    func valueInState(forKey: String) -> NSSecureCoding?
    func setValueInState(value: NSSecureCoding?, forKey: String)
}

open class RSTBTaskBuilder {
    
    private var _helper:RSTBTaskBuilderHelper!
    public var helper:RSTBTaskBuilderHelper {
        return self._helper
    }
    private var stepGeneratorService: RSTBStepGeneratorService!
    private var answerFormatGeneratorService: RSTBAnswerFormatGeneratorService!
    private var elementGeneratorService: RSTBElementGeneratorService!
    private var taskGeneratorService: RSTBTaskGeneratorService!
    private var consentDocumentGeneratorService: RSTBConsentDocumentGeneratorService!
    private var consentSectionGeneratorService: RSTBConsentSectionGeneratorService!
    private var consentSignatureGeneratorService: RSTBConsentSignatureGeneratorService!
    
    public init(
        stateHelper:RSTBStateHelper?,
        elementGeneratorServices: [RSTBElementGenerator]?,
        stepGeneratorServices: [RSTBStepGenerator]?,
        answerFormatGeneratorServices: [RSTBAnswerFormatGenerator]?,
        taskGeneratorServices: [RSTBTaskGenerator.Type]? = nil,
        consentDocumentGeneratorServices: [RSTBConsentDocumentGenerator.Type]? = nil,
        consentSectionGeneratorServices: [RSTBConsentSectionGenerator.Type]? = nil,
        consentSignatureGeneratorServices: [RSTBConsentSignatureGenerator.Type]? = nil
        ) {
        self._helper = RSTBTaskBuilderHelper(builder: self, stateHelper: stateHelper)
        
        if let _services = stepGeneratorServices {
            self.stepGeneratorService = RSTBStepGeneratorService(services: _services)
        }
        else {
            self.stepGeneratorService = RSTBStepGeneratorService()
        }
        
        if let _services = answerFormatGeneratorServices {
            self.answerFormatGeneratorService = RSTBAnswerFormatGeneratorService(services: _services)
        }
        else {
            self.answerFormatGeneratorService = RSTBAnswerFormatGeneratorService()
        }
        
        if let _services = elementGeneratorServices {
            self.elementGeneratorService = RSTBElementGeneratorService(services: _services)
        }
        else {
            self.elementGeneratorService = RSTBElementGeneratorService()
        }
        
        if let _services = taskGeneratorServices {
            self.taskGeneratorService = RSTBTaskGeneratorService(taskGenerators: _services)
        }
        else {
            self.taskGeneratorService = RSTBTaskGeneratorService()
        }
        
        if let _services = consentDocumentGeneratorServices {
            self.consentDocumentGeneratorService = RSTBConsentDocumentGeneratorService(generators: _services)
        }
        else {
            self.consentDocumentGeneratorService = RSTBConsentDocumentGeneratorService()
        }
        
        if let _services = consentSectionGeneratorServices {
            self.consentSectionGeneratorService = RSTBConsentSectionGeneratorService(generators: _services)
        }
        else {
            self.consentSectionGeneratorService = RSTBConsentSectionGeneratorService()
        }
        
        if let _services = consentSignatureGeneratorServices {
            self.consentSignatureGeneratorService = RSTBConsentSignatureGeneratorService(generators: _services)
        }
        else {
            self.consentSignatureGeneratorService = RSTBConsentSignatureGeneratorService()
        }
        
    }
    
//    public init() {
//        self._helper = RSTBTaskBuilderHelper(builder: self, stateHelper: nil)
//        self.stepGeneratorService = RSTBStepGeneratorService()
//    }
    
    public func steps(forElement jsonElement: JsonElement) -> [ORKStep]? {
        if let jsonObject = jsonElement as? JsonObject {
            return self.generateSteps(forElement: jsonObject)
        }
        else if let jsonArray = jsonElement as? JsonArray {
            return self.generateSteps(forElements: jsonArray)
        }
        else {
            return nil
        }
    }
    
    public func task(forElement jsonElement: JsonObject) -> ORKTask? {
        
        guard let descriptor = RSTBElementDescriptor(json: jsonElement) else {
            return nil
        }
        
        return self.taskGeneratorService.generateTask(type: descriptor.type, jsonObject: jsonElement, helper: self.helper)
        
    }
    
    public func task(forElementFilename elementFilename: String) -> ORKTask? {
        
        guard let element = self.helper.getJson(forFilename: elementFilename) as? JsonObject else {
            return nil
        }
        
        return self.task(forElement: element)
        
    }
    
    private func generateSteps(forElement element: JsonObject) -> [ORKStep]? {
        
        guard let descriptor = RSTBElementDescriptor(json: element) else {
            return nil
        }
        
        if self.elementGeneratorService.supportsType(type: descriptor.type) {
            guard let elements = self.elementGeneratorService.generateElements(type: descriptor.type, jsonObject: element, helper: helper) else {
                return nil
            }
            
            return self.generateSteps(forElements: elements)
        }
        else {
            guard let steps = self.createSteps(forType: descriptor.type, withJsonObject: element) else {
                return nil
            }
            return steps
        }
        
    }
    
    private func generateSteps(forElements elements: JsonArray) -> [ORKStep]? {
        let stepArrays: [[ORKStep]] = elements.flatMap { (element) -> [ORKStep]? in
            return self.generateSteps(forElement: element)
        }
        
        return Array(stepArrays.joined())
    }
    
    public func createSteps(forType type: String, withJsonObject jsonObject: JsonObject, identifierPrefix: String = "") -> [ORKStep]? {
        return self.stepGeneratorService.generateSteps(type: type, jsonObject: jsonObject, helper: self.helper, identifierPrefix: identifierPrefix)
    }
    
    public func steps(forElementFilename elementFilename: String) -> [ORKStep]? {
        
        guard let element = self.helper.getJson(forFilename: elementFilename) else {
            return nil
        }
        
        return self.steps(forElement: element)
        
    }
    
    
    @available(*, deprecated)
    public func processResult(result: ORKTaskResult, forElement jsonElement: JsonElement) -> [JSON]? {
        if let jsonObject = jsonElement as? JsonObject {
            return self.processResult(result: result, forObject: jsonObject)
        }
        else if let jsonArray = jsonElement as? JsonArray {
            return self.processResult(result: result, forArray: jsonArray)
        }
        else {
            return nil
        }
    }
    
    @available(*, deprecated)
    public func processResult(result: ORKTaskResult, forElementFilename elementFilename: String) -> [JSON]? {
        
        guard let element = self.helper.getJson(forFilename: elementFilename) else {
            return nil
        }
        
        return self.processResult(result: result, forElement: element)
        
    }
    
    private func processResult(result: ORKTaskResult, forObject jsonObject: JsonObject) -> [JSON]? {
        
        guard let descriptor = RSTBElementDescriptor(json: jsonObject) else {
            return nil
        }
        
        switch(descriptor.type) {
        case "elementList":
            guard let elementList = jsonObject["elements"] as? JsonArray else {
                return nil
            }
            return self.processResult(result: result, forArray: elementList)
            
        case "elementFile":
            guard let elementFilename = jsonObject["elementFileName"] as? String,
                let jsonElement = self.helper.getJson(forFilename: elementFilename) else {
                    return nil
            }
            
            return self.processResult(result: result, forElement: jsonElement)
            
        default:
            guard let stepDescriptor = RSTBStepDescriptor(json: jsonObject),
                let stepResult = result.stepResult(forStepIdentifier: stepDescriptor.identifier),
                let resultJSON = self.processStepResult(result: stepResult, forType: descriptor.type, jsonObject: jsonObject)
                else {
                    return nil
            }
            return [resultJSON]
        }
    }
    
    private func processResult(result: ORKTaskResult, forArray jsonArray: JsonArray) -> [JSON]? {
        let jsonArrays: [[JSON]] = jsonArray.flatMap { (element: JsonObject) -> [JSON]? in
            return self.processResult(result: result, forObject: element)
        }
        
        return Array(jsonArrays.joined())
    }
    
    private func processStepResult(result: ORKStepResult, forType type: String, jsonObject: JsonObject) -> JSON? {
        
        return self.stepGeneratorService.processStepResult(type: type, jsonObject: jsonObject, result: result, helper: self.helper)
    }
    
    
    
    
    public func generateAnswerFormat(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> ORKAnswerFormat? {
        return self.answerFormatGeneratorService.generateAnswerFormat(type: type, jsonObject: jsonObject, helper: helper)
    }
    
    @available(*, deprecated)
    public func processQuestionResult(type: String, result: ORKQuestionResult, helper: RSTBTaskBuilderHelper) -> JSON? {
        
        return self.answerFormatGeneratorService.processQuestionResult(type: type, result: result, helper: helper)
        
    }
    
    public func generateConsentDocument(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> ORKConsentDocument? {
        return self.consentDocumentGeneratorService.generate(type: type, jsonObject: jsonObject, helper: helper)
    }
    
    public func generateConsentSection(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> ORKConsentSection? {
        return self.consentSectionGeneratorService.generate(type: type, jsonObject: jsonObject, helper: helper)
    }
    
    public func generateConsentSignature(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> ORKConsentSignature? {
        return self.consentSignatureGeneratorService.generate(type: type, jsonObject: jsonObject, helper: helper)
    }
    
    
    
}
