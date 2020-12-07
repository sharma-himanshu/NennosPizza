//
//  GenericViewController.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 11/23/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import UIKit
import SwiftMessages

class GenericViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        SwiftMessages.defaultConfig.duration = .seconds(seconds: 2)
        SwiftMessages.defaultConfig.interactiveHide = false
        SwiftMessages.defaultConfig.presentationContext = .window(windowLevel: .statusBar)
    }
    
    func showAddedToCartAlertForCartItem(item: CartItemViewModel)
    {
        SwiftMessages.show {
            let view = MessageView.viewFromNib(layout: .cardView)
            view.configureTheme(.error)
            view.configureContent(title:"Added to Cart", body:"\(item.name) has been successfully added to your Cart.")
            view.button?.isHidden = true
            view.iconLabel?.isHidden = true
            view.iconImageView?.isHidden = true
            return view
        }
    }
}
