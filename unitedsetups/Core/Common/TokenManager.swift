//
//  TokenManager.swift
//  unitedsetups
//
//  Created by Paras KCD on 6/10/24.
//

import Foundation

struct TokenManager {
    func saveAccessToken(access_token: String) -> Bool{
        let preferences = UserDefaults.standard
        print("saveAccessToken : \(access_token)")
        preferences.set(access_token, forKey: "access_token")
        return didSave(preferences: preferences)
    }
        
    func getAccessToken() -> String{
        let preferences = UserDefaults.standard
        if preferences.string(forKey: "access_token") != nil{
            let access_token = preferences.string(forKey: "access_token")
            return access_token!
        } else {
            return ""
        }
    }

    // Checking the UserDefaults is saved or not
    func didSave(preferences: UserDefaults) -> Bool{
        let didSave = preferences.synchronize()
        if !didSave{
            print("Preferences could not be saved!")
        }
        return didSave
    }
    
    static let shared = TokenManager()
}
