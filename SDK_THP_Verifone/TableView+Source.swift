//
//  TableView+Source.swift
//  SDK_THP_Verifone
//
//  Created by Oraz Atakishiyev on 12/18/20.
//

import UIKit

extension TableView
{
    
    @available(iOS, introduced: 11.0, message: "load data")
    public func load()
    {
        
    }
    
    @available(iOS, introduced: 11.0, message: "setup view")
    func setup()
    {
        self.bindViewModel()
        self.configRows()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: ReuseIdentifiers.textInput.rawValue)
        self.view.addSubview(self.tableView)
        
        sendButton = UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(send))
        sendButton.isEnabled = false
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let barButton = UIBarButtonItem(customView: activityIndicator)
        
        navigationItem.rightBarButtonItems = [sendButton, barButton]
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.tableView.addGestureRecognizer(tap)
    }
    
    private func configRows() {
        tableView.register(TextInputTableViewCell.self, forCellReuseIdentifier: ReuseIdentifiers.textInput.rawValue)
        
        items = [
            0: DataModel(text: "", placeholder: "Name", field: .name, keyboardType: .default),
            1: DataModel(text: "", placeholder: "Address 1", field: .address, keyboardType: .default),
            2: DataModel(text: "", placeholder: "Address 2", field: .address2, keyboardType: .default),
            3: DataModel(text: "", placeholder: "City", field: .city, keyboardType: .default),
            4: DataModel(text: "", placeholder: "State (optional)", field: .state, keyboardType: .default),
            5: DataModel(text: "", placeholder: "Postal code", field: .postalCode, keyboardType: .numberPad),
            6: DataModel(text: "", placeholder: "Country code", field: .countryCode, keyboardType: .default),]
        
        var formItems = [FormItem]()
        
        for i in 0..<items.count {
            let val: DataModel = items[i]!
            formItems.append(TextInputFormItem(text: val.text, field: val.field, keyboardType: val.keyboardType, placeholder: val.placeholder, didChange: { [weak self] (str) in
                self?.items[i]!.text = str
                let _ = self?.validate()
            }))
        }
        
        form = Form(sections: [FormSection(items: formItems)])
    }
    
    private func validate() -> DataModel? {
        for item in items {
            if(item.value.text.count <= 0 && item.value.field != Field.state || item.value.text.count > 2 && item.value.field == Field.countryCode) {
                sendButton.isEnabled = false
                return item.value
            }
            if (item.value.field == Field.postalCode && !item.value.text.isNumber) {
                sendButton.isEnabled = false
                return item.value
            }
        }
        sendButton.isEnabled = true
        return nil
    }
    
    @objc private func send() {
        let paramters = [
            "name": items[0]!.text,
            "address_1": items[1]!.text,
            "address_2": items[2]!.text,
            "city": items[3]!.text,
            "state": items[4]!.text,
            "postal_code": items[5]!.text,
            "country_code": items[6]!.text,
        ]
        viewModel.createRequestBin(id: self.id, paramters: paramters)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func bindViewModel() {
        viewModel.didStartLoading = {
            self.activityIndicator.startAnimating()
        }
        
        viewModel.didFinishWithError = { error in
            DispatchQueue.main.async {
                self.alertShow(title: "Error", message: error.localizedDescription)
                self.activityIndicator.stopAnimating()
            }
        }
        
        viewModel.didFinishLoading = {
            DispatchQueue.main.async {
                self.alertShow()
                self.configRows()
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
}

extension UIViewController {
    func alertShow(title: String = "Success", message: String = "Successfully created") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
}

extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
