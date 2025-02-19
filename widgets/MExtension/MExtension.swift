//
//  MExtension.swift
//  MExtension
//
//  Created by Bruna Drago on 18/02/25.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> DayEntry {
        DayEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (DayEntry) -> ()) {
        let entry = DayEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [DayEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startOfDate = Calendar.current.startOfDay(for: entryDate)
            let entry = DayEntry(date: startOfDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct DayEntry: TimelineEntry {
    let date: Date
}

struct MExtensionEntryView : View {
    @Environment(\.showsWidgetContainerBackground) var showBackground
    var entry: DayEntry
    var config: MonthConfig
    
    init(entry: DayEntry) {
        self.entry = entry
        self.config = MonthConfig.makeConfig(from: entry.date)
    }
    

    var body: some View {
        VStack {
            HStack(spacing: 4) {
                Text(config.emojiText)
                    .font(.title)
                Text(entry.date.weekDayDisplayFormat)
                    .font(.title3)
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.6)
                    .foregroundStyle(showBackground ? config.weekdayTextColor : .white)
            }
            Text(entry.date.dayDisplayFormat)
                .font(.system(size: 80, weight: .heavy))
                .foregroundStyle(showBackground ? config.dayTextColor: .white)
        }.containerBackground(for: .widget) {
            ContainerRelativeShape()
                .fill(config.backgroundColor.gradient)
        }
    }
}


struct MExtension: Widget {
    let kind: String = "MExtension"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MExtensionEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                MExtensionEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Monthly Style widget")
        .description("The theme of the widget changes based on month")
        .supportedFamilies([.systemSmall])
    }
}

extension Date {
    var weekDayDisplayFormat: String {
        self.formatted(.dateTime.weekday(.wide))
    }
    
    var dayDisplayFormat: String {
        self.formatted(.dateTime.day())
    }
}

#Preview(as: .systemSmall) {
    MExtension()
   
} timeline: {
    DayEntry(date: .dateToDisplay(month: 03, day: 12))
    DayEntry(date: .dateToDisplay(month: 1, day: 24))
}

extension Date {
    static func dateToDisplay(month: Int, day: Int) -> Date {
        let components = DateComponents(calendar: Calendar.current, year: 2025, month: month, day: day)
        return Calendar.current.date(from: components)!
    }
}
