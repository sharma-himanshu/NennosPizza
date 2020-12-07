//
//  DrinksListPresenter.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 11/26/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import Foundation

class DrinksListPresenter: DrinksListPresenting {
    var view: DrinksListViewing?
    
    private let interactor: DrinksListInteractor
    private var router: DrinksListRouter
    
    init(interactor: DrinksListInteractor, router: DrinksListRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        self.interactor.fetchDrinks()
    }
    
    func addDrinkToCartTapped(drink: CartItemViewModel) {
        self.interactor.addDrinkToCart(item: drink)
    }
}

extension DrinksListPresenter: DrinksListInteractorDelegate {
    
    func fetchDrinksSuccess(drinks: [DrinkModel]) {
        self.view?.drinksLoadSuccess(drinks: drinks)
    }
    
    func fetchDrinksFailed(error: NetworkError) {
        
    }
    
    func addDrinkToCartSuccess(item: CartItemViewModel) {
        self.view?.showAddSuccessAlert(item: item)
    }
    
    func addDrinkToCartFailed(error: NetworkError) {
        
    }
    
    
}
