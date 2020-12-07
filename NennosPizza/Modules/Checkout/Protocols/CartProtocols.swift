//
//  CartProtocols.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 12/2/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import Foundation

protocol CartPresenting: class {
    var view:CartViewing? { get set }
    
    func refreshCart()
    func deleteItemTapped(forItem:CartItemViewModel?)
    func checkoutTapped()
    func drinksNavigationItemTapped()
}

protocol CartItemViewModel {
    var name:String { get }
    var displayPrice:String { get }
}

protocol CartViewing: class {
    func cartLoadSuccessful(cartItems:[CartItemViewModel], withTotal: String)
    func cartLoadFailure()
}

protocol CartInteracting: class {
    var delegate: CartInteractorDelegate? { get set }
    func fetchCart()
    func deleteItemFromCart(item: CartItemViewModel)
}

protocol CartInteractorDelegate: class {
    func didLoadCart(items: [CartItemViewModel], withTotal:String)
    func handleError(_ error: NetworkError)
    func checkoutSuccess()
    func checkoutError(error: NetworkError)
}

protocol CartRouting: class {
    var viewController: GenericViewController? { get set }
    func navigateToDrinksList()
    func navigateToOrderConfirmation()
}
