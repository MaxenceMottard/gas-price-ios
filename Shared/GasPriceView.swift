//
//  GasPriceView.swift
//  ETH Gas
//
//  Created by Maxence Mottard on 09/10/2022.
//

import SwiftUI

struct GasPriceView: View {
    let price: String
    let icon: String?

    init(price: String, icon: String? = nil) {
        self.price = price
        self.icon = icon
    }

    private let size: CGFloat = 25

    var body: some View {
        HStack {
            if let icon = icon {
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size, height: size)
            }

            Text(price).bold()
        }
    }
}
