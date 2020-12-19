//
//  CardView.swift
//  SDK_THP_Verifone
//
//  Created by Oraz Atakishiyev on 12/16/20.
//

import UIKit

open class TableView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var form: Form!
    var tableView = UITableView.init()
    var sendButton: UIBarButtonItem!
    var items: [Int: DataModel]!
    var viewModel: ViewModel = ViewModel()
    var activityIndicator: UIActivityIndicatorView!
    var id: String!
    
    enum ReuseIdentifiers: String {
        case textInput
    }
    
    public convenience init(id: String) {
        self.init(nibName: nil, bundle: nil)
        self.id = id
    }
    
    required public convenience init(coder aDecoder: NSCoder) {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: Layout Methods
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tableView.frame = self.view.bounds
    }
    
    private func model(at indexPath: IndexPath) -> FormItem {
        return form.sections[indexPath.section].items[indexPath.item]
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return form.sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return form.sections[section].items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = model(at: indexPath)
        if let textRow = object as? TextInputFormItem {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.textInput.rawValue, for: indexPath) as! TextInputTableViewCell
            cell.configure(for: textRow)
            return cell
        }
        else {
            fatalError("Unknown model \(object).")
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}
