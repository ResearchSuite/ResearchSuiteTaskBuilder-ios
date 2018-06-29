//
//  RSTBInvestigatorConsentSignatureGenerator.swift
//  Pods
//
//  Created by James Kizer on 7/26/17.
//
//

import UIKit
import Gloss
import ResearchKit

open class RSTBInvestigatorConsentSignatureGenerator: RSTBConsentSignatureGenerator {
    open class func supportsType(type: String) -> Bool {
        return "investigatorConsentSignature" == type
    }
    
    open class func generate(type: String, jsonObject: JSON, helper: RSTBTaskBuilderHelper) -> ORKConsentSignature? {
        
        guard let descriptor = RSTBConsentSignatureDescriptor(json: jsonObject) else {
            return nil
        }
        
        let image: UIImage? = (descriptor.signatureImageTitle != nil) ? UIImage(named: descriptor.signatureImageTitle!) : nil
        
        return ORKConsentSignature(
            forPersonWithTitle: descriptor.title,
            dateFormatString: descriptor.dateFormatString,
            identifier: descriptor.identifier,
            givenName: descriptor.givenName,
            familyName: descriptor.familyName,
            signatureImage: image,
            dateString: descriptor.signatureDateString
        )
    }
}
