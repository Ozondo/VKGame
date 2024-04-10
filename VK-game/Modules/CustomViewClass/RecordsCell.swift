//
//  File.swift
//  VK-game
//
//  Created by Егор Иванов on 10.04.2024.
//

import UIKit

class RecordsCell: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    var nameLabel = UILabel()
    var emptyView = UIView()
    var scoreLabel = UILabel()
    var stackView = UIStackView()
    var index = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStackView()
        setupSubView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        scoreLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
    
    func setupSubView() {
        backgroundColor = .white
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(emptyView)
        stackView.addArrangedSubview(scoreLabel)
        nameLabel.textColor = .black
        scoreLabel.textColor = .black
    }
}

