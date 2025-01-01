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
        preferences.set(access_token, forKey: "access_token")
        return didSave(preferences: preferences)
    }
    
    func saveUserId(user_id: String) -> Bool {
        let preferences = UserDefaults.standard
        preferences.set(user_id, forKey: "user_id")
        return didSave(preferences: preferences)
    }
        
    func getAccessToken() -> String{
        let preferences = UserDefaults.standard
        if preferences.string(forKey: "access_token") != nil {
            let access_token = preferences.string(forKey: "access_token")
            return access_token!
        } else {
            return ""
        }
    }
    
    func revokeAccessToken() {
        let preferences = UserDefaults.standard
        guard let access_token = preferences.string(forKey: "access_token") else { return }
        preferences.removeObject(forKey: "access_token")
        guard let user_id = preferences.string(forKey: "user_id") else { return }
        preferences.removeObject(forKey: "user_id")
    }
    
    func getUserId() -> String {
        let preferences = UserDefaults.standard
        if preferences.string(forKey: "user_id") != nil {
            let userId = preferences.string(forKey: "user_id")
            return userId!
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
