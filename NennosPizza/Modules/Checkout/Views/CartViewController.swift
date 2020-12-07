//
//  CartViewController.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 12/2/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import UIKit

class CartViewController: GenericViewController {
    
    var dataSource:[CartItemViewModel] = []
    var presenter: CartPresenting
    var footerView: CartFooterView? = nil
    init(presenter: CartPresenting) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableview: UITableView = {
        let cartTableView = UITableView()
        cartTableView.translatesAutoresizingMaskIntoConstraints = false
        cartTableView.estimatedRowHeight = 250
        cartTableView.rowHeight = UITableView.automaticDimension
        cartTableView.separatorInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        cartTableView.delegate = self
        cartTableView.dataSource = self
        cartTableView.register(GenericEditTableViewCell.self, forCellReuseIdentifier: "cartItemCell")
        cartTableView.register(CartFooterView.self, forHeaderFooterViewReuseIdentifier: "totalFooterView")
        return cartTableView
    }()
    
    lazy var checkoutButton: UIButton = {
        let checkout = UIButton()
        checkout.translatesAutoresizingMaskIntoConstraints = false
        checkout.backgroundColor = NAVBAR_TEXT_COLOR
        checkout.setTitle("CHECKOUT", for: .normal)
        checkout.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return checkout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CART"
        self.setupLayout()
        self.setupNavItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.refreshCart()
    }
    
    func setupNavItem() {
        let drinksNavigationItem = UIBarButtonItem(image: UIImage(named: "ic_drinks"), style: .plain, target: self, action: #selector(drinksButtonTapped))
        self.navigationItem.rightBarButtonItem = drinksNavigationItem
        }
    
    @objc func buttonAction(_ sender:UIButton?) {
        self.presenter.checkoutTapped()
    }

    @objc func drinksButtonTapped()
    {
        self.presenter.drinksNavigationItemTapped()
    }
    
    func setupLayout() {
        view.addSubview(tableview)
        view.addSubview(checkoutButton)
        LayoutManager.shared.setLeadingAndTrailingAnchorForViews(view: tableview, toView: self.view, constant: 0)
        LayoutManager.shared.setLeadingAndTrailingAnchorForViews(view: checkoutButton, toView: self.view, constant: 0)
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            checkoutButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            checkoutButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    
        if self.footerView == nil {
            self.footerView = CartFooterView.init(reuseIdentifier: "totalFooterView")
        }
        return self.footerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cartItemCell = tableView.dequeueReusableCell(withIdentifier:"cartItemCell", for: indexPath) as? GenericEditTableViewCell else {
            let cartItemCell = GenericEditTableViewCell(style: .default, reuseIdentifier:"cartItemCell")
            return cartItemCell
        }
        if cartItemCell.item == nil {
            cartItemCell.editingMethod = .delete
            cartItemCell.item = dataSource[indexPath.row]
            cartItemCell.delegate = self
        }
        return cartItemCell
    }
}

extension CartViewController: EditCellDelegate {
    func deleteItem(item: CartItemViewModel?) {
        self.presenter.deleteItemTapped(forItem: item)
    }
    
    func addItem(item: CartItemViewModel?) {
        // No Addition possible here on Cart Page
    }
}

extension CartViewController: CartViewing {
    func cartLoadSuccessful(cartItems: [CartItemViewModel], withTotal: String) {
        self.dataSource = cartItems
        DispatchQueue.main.async { [unowned self] in
            self.tableview.reloadData()
            self.footerView?.totalPriceLabel.text = withTotal
        }
    }
    
    func cartLoadFailure() {
        
    }
    
    
}
