//
//  NotificationsView.swift
//  unitedsetups
//
//  Created by Paras KCD on 7/10/24.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                Text("Notifications")
            }
            .padding([.top, .horizontal], 16)
        }
        .frame(maxWidth: .infinity)
    }
}
