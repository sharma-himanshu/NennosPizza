//
//  LocalDataManager.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 11/29/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import Foundation

var plistURL: URL {
    let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documents.appendingPathComponent("cart.plist")
}

class LocalDataManager
{
    static let shared = LocalDataManager()
    
    var cart: CartModel?
    var ingredients: [IngredientModel]?
    
    private init() { }

    func itemCount() -> Int {
        return ((self.cart?.pizzas.count ?? 0) + (self.cart?.drinks.count ?? 0))
    }
    
    func saveCart() {
        let encoder = PropertyListEncoder()
        if let data = try? encoder.encode(cart) {
            if FileManager.default.fileExists(atPath: plistURL.path) {
                // Update an existing plist
                try? data.write(to:plistURL)
            } else {
                // Create a new plist
                FileManager.default.createFile(atPath: plistURL.path, contents: data, attributes: nil)
            }
        }
    }
    
    func resetCart() {
        self.cart = nil
        self.initializeCart()
    }
    
    func getCart() {
        let decoder = PropertyListDecoder()
        
        guard let data = try? Data.init(contentsOf:plistURL),
              let cart = try? decoder.decode(CartModel.self, from: data)
        else {
            return
        }
        self.cart = cart
        self.initializeCart()
    }
    
    func initializeCart() {
        if self.cart == nil {
            let emptyCart = CartModel(pizzas: [], drinks: [])
            self.cart = emptyCart
            self.saveCart()
        }
    }
    
    func addPizzaToCart(pizza:PizzaModel) {
        self.initializeCart()
        self.cart?.pizzas.append(pizza)
        self.saveCart()
    }
    
    func removePizzaFromCart(pizza: PizzaModel) {
        if let index = self.cart?.pizzas.firstIndex(of: pizza) {
            self.cart?.pizzas.remove(at: index)
        }
        self.saveCart()
    }
    
    func removeDrinkFromCart(drink: DrinkModel) {
        if let index = self.cart?.drinks.firstIndex(of: drink) {
            self.cart?.drinks.remove(at: index)
        }
        self.saveCart()
    }
    
    func addDrinkToCart(drink:DrinkModel) {
        self.initializeCart()
        self.cart?.drinks.append(drink)
        self.saveCart()
    }
    
    func reloadIngredients(completed:@escaping(_ completed:Bool) -> Void) {
        NetworkManager.shared.getIngredientsRequest { (ingredients, error) in
            self.ingredients = ingredients
            completed(true)
        }
    }
    
    func returnPriceTotalForIngredientIds(ids:[Int]) -> Double {
        var totalIngredientPrice: Double = 0
        
        if let savedIngredients = ingredients {
            for id in ids {
                for ingredient in savedIngredients {
                    if ingredient.id == id {
                        totalIngredientPrice += ingredient.price
                    }
                }
            }
        }
        return totalIngredientPrice
    }
    
    func returnAllIngredientsStringListForIds(ids:[Int]) -> String {
        var resultString:[String] = []
        if let savedIngredients = ingredients {
            for id in ids {
                for ingredient in savedIngredients {
                    if ingredient.id == id {
                        resultString.append(ingredient.name)
                    }
                }
            }
        }
        return resultString.joined(separator: ", ")
    }
}
