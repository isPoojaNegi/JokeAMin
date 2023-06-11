//
//  JokeTableViewCell.swift
//  JokeAMin
//
//  Created by Pooja on 10/06/23.
//

import UIKit

class JokeTableViewCell: UITableViewCell {
    
    private var labelText: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        labelText = UILabel()
        labelText.numberOfLines = 0
        labelText.lineBreakMode = .byWordWrapping
        labelText.textColor = .darkGray
        contentView.addSubview(labelText)
    }
    
    private func setupConstraints() {
        labelText.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            labelText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            labelText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            labelText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            labelText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ]
        
        NSLayoutConstraint.activate(constraints)
        self.layoutIfNeeded()
    }
    
    func populateData(with joke: String) {
        labelText.text = joke
    }
}
