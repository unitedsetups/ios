//
//  TextField.swift
//  unitedsetups
//
//  Created by Paras KCD on 6/10/24.
//

import SwiftUI

struct NormalTextField: View {
    @Binding var binding: String
    var promptText: String
    var icon: String
    
    var body: some View {
        HStack {
            TextField(
                "",
                text: $binding,
                prompt: Text(promptText)
                    .foregroundColor(.white.opacity(0.5))
            )
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .foregroundColor(.white)
            
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
        }
        .padding()
        .background(Color("Background"))
        .cornerRadius(16)
    }
}
