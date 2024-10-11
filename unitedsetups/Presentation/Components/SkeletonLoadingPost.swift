//
//  SkeletonLoadingPost.swift
//  unitedsetups
//
//  Created by Paras KCD on 12/10/24.
//

import SwiftUI

struct SkeletonLoadingPost: View {
    let color = Color("Background")

    var body: some View {
        VStack {
            HStack {
                color
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                color
                    .frame(width: 64, height: 8)
                Spacer()
                color
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
            }
            HStack {
                color
                    .frame(width: 16, height: 8)
                Spacer()
            }
            color.frame(height: 256).cornerRadius(16).padding(.vertical, 16)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("Surface"))
        .cornerRadius(16)
        .padding(8)
        .shadow(radius: 16)
    }
}
