//
//  RSTBConsentSignatureDescriptor.swift
//  Pods
//
//  Created by James Kizer on 7/26/17.
//
//

import UIKit
import Gloss

open class RSTBConsentSignatureDescriptor: RSTBElementDescriptor {
    
    public let title: String?
    public let dateFormatString: String?
    public let givenName: String?
    public let familyName: String?
    public let signatureImageTitle: String?
    public let signatureDateString: String?
    
    // MARK: - Deserialization
    
    required public init?(json: JSON) {
        
        self.title = "title" <~~ json
        self.dateFormatString = "dateFormatString" <~~ json
        self.givenName = "givenName" <~~ json
        self.familyName = "familyName" <~~ json
        self.signatureImageTitle = "signatureImageTitle" <~~ json
        self.signatureDateString = "signatureDateString" <~~ json
        
        super.init(json: json)
    }

}
