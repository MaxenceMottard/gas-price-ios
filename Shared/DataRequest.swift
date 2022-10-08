//
//  DataRequest.swift
//  ETH Gas
//
//  Created by Maxence Mottard on 08/10/2022.
//

import Foundation
import RetroSwift
import WidgetKit

class DataRequest {
    @Network<GasData>(url: "https://gasprice.maxencemottard.dev/gas/price", method: .GET)
    private var fetchData

    func getGas() async -> GasData? {
        try? await fetchData().throwable
    }
}

struct GasData: Decodable {
    let gas: Prices
    let opensea: Prices
    let uniswap: Prices
    let usdt: Prices

    struct Prices: Decodable {
        let low: String
        let avg: String
        let high: String
    }
}

extension GasData {
    static var preview: GasData {
        .init(
            gas: .init(low: "25 gwei", avg: "30 gwei", high: "35 gwei"),
            opensea: .init(low: "$1.50", avg: "$1.50", high: "$1.50"),
            uniswap: .init(low: "$1.50", avg: "$1.50", high: "$1.50"),
            usdt: .init(low: "$1.50", avg: "$1.50", high: "$1.50")
        )
    }
}
