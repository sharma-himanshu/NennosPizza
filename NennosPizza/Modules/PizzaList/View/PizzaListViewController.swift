//
//  PizzaListViewController.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 11/19/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import UIKit

class PizzaListViewController: GenericViewController {
    private var dataModel: [PizzaModel] = []
    let presenter: PizzaListPresenting
    
    init(presenter: PizzaListPresenting) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableview: UITableView = {
        let pizzaListTableView = UITableView()
        pizzaListTableView.translatesAutoresizingMaskIntoConstraints = false
        pizzaListTableView.estimatedRowHeight = 250
        pizzaListTableView.rowHeight = UITableView.automaticDimension
        pizzaListTableView.delegate = self
        pizzaListTableView.dataSource = self
        pizzaListTableView.register(PizzaTableViewCell.self, forCellReuseIdentifier: "pizzaCell")
        return pizzaListTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        self.title = "NENNO'S PIZZA"
        self.setupNavItems()
        self.setupLayout()
    }
    
    func setupNavItems() {
        let cartNavigationItem = UIBarButtonItem(image: UIImage(named: "ic_cart_navbar"), style: .plain, target: self, action: #selector(cartButtonTapped))
        self.navigationItem.leftBarButtonItem = cartNavigationItem
        
        let createCustomPizzaItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createCustomPizzaButtonTapped))
        self.navigationItem.rightBarButtonItem = createCustomPizzaItem
    }
    
    func setupLayout() {
        view.addSubview(tableview)
        LayoutManager.shared.anchorViews(view: tableview, toView: view)
    }
}

extension PizzaListViewController: PizzaListViewing {
    func showAddedToCartAlert(for item: CartItemViewModel) {
        self.showAddedToCartAlertForCartItem(item:item)
    }
    
    func update(pizzas: [PizzaModel]) {
        dataModel = pizzas
        
        DispatchQueue.main.async { [unowned self] in
            self.tableview.reloadData()
        }
    }

    func showError(_ description: String) {
        print(description)
    }
    
    @objc func cartButtonTapped() {
        self.presenter.didTapCartNavButton()
    }
    
    @objc func createCustomPizzaButtonTapped() {
        
    }
}

extension PizzaListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pizzaCell = tableView.dequeueReusableCell(withIdentifier:"pizzaCell", for: indexPath) as? PizzaTableViewCell else {
            let pizzaCell = PizzaTableViewCell(style: .default, reuseIdentifier:"pizzaCell")
            return pizzaCell
        }
        if pizzaCell.pizza == nil {
            pizzaCell.pizza = dataModel[indexPath.row]
            pizzaCell.delegate = self
        }
        return pizzaCell
    }
}

extension PizzaListViewController: UITableViewDelegate, CellToViewAddToCartDelegate {
    func addToCartTapped(forPizza: PizzaModel) {
        self.presenter.didTapAddToCart(pizza: forPizza)
    }
}
