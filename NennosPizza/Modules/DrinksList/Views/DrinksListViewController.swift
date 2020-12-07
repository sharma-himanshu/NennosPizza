//
//  DrinksListViewController.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 11/26/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import UIKit

class DrinksListViewController: GenericViewController {
    var drinksData: [CartItemViewModel] = []
    var presenter: DrinksListPresenting
    
    init(presenter: DrinksListPresenting) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "DRINKS"
        self.setupLayout()
        self.presenter.viewDidLoad()
    }
    
    func setupLayout() {
        self.view.addSubview(tableview)
        LayoutManager.shared.anchorViews(view: tableview, toView: self.view)
    }
    
    lazy var tableview: UITableView = {
        let drinksTableView = UITableView()
        drinksTableView.translatesAutoresizingMaskIntoConstraints = false
        drinksTableView.estimatedRowHeight = 250
        drinksTableView.rowHeight = UITableView.automaticDimension
        drinksTableView.separatorInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        drinksTableView.delegate = self
        drinksTableView.dataSource = self
        drinksTableView.register(GenericEditTableViewCell.self, forCellReuseIdentifier: "cartItemCell")
        return drinksTableView
    }()
}

extension DrinksListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinksData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cartItemCell = tableView.dequeueReusableCell(withIdentifier:"cartItemCell", for: indexPath) as? GenericEditTableViewCell else {
            let cartItemCell = GenericEditTableViewCell(style: .default, reuseIdentifier:"cartItemCell")
            return cartItemCell
        }
        if cartItemCell.item == nil {
            cartItemCell.editingMethod = .add
            cartItemCell.item = drinksData[indexPath.row]
            cartItemCell.delegate = self
        }
        return cartItemCell
    }
}

extension DrinksListViewController: DrinksListViewing {
    func drinksLoadSuccess(drinks: [CartItemViewModel]) {
        self.drinksData = drinks
        DispatchQueue.main.async { [unowned self] in
            self.tableview.reloadData()
        }    }
    
    func drinksLoadFailed(error: NetworkError) {
        // Show Error
    }
    
    func showAddSuccessAlert(item:CartItemViewModel) {
        self.showAddedToCartAlertForCartItem(item: item)
    }
}

extension DrinksListViewController: EditCellDelegate {
    func deleteItem(item: CartItemViewModel?) {
        // No deletion possible
    }
    
    func addItem(item: CartItemViewModel?) {
        if let unwrappedDrink = item {
            self.presenter.addDrinkToCartTapped(drink: unwrappedDrink)
        }
    }
}
