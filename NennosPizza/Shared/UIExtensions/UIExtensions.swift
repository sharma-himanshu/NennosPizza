//
//  UIExtensions.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 11/20/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func setImage(from url: URL) {
        
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) {
            self.image = imageFromCache as? UIImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let imageToCache = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                imageCache.setObject(imageToCache, forKey: url as AnyObject)
                self.image = imageToCache
                self.alpha = 0
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                    self.alpha = 1
                    },
                completion:nil)
            }
        }.resume()
    }
}

extension String {
    static func returnCurrencyValueForDouble(for doubleValue:Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.minimumFractionDigits = (doubleValue.truncatingRemainder(dividingBy: 1) == 0) ? 0 : 2
        currencyFormatter.locale = Locale.current
        
        return currencyFormatter.string(from: NSNumber(value: doubleValue)) ?? ""
    }
}
