//
//  NetworkManager.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 11/18/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import Foundation

class NetworkManager
{
    static let shared = NetworkManager()
    var isRequestPending = false
    
    private init() { }
    
    func getIngredientsRequest(completionHandler: @escaping(_ ingredients: [IngredientModel]?, _ error: NetworkError?) -> Void)
    {
        let url = URL(string: INGREDIENTS_URL)!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            //print(String(data: data, encoding: .utf8)!)
            if let networkError = error as NSError? {
                // TODO Convert error into NetworkError
                let newError = NetworkError(statusCode:networkError.code, errorDescription: networkError.localizedDescription)
                completionHandler(nil, newError)
            }
            do {
                let response = try JSONDecoder().decode([IngredientModel].self, from:data)
                print (response[0].name)
                completionHandler(response, nil)
            }
            catch let jsonError {
                print("Error serializing JSON \(jsonError)")
            }
        }
        task.resume()
    }
    
    
    func getDrinksRequest(completionHandler: @escaping(_ drinks: [DrinkModel]?, _ error: NetworkError?) -> Void)
    {
        let url = URL(string: DRINKS_URL)!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            //print(String(data: data, encoding: .utf8)!)
            if let networkError = error as NSError? {
                // TODO Convert error into NetworkError
                let newError = NetworkError(statusCode:networkError.code, errorDescription: networkError.localizedDescription)
                completionHandler(nil, newError)
            }
            do {
                let response = try JSONDecoder().decode([DrinkModel].self, from:data)
                print (response[0].name)
                completionHandler(response, nil)
            }
            catch let jsonError {
                print("Error serializing JSON \(jsonError)")
            }
        }
        task.resume()
    }
    
    func getPizzasRequest(completionHandler: @escaping(_ pizzas: [PizzaModel]?, _ error: NetworkError?) -> Void)
    {
        let url = URL(string: PIZZAS_URL)!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            //print(String(data: data, encoding: .utf8)!)
            if let networkError = error as NSError? {
                // TODO Convert error into NetworkError
                let newError = NetworkError(statusCode:networkError.code, errorDescription: networkError.localizedDescription)
                completionHandler(nil, newError)
            }
            do {
                let response = try JSONDecoder().decode(GetPizzasResponseModel.self, from:data)
                
                var pizzasWithBasePrice: [PizzaModel] = []
                for (var pizza) in response.pizzas {
                    pizza.basePrice = response.basePrice
                    pizzasWithBasePrice.append(pizza)
                }
                completionHandler(pizzasWithBasePrice, nil)
            }
            catch let jsonError {
                print("Error serializing JSON \(jsonError)")
            }
        }
        task.resume()
    }
    
}

