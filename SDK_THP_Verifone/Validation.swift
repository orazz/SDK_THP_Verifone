//
//  Validation.swift
//  SDK_THP_Verifone
//
//  Created by Oraz Atakishiyev on 12/18/20.
//

import Foundation

class Validation {
    public func validateLength(text: String, max: Int = 128) ->Bool {
      let nameRegex = "^[a-zA-Z0-9 ]{0,\(max)}$"
      let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
      let isValidateName = validateName.evaluate(with: text)
      return isValidateName
   }
    
    public func validatePostalCode(text: String, max: Int = 128) ->Bool {
      let nameRegex = "^[0-9]{0,\(max)}$"
      let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
      let isValidateName = validateName.evaluate(with: text)
      return isValidateName
   }
}
