//
//  ContentView.swift
//  ETH Gas
//
//  Created by Maxence Mottard on 08/10/2022.
//

import SwiftUI

struct ContentView: View {
    private let dataRequest = DataRequest()

    @State var gasData: GasData?

    var body: some View {
        NavigationView {
            VStack {
                if let data = gasData {
                    List {
                        GasDetailedPricesView(title: "GWEI", icon: "ethereum", prices: data.gas)
                        GasDetailedPricesView(title: "OpenSea: Sale", icon: "opensea", prices: data.opensea)
                        GasDetailedPricesView(title: "Uniswap V3: Swap", icon: "uniswap", prices: data.uniswap)
                        GasDetailedPricesView(title: "USDT: Transfer", icon: "usdt", prices: data.usdt)
                    }
                    .listStyle(.plain)
                } else {
                    Color.clear
                }
            }
            .navigationTitle("Ethereum gas tracker")
        }
        .onAppear {
            Task {
                gasData = await dataRequest.getGas()
            }
        }
    }
}

struct GasDetailedPricesView: View {
    let title: String
    let icon: String
    let prices: GasData.Prices

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)

                Text(title)
            }

            Group {
                HStack(spacing: 0) {
                    Text("Low: ")
                    GasPriceView(price: prices.low)
                }

                HStack(spacing: 0) {
                    Text("Average: ")
                    GasPriceView(price: prices.avg)
                }

                HStack(spacing: 0) {
                    Text("High: ")
                    GasPriceView(price: prices.high)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let view = ContentView()
        view.gasData = .preview

        return view
    }
}
