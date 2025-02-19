//
//  MExtensionLiveActivity.swift
//  MExtension
//
//  Created by Bruna Drago on 18/02/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct MExtensionAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct MExtensionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MExtensionAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension MExtensionAttributes {
    fileprivate static var preview: MExtensionAttributes {
        MExtensionAttributes(name: "World")
    }
}

extension MExtensionAttributes.ContentState {
    fileprivate static var smiley: MExtensionAttributes.ContentState {
        MExtensionAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: MExtensionAttributes.ContentState {
         MExtensionAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: MExtensionAttributes.preview) {
   MExtensionLiveActivity()
} contentStates: {
    MExtensionAttributes.ContentState.smiley
    MExtensionAttributes.ContentState.starEyes
}
