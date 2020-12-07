//
//  OrderConfirmationViewController.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 11/27/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: GenericViewController {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    let label:GenericLabel = {
        let thanksLabel = GenericLabel()
        thanksLabel.font = UIFont.systemFont(ofSize: 34)
        thanksLabel.textColor = NAVBAR_TEXT_COLOR
        thanksLabel.numberOfLines = 0
        thanksLabel.text = "Thank you for your order!"
        return thanksLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
    }
    
    func setupLayout() {
        self.view.addSubview(self.label)
        LayoutManager.shared.setLeadingAndTrailingAnchorForViews(view: self.label, toView: self.view, constant: 78.0)
        NSLayoutConstraint.activate([
            self.label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
}
