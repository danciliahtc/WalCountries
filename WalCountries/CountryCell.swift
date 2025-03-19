//
//  CountryCell.swift
//  WalCountries
//
//  Created by Dancilia Harmon   on 3/14/25.
//

import UIKit

class CountryCell: UITableViewCell {
    
    internal let nameLabel = UILabel()
    private let codeLabel = UILabel()
    internal let capitalLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        backgroundColor = .systemBackground
        
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        nameLabel.adjustsFontForContentSizeCategory = true
        nameLabel.textColor = .label
        nameLabel.numberOfLines = 0
        
        capitalLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        capitalLabel.adjustsFontForContentSizeCategory = true
        capitalLabel.textColor = .secondaryLabel
        capitalLabel.numberOfLines = 0
        
        isAccessibilityElement = true
        nameLabel.isAccessibilityElement = true
        capitalLabel.isAccessibilityElement = true
        
    }
    
    private func setupConstraints() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, capitalLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with country: Country) {
        nameLabel.text = "\(country.name), \(country.region)    \(country.code)"
        capitalLabel.text = country.capital
        
        nameLabel.accessibilityLabel = "\(country.name), located in \(country.region), with code \(country.code)"
        capitalLabel.accessibilityLabel = "Capital city: \(country.capital)"
        
        nameLabel.accessibilityHint = "This is the country name and region."
        capitalLabel.accessibilityHint = "This is the capital city."
    }
}
