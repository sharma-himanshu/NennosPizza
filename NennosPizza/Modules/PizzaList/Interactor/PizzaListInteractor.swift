//
//  PizzaListInteractor.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 11/19/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import Foundation

class PizzaListInteractor: PizzaListInteracting
{
    weak var delegate: PizzaListInteractorDelegate?
    
    func fetchPizzas() {
        NetworkManager.shared.getPizzasRequest { (pizzas, error) in
            if let networkError = error {
                self.delegate?.handleError(networkError)
            }
            else {
                if let pizzaList = pizzas {
                    self.delegate?.didFetch(pizzas: pizzaList)
                }
            }
        }
    }
    
    func addToCart(pizza: PizzaModel) {
        LocalDataManager.shared.addPizzaToCart(pizza: pizza)
    }
    
    func didTapToChoosePizza(pizza: PizzaModel) {
        
    }
    
}
