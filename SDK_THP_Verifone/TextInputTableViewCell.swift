//
//  TextInputTableViewCell.swift
//  SDK_THP_Verifone
//
//  Created by Oraz Atakishiyev on 12/18/20.
//

import UIKit

final class Form {
    let sections: [FormSection]
    init(sections: [FormSection]) {
        self.sections = sections
    }
}

final class FormSection {
    let items: [FormItem]
    init(items: [FormItem]) {
        self.items = items
    }
}

protocol FormItem {}


struct TextInputFormItem: FormItem {
    let text: String
    let field: Field
    let keyboardType: UIKeyboardType
    let placeholder: String
    let didChange: (String) -> ()
}

final class TextInputTableViewCell: UITableViewCell {
    
    var validation = Validation()
    var field: Field!
    
    // MARK: Initializing a Cell
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        contentView.addSubview(editableTextField)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            label.widthAnchor.constraint(equalToConstant: 97.0),
        ])
        NSLayoutConstraint.activate([
            editableTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            editableTextField.leadingAnchor.constraint(equalTo: label.layoutMarginsGuide.trailingAnchor, constant: 5.0),
            editableTextField.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Reusing Cells
    
    override func prepareForReuse() {
        super.prepareForReuse()
        changeHandler = { _ in }
    }
    
    // MARK: Managing the Content
    
    func configure(for model: TextInputFormItem) {
        editableTextField.keyboardType = model.keyboardType
        editableTextField.text = model.text
        editableTextField.placeholder = model.placeholder
        changeHandler = model.didChange
        field = model.field
        label.text = model.placeholder
    }
    
    lazy private var editableTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(TextInputTableViewCell.textDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy private var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "HelveticaNeue", size: 13.0)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Handling Text Input
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        editableTextField.becomeFirstResponder()
    }
    
    private var changeHandler: (String) -> () = { _ in }
    
    @objc private func textDidChange() {
        changeHandler(editableTextField.text ?? "")
        validate()
    }
    
    private func validate() {
        var lengthMax = 128
        var isValidate: Bool = false
        
        switch field {
        case .name:
            lengthMax = 128
        case .address:
            lengthMax = 128
        case .address2:
            lengthMax = 128
        case .city:
            lengthMax = 64
        case .postalCode:
            lengthMax = 16
        case .countryCode:
            lengthMax = 2
        case .state:
            lengthMax = 64
        case .none:
            break
        }
        
        isValidate = field == .postalCode ? self.validation.validatePostalCode(text: editableTextField.text!, max: lengthMax) : self.validation.validateLength(text: editableTextField.text!, max: lengthMax)
        
        if (isValidate == false) {
            self.editableTextField.textColor = UIColor.red
           return
        } else {
            self.editableTextField.textColor = UIColor.black
        }
    }
}
