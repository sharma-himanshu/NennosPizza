//
//  CartModel.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 11/27/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import Foundation

struct CartModel: Codable {
    var pizzas: [PizzaModel]
    var drinks: [DrinkModel]
    var totalPrice: Double {
        var finalPrice = 0.0
        for pizza in pizzas {
            finalPrice += pizza.finalPrice
        }
        for drink in drinks {
            finalPrice += drink.price
        }
        return finalPrice
    }
}
