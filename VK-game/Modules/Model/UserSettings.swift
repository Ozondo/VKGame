//
//  File.swift
//  VK-game
//
//  Created by Егор Иванов on 10.04.2024.
//

import Foundation

final class UserSettings {
    
    private enum SettingsKeys: String {
        case userName
        case modelAirplane
        case modeGame
        case recordScore
    }
    
    static var userName: String? {
        get {
            return UserDefaults.standard.string(forKey: SettingsKeys.userName.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userName.rawValue
            if let newValue {
                defaults.set(newValue, forKey: key)
            }else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var modelAirplane: Int? {
        get {
            return UserDefaults.standard.integer(forKey: SettingsKeys.modelAirplane.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let keyModelAirplane = SettingsKeys.modelAirplane.rawValue
            if let newValue {
                defaults.set(newValue, forKey: keyModelAirplane)
            }else {
                defaults.removeObject(forKey: keyModelAirplane)
            }
        }
    }
    
    static var modeGame: Int? {
        get {
            return UserDefaults.standard.integer(forKey: SettingsKeys.modeGame.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let keyModeGame = SettingsKeys.modeGame.rawValue
            if let newValue {
                defaults.set(newValue, forKey: keyModeGame)
            }else {
                defaults.removeObject(forKey: keyModeGame)
            }
        }
    }
    
     static var records: [UserData]? {
       get {
           let userDefaults = UserDefaults.standard
           return  userDefaults.readData(type: [UserData].self, key: SettingsKeys.recordScore.rawValue)
       } set {
           let userDefaults = UserDefaults.standard
           let recordsKey = SettingsKeys.recordScore.rawValue
           if let newValue {
               userDefaults.save(someData: newValue, key: recordsKey )
           } else {
               userDefaults.removeObject(forKey: recordsKey)
           }
       }
   }
}

extension UserDefaults {
    func save<T: Codable>(someData: T, key: String) {
        let data = try? JSONEncoder().encode(someData)
        set(data, forKey: key)
    }

    func readData<T: Codable>(type: T.Type, key: String) ->  T? {
        guard let data = value(forKey: key) as? Data else { return nil }
        let newData = try? JSONDecoder().decode(type, from: data)
        return newData
    }
}


