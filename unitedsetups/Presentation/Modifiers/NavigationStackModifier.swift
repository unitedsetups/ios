//
//  NavigationStackModifier.swift
//  unitedsetups
//
//  Created by Paras KCD on 7/10/24.
//

import SwiftUI

struct NavigationStackModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Image("USLogoWhite")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 48)
                    }
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color("Surface"), for: .navigationBar)
    }
}

extension View {
    func NavigationStackStyle() -> some View {
        modifier(NavigationStackModifier())
    }
}
