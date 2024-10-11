//
//  AuthenticationView.swift
//  unitedsetups
//
//  Created by Paras KCD on 6/10/24.
//

import SwiftUI

struct AuthenticationView: View {
    @State private var isPerformingTask = false
    @State private var register = false
    @EnvironmentObject var viewModel : AuthenticationViewModel
    
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                Color.clear
                Image("GradientImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: 256)
            }
            VStack {
                Image("USLogoWhite")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 72)
                
                if (register) {
                    NormalTextField(binding: $viewModel.username, promptText: "Username", icon: "Person")
                    NormalTextField(binding: $viewModel.name, promptText: "Display Name", icon: "Person")
                }
                
                EmailTextField(email: $viewModel.email)
                
                PasswordTextField(password: $viewModel.password)
                
                Button(action: {
                    if (viewModel.email.isEmpty || viewModel.password.isEmpty) {
                        return
                    }
                    
                    isPerformingTask = true
                    Task {
                        try? await viewModel.login()
                        isPerformingTask = viewModel.isLoading
                    }
                }){
                    HStack{
                        Spacer()
                        if (isPerformingTask) {
                            ProgressView()
                        } else {
                            if (register) {
                                Text("Register")
                            } else {
                                Text("Login")
                            }
                        }
                        Spacer()
                    }
                }
                .contentShape(Rectangle())
                .frame(maxWidth: .infinity)
                .padding([.top, .bottom], 8)
                .background(!isPerformingTask ? .accent : Color("Background"))
                .foregroundStyle(!isPerformingTask ? .black : .accent.opacity(0.5))
                .clipShape(Capsule())
                .padding()
                .shadow(radius: 10)
                .disabled(isPerformingTask)
                
                Button(action: { register = !register }) {
                    if (register) {
                        Text("Already have an account? Tap here to login")
                    } else {
                        Text("Don't have an account? Tap here to register")
                    }
                }
                .foregroundStyle(.accent)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("Surface"))
            .cornerRadius(16)
            .padding()
            .shadow(radius: 16)
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color("Background"))
        .foregroundStyle(.white)
    }
}
