//
//  RecipeViewCell.swift
//  TheCulinaryCompanion
//
//  Created by Rodney Zhang on 2024-06-14.
//

import UIKit

class RecipeViewCell: UITableViewCell {
    
    static let identifier = "RecipeViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    func setUpCell(){
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
        ])
    }
    
    func configCell(recipe: Recipe) {
        self.nameLabel.text = recipe.name
    }
    
}
