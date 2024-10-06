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
                .environment(authViewModel)
        } else {
            NavigationStack {
                VStack {
                    ScrollView {}
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Image("USLogoWhite")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 56)
                        }
                    }
                }
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(Color("Surface"), for: .automatic)
                .background(Color("Background"))
            }
        }
    }
}

#Preview {
    ContentView()
}
