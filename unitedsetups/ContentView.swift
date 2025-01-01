//
//  ContentView.swift
//  unitedsetups
//
//  Created by Paras KCD on 6/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authViewModel : AuthenticationViewModel = .init(loginUseCase: Injection.shared.provideLoginUseCase(), registerUseCase: Injection.shared.provideRegisterUseCase())
    
    var body: some View {
        if (!authViewModel.isLoggedIn) {
            AuthenticationView()
                .environmentObject(authViewModel)
        } else {
            MainView()
                .environmentObject(authViewModel)
        }
    }
}
