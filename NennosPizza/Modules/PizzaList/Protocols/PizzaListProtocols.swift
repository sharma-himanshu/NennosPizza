//
//  PizzaListProtocols.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 11/19/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import UIKit

protocol PizzaListPresenting: class {
    var view: PizzaListViewing? { get set }

    func viewDidLoad()
    func didTapAddToCart(pizza: PizzaModel)
    func didTapCartNavButton()
    func didTapCreateCustomPizzaNavButton()
}

protocol PizzaListViewing: class {
    func update(pizzas: [PizzaModel])
    func showError(_ description: String)
    func showAddedToCartAlert(for item:CartItemViewModel)
}

protocol PizzaListInteracting: class {
    var delegate: PizzaListInteractorDelegate? { get set }
    
    func fetchPizzas()
    func addToCart(pizza: PizzaModel)
    func didTapToChoosePizza(pizza: PizzaModel)
}

protocol PizzaListInteractorDelegate: class {
    func didFetch(pizzas: [PizzaModel])
    func handleError(_ error: NetworkError)
}

protocol PizzaListRouting: class {
    var viewController: GenericViewController? { get set }
    func navigateToCart()
}
