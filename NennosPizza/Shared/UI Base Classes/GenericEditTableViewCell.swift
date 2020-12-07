//
//  GenericEditTableViewCell.swift
//  NennosPizza
//
//  Created by Himanshu Sharma on 12/1/20.
//  Copyright © 2020 Docler. All rights reserved.
//

import UIKit

enum EditMethodType {
    case none
    case add
    case delete
}

protocol EditCellDelegate: AnyObject {
    func deleteItem(item:CartItemViewModel?)
    func addItem(item:CartItemViewModel?)
}

class GenericEditTableViewCell: UITableViewCell {
    
    weak var delegate: EditCellDelegate?
    var editingMethod: EditMethodType = .none
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.item = nil
    }
    
    var accessoryImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.image = UIImage(named:"ic_delete")?.withRenderingMode(.alwaysTemplate)
        img.tintColor = NAVBAR_TEXT_COLOR
       return img
    }()
    
    var item: CartItemViewModel? {
        didSet {
            if let cartItem = item {
            self.titleLabel.text = cartItem.name
            self.priceLabel.text = cartItem.displayPrice
                switch self.editingMethod
                {
                case .delete:
                    accessoryImageView.image = UIImage(named:"ic_delete")?.withRenderingMode(.alwaysTemplate)
                case .add:
                    accessoryImageView.image = UIImage(named:"ic_add")?.withRenderingMode(.alwaysTemplate)
                default:
                    accessoryImageView.image = UIImage(named:"")?.withRenderingMode(.alwaysTemplate)
                }
                
                accessoryImageView.tintColor = NAVBAR_TEXT_COLOR
            }
        }
    }
    
    let accessoryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.text = ""
        button.backgroundColor = .clear
        return button
    }()
    
    let priceLabel: GenericLabel = {
        let priceText = GenericLabel()
        priceText.font = UIFont.systemFont(ofSize: 17)
        priceText.numberOfLines = 1
        return priceText
    }()
    
    let titleLabel: GenericLabel = {
        let priceText = GenericLabel()
        priceText.font = UIFont.systemFont(ofSize: 17)
        priceText.numberOfLines = 1
        return priceText
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(accessoryButton)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(accessoryImageView)
        self.contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            accessoryButton.widthAnchor.constraint(equalToConstant: 50),
            accessoryButton.heightAnchor.constraint(equalToConstant: 50),
            accessoryButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            accessoryButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
        ])
        accessoryButton.addTarget(self, action: #selector(editingButtonTapped), for: .touchUpInside)

        
        NSLayoutConstraint.activate([
            priceLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            priceLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            accessoryImageView.widthAnchor.constraint(equalToConstant: 15),
            accessoryImageView.heightAnchor.constraint(equalToConstant: 15),
            accessoryImageView.centerXAnchor.constraint(equalTo: self.accessoryButton.centerXAnchor),
            accessoryImageView.centerYAnchor.constraint(equalTo: self.accessoryButton.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.accessoryButton.trailingAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo:self.priceLabel.leadingAnchor, constant:-12)
        ])
    }
    
    @objc func editingButtonTapped() {
        if self.editingMethod == .delete {
            self.delegate?.deleteItem(item:self.item)
        }
        else if self.editingMethod == .add {
            self.delegate?.addItem(item:self.item)
        }
    }
}
