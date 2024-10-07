//
//  ExploreView.swift
//  unitedsetups
//
//  Created by Paras KCD on 7/10/24.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                Text("Explore")
            }
            .padding([.top, .horizontal], 16)
        }
        .frame(maxWidth: .infinity)
    }
}
