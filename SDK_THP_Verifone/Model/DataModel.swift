//
//  Data.swift
//  SDK_THP_Verifone
//
//  Created by Oraz Atakishiyev on 12/18/20.
//

import UIKit

final class DataModel {
    let keyboardType: UIKeyboardType
    let field: Field
    let placeholder: String
    
    init(text: String, placeholder: String, field: Field, keyboardType: UIKeyboardType = .default) {
        self.text = text
        self.placeholder = placeholder
        self.field = field
        self.keyboardType = keyboardType
    }
    
    var text: String = "" {
        didSet {
            print("Text changed to \(text).")
        }
    }
}
