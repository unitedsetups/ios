//
//  Constants.swift
//  unitedsetups
//
//  Created by Paras KCD on 6/10/24.
//

import Foundation

struct Constants {
    private static let apiUrl: String = "https://unitedsetups.paraskcd.com/api"
    static let loginEndpoint: () -> String = { "\(apiUrl)/auth/login" }
    static let registerEndpoint: () -> String = { "\(apiUrl)/auth/register" }
}
