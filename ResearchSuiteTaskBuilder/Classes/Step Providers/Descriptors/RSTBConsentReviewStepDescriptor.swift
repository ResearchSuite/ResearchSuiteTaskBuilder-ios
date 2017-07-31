//
//  RSTBConsentReviewStepDescriptor.swift
//  Pods
//
//  Created by James Kizer on 7/31/17.
//
//

import Gloss

open class RSTBConsentReviewStepDescriptor: RSTBStepDescriptor {
    
    public let consentDocumentFilename: String
    public let reasonForConsent: String?
    
    public required init?(json: JSON) {
        
        guard let consentDocumentFilename: String = "consentDocumentFilename" <~~ json else {
            return nil
        }
        
        self.consentDocumentFilename = consentDocumentFilename
        self.reasonForConsent = "reasonForConsent" <~~ json
        super.init(json: json)
        
    }

}
