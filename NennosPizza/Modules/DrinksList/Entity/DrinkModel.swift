//
//  DrinkModel.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 11/26/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import Foundation

struct DrinkModel: Codable, CartItemViewModel, Equatable {
    let id: Int
    let name: String
    let price: Double
    var displayPrice: String {
        return String.returnCurrencyValueForDouble(for:price)

    }
    
    static func == (lhs: DrinkModel, rhs: DrinkModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}
