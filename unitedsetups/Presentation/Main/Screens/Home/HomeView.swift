//
//  HomeView.swift
//  unitedsetups
//
//  Created by Paras KCD on 7/10/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                LazyVStack {
                    Text("Home")
                }
                .padding([.top, .horizontal], 16)
            }
            .frame(maxWidth: .infinity)
            NavigationLink(destination: PostView()) {
                Image("EditNote")
                    .renderingMode(.template)
                    .padding()
                    .background(.accent)
                    .foregroundStyle(.black)
                    .clipShape(Circle())
                    .padding()
            }
        }
        .frame(maxWidth: .infinity)
    }
}
