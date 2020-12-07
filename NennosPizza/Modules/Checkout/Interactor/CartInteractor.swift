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
    
    func resetCart()
    {
        LocalDataManager.shared.resetCart()
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
        // Validation check to see if Cart isn't empty
        let totalItems = LocalDataManager.shared.itemCount()
        if (totalItems == 0)  {
            self.delegate?.checkoutError(error: NetworkError(statusCode: 406, errorDescription: "Your cart is empty, please add an item to checkout!"))
        }
        else {
            var postParams: [String:Any] = [:]
            var drinks:[NSNumber] = []
            drinks = LocalDataManager.shared.cart?.drinks.map({ NSNumber(value: $0.id)}) ?? []
            postParams["drinks"] = drinks
            var pizzaParam:[[String:Any]] = []
            if let pizzas = LocalDataManager.shared.cart?.pizzas {
                for pizza in pizzas {
                    let dict:[String:Any] = ["name":pizza.name,
                                             "ingredients":pizza.ingredients]
                    pizzaParam.append(dict)
                }
            }
            postParams["pizzas"] = pizzaParam
            
            NetworkManager.shared.checkout(postParams) { (error) in
                if(error == nil) {
                    self.delegate?.checkoutSuccess()
                    self.resetCart()
                }
                else {
                    if let unwrappedError = error {
                        self.delegate?.checkoutError(error: unwrappedError)
                    }
                }
            }
        }
    }
}
