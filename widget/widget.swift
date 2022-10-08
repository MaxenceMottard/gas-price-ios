//
//  widget.swift
//  widget
//
//  Created by Maxence Mottard on 08/10/2022.
//

import WidgetKit
import SwiftUI
import Intents

struct CustomProvider: IntentTimelineProvider {
    private let dataRequest = DataRequest()

    func placeholder(in context: Context) -> WidgetEntry {
        .init(gasData: .preview)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (WidgetEntry) -> ()) {
        Task {
            if let data = await dataRequest.getGas() {
                completion(.init(gasData: data))
            }
        }
    }

    func getTimeline(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (Timeline<WidgetEntry>) -> Void
    ) {
        Task {
            if let nextRefresh = Calendar.current.date(byAdding: .minute, value: 5, to: Date()),
               let data = await dataRequest.getGas() {
                let timeline = Timeline(entries: [WidgetEntry(gasData: data)], policy: .after(nextRefresh))
                completion(timeline)
            }
        }
    }
}

struct WidgetEntry: TimelineEntry {
    let date: Date
    let gasData: GasData

    init(gasData: GasData) {
        self.date = Date()
        self.gasData = gasData
    }
}

struct widgetEntryView : View {
    var entry: CustomProvider.Entry

    private let size: CGFloat = 25

    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            GasPriceView(price: entry.gasData.gas.avg, icon: "ethereum")
            GasPriceView(price: entry.gasData.opensea.avg, icon: "opensea")
            GasPriceView(price: entry.gasData.uniswap.avg, icon: "uniswap")
            GasPriceView(price: entry.gasData.usdt.avg, icon: "usdt")
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

@main
struct widget: Widget {
    let kind: String = "ethgas"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: CustomProvider()) { entry in
            widgetEntryView(entry: entry)
        }
        .configurationDisplayName("Average Ethereum gas price")
        .description("Widget to find out the average price of gas on the Ethereum blockchain.")
        .supportedFamilies([.systemSmall])
    }
}

struct widget_Previews: PreviewProvider {
    static var previews: some View {
        widgetEntryView(entry: .init(gasData: .preview))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
