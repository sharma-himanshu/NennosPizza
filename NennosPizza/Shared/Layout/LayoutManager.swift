//
//  LayoutManager.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 11/18/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import UIKit

class LayoutManager {
    
    static let shared = LayoutManager()
    
    private init() {}
    
    func anchorViews(view: UIView, toView: UIView) {
        view.topAnchor.constraint(equalTo: toView.topAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: toView.leftAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: toView.bottomAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: toView.rightAnchor).isActive = true
    }
    
    func setLeadingAndTrailingAnchorForViews(view: UIView, toView: UIView, constant:CGFloat) {
        view.leadingAnchor.constraint(equalTo: toView.leadingAnchor, constant: constant).isActive = true
        view.trailingAnchor.constraint(equalTo: toView.trailingAnchor, constant: -constant).isActive = true
    }
}
