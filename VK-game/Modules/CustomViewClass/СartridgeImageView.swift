//
//  File.swift
//  VK-game
//
//  Created by Егор Иванов on 10.04.2024.
//

import UIKit

class СartridgeImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        let image = UIImage(named: "cartridge")
        self.image = image
    }
}

