//
//  DrinksListRouter.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 11/26/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import Foundation

class DrinksListRouter: DrinksListRouting {
    weak var viewController: GenericViewController?
    
    static func makeModule() -> DrinksListViewController {
        
        let router = DrinksListRouter()
        let interactor = DrinksListInteractor()
        let presenter = DrinksListPresenter(interactor: interactor, router: router)
        let viewController = DrinksListViewController(presenter: presenter)
        
        router.viewController = viewController
        presenter.view = viewController
        interactor.delegate = presenter
        
        return viewController
    }
}
