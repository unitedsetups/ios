//
//  UserView.swift
//  unitedsetups
//
//  Created by Paras KCD on 7/10/24.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                Text("User")
            }
            .padding([.top, .horizontal], 16)
        }
        .frame(maxWidth: .infinity)
    }
}
