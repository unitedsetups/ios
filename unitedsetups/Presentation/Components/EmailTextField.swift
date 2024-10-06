//
//  EmailTextField.swift
//  unitedsetups
//
//  Created by Paras KCD on 6/10/24.
//

import SwiftUI

struct EmailTextField: View {
    @Binding var email: String
    
    var body: some View {
        HStack {
            TextField(
                "",
                text: $email,
                prompt: Text("Email Address")
                    .foregroundStyle(.white.opacity(0.5))
            )
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .foregroundStyle(.white)
            
            Image("Mail")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
        }
        .padding()
        .background(Color("Background"))
        .cornerRadius(16)
    }
}
