//
//  RegisterRequest.swift
//  unitedsetups
//
//  Created by Paras KCD on 6/10/24.
//

import Foundation

struct RegisterRequest: Encodable {
    let username: String
    let email: String
    let name: String
    let password: String
}
