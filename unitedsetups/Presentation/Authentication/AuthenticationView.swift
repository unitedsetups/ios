//
//  AuthenticationView.swift
//  unitedsetups
//
//  Created by Paras KCD on 6/10/24.
//

import AlertToast
import SwiftUI

struct AuthenticationView: View {
    @State private var isPerformingTask = false
    @State private var register = false
    @State private var showToast = false
    @State private var toastMessage: String?
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
                    if (register && (viewModel.email.isEmpty || viewModel.password.isEmpty || viewModel.name.isEmpty || viewModel.username.isEmpty)) {
                        return
                    }
                    
                    if (!register && (viewModel.email.isEmpty || viewModel.password.isEmpty)) {
                        return
                    }
                    
                    isPerformingTask = true
                    Task {
                        if (register) {
                            try? await viewModel.register()
                        } else {
                            try? await viewModel.login()
                        }
                        
                        if (((viewModel.errorMessage?.isEmpty) == false)) {
                            toastMessage = viewModel.errorMessage ?? nil
                            viewModel.errorMessage = nil
                            showToast = true
                        } else {
                            register = false
                        }
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
                    .contentShape(Capsule())
                }
                .frame(maxWidth: .infinity)
                .padding([.top, .bottom], 8)
                .background(isPerformingTask || viewModel.email.isEmpty || viewModel.password.isEmpty || (register && (viewModel.name.isEmpty || viewModel.username.isEmpty)) ? Color("Background") : .accent)
                .foregroundStyle(isPerformingTask || viewModel.email.isEmpty || viewModel.password.isEmpty || (register && (viewModel.name.isEmpty || viewModel.username.isEmpty)) ? .accent.opacity(0.5) : .black)
                .clipShape(Capsule())
                .padding()
                .shadow(radius: 10)
                .disabled(isPerformingTask || viewModel.email.isEmpty || viewModel.password.isEmpty || (register && (viewModel.name.isEmpty || viewModel.username.isEmpty)))
                
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
        .toast(isPresenting: $showToast) {
            AlertToast(displayMode: .banner(.slide), type: .error(Color("ErrorColor")), title: toastMessage)
        }
    }
}
