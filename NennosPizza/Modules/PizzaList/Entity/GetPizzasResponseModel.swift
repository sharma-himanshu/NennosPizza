//
//  GetPizzasResponseModel.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 11/20/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import Foundation

struct GetPizzasResponseModel: Codable {
    let basePrice: Double
    let pizzas: [PizzaModel]
}
