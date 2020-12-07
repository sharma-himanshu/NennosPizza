//
//  CartRouter.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 12/2/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import Foundation

class CartRouter: CartRouting {
    weak var viewController: GenericViewController?
    
    static func makeModule() -> CartViewController {
        
        let router = CartRouter()
        let interactor = CartInteractor()
        let presenter = CartPresenter(interactor: interactor, router: router)
        let viewController = CartViewController(presenter: presenter)
        
        router.viewController = viewController
        presenter.view = viewController
        interactor.delegate = presenter
        
        return viewController
    }
    
    func navigateToDrinksList()
    {
        let viewController: DrinksListViewController = DrinksListRouter.makeModule()
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)

    }
    
    func navigateToOrderConfirmation()
    {
        
    }
}
