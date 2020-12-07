//
//  PizzaTableViewCell.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 11/20/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import UIKit

protocol CellToViewAddToCartDelegate: AnyObject {
    func addToCartTapped(forPizza:PizzaModel)
}

class PizzaTableViewCell: UITableViewCell {
    
    weak var delegate: CellToViewAddToCartDelegate?
    
    let backgroundImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.image = UIImage(named: "bg_wood")
       return img
    }()
    
    let pizzaImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
       return img
    }()
    
    let titleLabel: GenericLabel = {
        let title = GenericLabel()
        title.font = UIFont.boldSystemFont(ofSize: 24)
        title.numberOfLines = 1
        return title
    }()
    
    let subtitleLabel: GenericLabel = {
        let subtitle = GenericLabel()
        subtitle.font = UIFont.systemFont(ofSize: 14)
        subtitle.numberOfLines = 2
        return subtitle
    }()
    
    let gradientView: UIView = {
        let gradientView = UIView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        return gradientView
    }()
    
    let addToCartView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.init(red: 255/255.0, green: 205/255.0, blue: 43/255.0, alpha: 1)
        containerView.layer.cornerRadius = 4.0
        containerView.clipsToBounds = true
        return containerView
    }()
    
    let cartIcon: UIImageView = {
       let cartImage = UIImageView()
        cartImage.contentMode = .scaleAspectFit
        cartImage.translatesAutoresizingMaskIntoConstraints = false
        cartImage.clipsToBounds = true
        cartImage.image = UIImage(named: "ic_cart")!.withRenderingMode(.alwaysTemplate)
        cartImage.tintColor = .white
        return cartImage
    }()
    
    let priceLabel: GenericLabel = {
        let priceText = GenericLabel()
        priceText.font = UIFont.boldSystemFont(ofSize: 16)
        priceText.textColor = .white
        priceText.numberOfLines = 1
        return priceText
    }()
    
    var pizza: PizzaModel? {
        didSet {
            if let pizzaImageURL = pizza?.imageUrl {
                if let imageURL = URL(string: pizzaImageURL) {
                pizzaImageView.setImage(from:imageURL)
                }
            }
            else {
                
            }
            self.titleLabel.text = pizza?.name
            self.subtitleLabel.text = pizza?.returnIngredientsList()
            self.priceLabel.text = "\(pizza?.price ?? "")"
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let addToCartTap = UITapGestureRecognizer(target: self, action: #selector(self.addToCartTapped(_:)))
        
        
        self.contentView.addSubview(backgroundImageView)
        self.contentView.addSubview(pizzaImageView)
        self.contentView.addSubview(gradientView)
        
        self.addToCartView.addSubview(self.cartIcon)
        self.addToCartView.addSubview(self.priceLabel)
        self.addToCartView.addGestureRecognizer(addToCartTap)
        self.gradientView.addSubview(self.addToCartView)
        
        NSLayoutConstraint.activate([
            addToCartView.heightAnchor.constraint(equalToConstant: 28.0),
            addToCartView.centerYAnchor.constraint(equalTo: self.gradientView.centerYAnchor),
            addToCartView.trailingAnchor.constraint(equalTo: self.gradientView.trailingAnchor, constant: -12.0)
        ])
        
        NSLayoutConstraint.activate([
            cartIcon.heightAnchor.constraint(equalToConstant: 25.0),
            cartIcon.widthAnchor.constraint(equalToConstant: 25.0),
            cartIcon.centerYAnchor.constraint(equalTo: addToCartView.centerYAnchor),
            cartIcon.leadingAnchor.constraint(equalTo: addToCartView.leadingAnchor, constant:3.0)
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: cartIcon.trailingAnchor, constant:2),
            priceLabel.centerYAnchor.constraint(equalTo: addToCartView.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: addToCartView.trailingAnchor, constant: -8)
        ])
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        LayoutManager.shared.setLeadingAndTrailingAnchorForViews(view: backgroundImageView, toView: self.contentView, constant: 0)
        backgroundImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: backgroundImageView.widthAnchor, multiplier: 178.0/375).isActive = true

        let bottomAnchorConstraint = backgroundImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0)
        bottomAnchorConstraint.priority = UILayoutPriority(rawValue: 250)
        bottomAnchorConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            pizzaImageView.heightAnchor.constraint(equalTo: backgroundImageView.heightAnchor
        ),
            pizzaImageView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor
        ),
            pizzaImageView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor
        )])
        
        LayoutManager.shared.setLeadingAndTrailingAnchorForViews(view: pizzaImageView, toView: backgroundImageView, constant: 30.0)
        
        gradientView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        gradientView.widthAnchor.constraint(equalTo: backgroundImageView.widthAnchor).isActive = true
        gradientView.heightAnchor.constraint(greaterThanOrEqualToConstant: 69.0).isActive = true
        let blurEffect = UIBlurEffect(style: .light)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.translatesAutoresizingMaskIntoConstraints = false

        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.translatesAutoresizingMaskIntoConstraints = false

        blurredEffectView.contentView.addSubview(vibrancyEffectView)
        
        NSLayoutConstraint.activate([
            vibrancyEffectView.heightAnchor.constraint(equalTo: blurredEffectView.contentView.heightAnchor),
            vibrancyEffectView.widthAnchor.constraint(equalTo: blurredEffectView.contentView.widthAnchor),
            vibrancyEffectView.centerXAnchor.constraint(equalTo: blurredEffectView.contentView.centerXAnchor),
            vibrancyEffectView.centerYAnchor.constraint(equalTo: blurredEffectView.contentView.centerYAnchor)
          ])
        
        gradientView.addSubview(blurredEffectView)
        gradientView.addSubview(titleLabel)
        gradientView.addSubview(subtitleLabel)
        gradientView.addSubview(addToCartView)

        LayoutManager.shared.setLeadingAndTrailingAnchorForViews(view: self.titleLabel, toView: gradientView, constant: 15)

        subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: addToCartView.leadingAnchor, constant: -20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: gradientView.topAnchor, constant: 12).isActive = true
        subtitleLabel.bottomAnchor
            .constraint(equalTo: gradientView.bottomAnchor, constant: -12).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor).isActive = true
        
        LayoutManager.shared.anchorViews(view: blurredEffectView, toView: gradientView)
        
    }
    
    @objc func addToCartTapped(_ sender:UITapGestureRecognizer) {
        if let unwrappedDelegate = self.delegate, let unwrappedPizza = self.pizza {
            unwrappedDelegate.addToCartTapped(forPizza: unwrappedPizza)
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.pizza = nil
        self.pizzaImageView.image = nil
    }
}
