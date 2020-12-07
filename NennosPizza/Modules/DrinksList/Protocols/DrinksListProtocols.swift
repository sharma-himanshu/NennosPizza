//
//  DrinksListProtocols.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 11/26/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import Foundation

protocol DrinksListViewing: class {
    func drinksLoadSuccess(drinks: [CartItemViewModel])
    func drinksLoadFailed(error: NetworkError)
    func showAddSuccessAlert(item:CartItemViewModel)
}

protocol DrinksListPresenting: class {
    var view: DrinksListViewing? { get set }
    
    func viewDidLoad()
    func addDrinkToCartTapped(drink: CartItemViewModel)
}

protocol DrinksListInteracting: class {
    var delegate: DrinksListInteractorDelegate? { get set }
    func fetchDrinks()
    func addDrinkToCart(item: CartItemViewModel)
}

protocol DrinksListInteractorDelegate: class {
    func fetchDrinksSuccess(drinks: [DrinkModel])
    func fetchDrinksFailed(error: NetworkError)
    func addDrinkToCartSuccess(item: CartItemViewModel)
    func addDrinkToCartFailed(error: NetworkError)
}

protocol DrinksListRouting: class {
    var viewController: GenericViewController? { get set }
}
