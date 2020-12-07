//
//  CartInteractor.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 12/2/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import Foundation

class CartInteractor: CartInteracting {
    weak var delegate: CartInteractorDelegate?
    
    func fetchCart() {
        if let drinks = LocalDataManager.shared.cart?.drinks, let pizzas = LocalDataManager.shared.cart?.pizzas {
            self.delegate?.didLoadCart(items: pizzas + drinks, withTotal: String.returnCurrencyValueForDouble(for:LocalDataManager.shared.cart?.totalPrice ?? 0))
        }
    }
    
    func deleteItemFromCart(item: CartItemViewModel) {
        if item is PizzaModel {
            if let unwrappedPizza = item as? PizzaModel {
                LocalDataManager.shared.removePizzaFromCart(pizza: unwrappedPizza)
            }
        }
        else if item is DrinkModel {
            if let unwrappedDrink = item as? DrinkModel {
                LocalDataManager.shared.removeDrinkFromCart(drink: unwrappedDrink)
            }
        }
        self.fetchCart()
    }
    
    func checkoutButtonTapped() {
        
    }
}
