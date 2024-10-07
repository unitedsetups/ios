//
//  TabModifier.swift
//  unitedsetups
//
//  Created by Paras KCD on 7/10/24.
//

import SwiftUI

struct TabModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color("Surface"), for: .tabBar)
            .background(Color("Background"))
            .foregroundStyle(.white)
    }
}

extension View {
    func TabStyle() -> some View {
        modifier(TabModifier())
    }
}
