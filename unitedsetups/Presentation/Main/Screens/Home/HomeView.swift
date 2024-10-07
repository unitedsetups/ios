//
//  HomeView.swift
//  unitedsetups
//
//  Created by Paras KCD on 7/10/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                Text("Home")
            }
            .padding([.top, .horizontal], 16)
        }
        .frame(maxWidth: .infinity)
    }
}
