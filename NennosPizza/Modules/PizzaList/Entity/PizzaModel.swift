//
//  PizzaModel.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 11/19/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import Foundation

struct PizzaModel: Codable, CartItemViewModel, Equatable {
    
    let name: String
    let ingredients: [Int]
    let imageUrl:String?
    var basePrice: Double?
    var price: String?
    {
        return String.returnCurrencyValueForDouble(for:finalPrice)
    }
    
    var finalPrice:Double {
        let ingredientsTotalPrice = LocalDataManager.shared.returnPriceTotalForIngredientIds(ids: ingredients)
        
        var finalPrice: Double = 0
        if let unwrappedBasePrice = basePrice {
             finalPrice = unwrappedBasePrice + ingredientsTotalPrice
        }
        return finalPrice
    }
    
    var displayPrice: String {
        return "\(price ?? "")"
    }
    
    func returnIngredientsList() -> String
    {
        return LocalDataManager.shared.returnAllIngredientsStringListForIds(ids: ingredients)
    }
    
    static func == (lhs: PizzaModel, rhs: PizzaModel) -> Bool {
        return lhs.name == rhs.name
    }
}

struct IngredientModel: Codable {
    let id: Int
    let name: String
    let price: Double
}
