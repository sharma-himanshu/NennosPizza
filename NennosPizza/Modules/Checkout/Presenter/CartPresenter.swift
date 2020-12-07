//
//  CartPresenter.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 12/2/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import Foundation

class CartPresenter: CartPresenting {    
    
    var view: CartViewing?
    private let interactor: CartInteractor
    private var router: CartRouting
    
    init(interactor: CartInteractor, router: CartRouting) {
        self.interactor = interactor
        self.router = router
    }
    
    func refreshCart() {
        self.interactor.fetchCart()
    }
    
    func deleteItemTapped(forItem: CartItemViewModel?) {
        if let itemToDelete = forItem {
            self.interactor.deleteItemFromCart(item: itemToDelete)
        }
    }
    
    func checkoutTapped() {        
        self.interactor.checkoutButtonTapped()
    }
    
    func drinksNavigationItemTapped() {
        self.router.navigateToDrinksList()
    }
}

extension CartPresenter: CartInteractorDelegate {
    func checkoutSuccess() {
        self.router.navigateToOrderConfirmation()
    }
    
    func checkoutError(error: NetworkError) {
        view?.showError(error: error)
    }
    
    func didLoadCart(items: [CartItemViewModel], withTotal: String) {
        view?.cartLoadSuccessful(cartItems: items, withTotal: withTotal)
    }
    
    func handleError(_ error: NetworkError) {
        //view?.showError(error:error)
    }
}
