//
//  Models.swift
//  VK-game
//
//  Created by Егор Иванов on 10.04.2024.
//

import Foundation

struct UserData: Codable {
    var name: String
    var score: Int
    
}

extension String {
    static let airplaneArr = ["GrayAirplane", "GreenAirplane", "SpaceAirplane", "Airplane"]
}

