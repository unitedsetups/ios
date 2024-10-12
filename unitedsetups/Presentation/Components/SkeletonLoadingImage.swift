//
//  SkeletonLoadingImage.swift
//  unitedsetups
//
//  Created by Paras KCD on 12/10/24.
//

import SwiftUI

struct SkeletonLoadingImage: View {
    let color = Color("Background")

    var body: some View {
        color
            .frame(width: 300, height: 256)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
