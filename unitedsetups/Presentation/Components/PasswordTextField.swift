//
//  PasswordTextField.swift
//  unitedsetups
//
//  Created by Paras KCD on 6/10/24.
//

import SwiftUI

struct PasswordTextField: View {
    @State var passwordVisible: Bool = false
    @Binding var password: String
    var body: some View {
        HStack {
            if (passwordVisible) {
                TextField(
                    "",
                    text: $password,
                    prompt: Text("Password")
                        .foregroundStyle(.white.opacity(0.5))
                )
            } else {
                SecureField(
                    "Password",
                    text: $password,
                    prompt: Text("Password")
                        .foregroundStyle(.white.opacity(0.5))
                )
            }
            Button(action: { passwordVisible = !passwordVisible }) {
                if (passwordVisible) {
                    Image("Visibility")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                } else {
                    Image("VisibilityOff")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
            }
        }
        .padding()
        .background(Color("Background"))
        .cornerRadius(16)
    }
}
