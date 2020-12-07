//
//  CartFooterView.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 12/3/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import UIKit

class CartFooterView: UITableViewHeaderFooterView
{
    let totalLabel: GenericLabel = {
        let label = GenericLabel()
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        label.text = "TOTAL"
        return label
    }()
    
    lazy var totalPriceLabel: GenericLabel = {
        var priceLabel = GenericLabel()
        priceLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        priceLabel.text = "$99"
        return priceLabel
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(totalLabel)
        self.contentView.addSubview(totalPriceLabel)
        self.contentView.backgroundColor = .white
        NSLayoutConstraint.activate([
            totalLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            totalLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 50),
            totalLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            totalPriceLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            totalPriceLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            totalPriceLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
