//
//  DrinksListInteractor.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 11/26/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import Foundation

class DrinksListInteractor: DrinksListInteracting {
    
    var delegate: DrinksListInteractorDelegate?
    
    func fetchDrinks() {
        NetworkManager.shared.getDrinksRequest { (drinksData, error) in
            if(error == nil) {
                self.delegate?.fetchDrinksSuccess(drinks: drinksData ?? [])
            }
            else {
                self.delegate?.fetchDrinksFailed(error: error ?? NetworkError(statusCode: 599, errorDescription: "Unknown Error"))
            }
        }
    }
    
    func addDrinkToCart(item: CartItemViewModel) {
        if let unwrappedDrink = item as? DrinkModel {
            LocalDataManager.shared.addDrinkToCart(drink: unwrappedDrink)
            self.delegate?.addDrinkToCartSuccess(item:item)
        }
    }
}
