//
//  PizzaListRouter.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 11/19/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import UIKit

class PizzaListRouter: PizzaListRouting {
    
    weak var viewController: GenericViewController?
    
    static func makeModule() -> PizzaListViewController {
        
        let router = PizzaListRouter()
        let interactor = PizzaListInteractor()
        let presenter = PizzaListPresenter(interactor: interactor, router: router)
        let viewController = PizzaListViewController(presenter: presenter)
        
        router.viewController = viewController
        presenter.view = viewController
        interactor.delegate = presenter
        
        return viewController
    }
    
    func navigateToCart() {
        let cartViewController = CartRouter.makeModule()
        self.viewController?.navigationController?.pushViewController(cartViewController, animated: true)
    }
}
