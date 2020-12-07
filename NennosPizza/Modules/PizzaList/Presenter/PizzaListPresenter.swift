//
//  PizzaListPresenter.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 11/19/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import Foundation

class PizzaListPresenter: PizzaListPresenting {
    
    weak var view: PizzaListViewing?
    private let router: PizzaListRouting
    private let interactor: PizzaListInteracting

    // MARK: - Init


    init(interactor: PizzaListInteracting, router: PizzaListRouting) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        LocalDataManager.shared.reloadIngredients { (completed) in
            LocalDataManager.shared.getCart()
            self.interactor.fetchPizzas()
        }
    }
    
    func didTapAddToCart(pizza: PizzaModel) {
        interactor.addToCart(pizza: pizza)
        view?.showAddedToCartAlert(for: pizza)
    }
    
    func didTapToChoosePizza(pizza: PizzaModel) {
        interactor.didTapToChoosePizza(pizza: pizza)
    }
    
    func didTapCartNavButton() {
        // Route to Cart View Controller
        self.router.navigateToCart()
    }
    
    func didTapCreateCustomPizzaNavButton() {
        // Route to Create Custom Pizza
    }
}

extension PizzaListPresenter: PizzaListInteractorDelegate {
    func didFetch(pizzas: [PizzaModel]) {
        self.view?.update(pizzas: pizzas)
    }
    
    func handleError(_ error: NetworkError) {
        self.view?.showError(error.errorDescription)
    }
}
