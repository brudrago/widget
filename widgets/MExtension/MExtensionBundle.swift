//
//  MExtensionBundle.swift
//  MExtension
//
//  Created by Bruna Drago on 18/02/25.
//

import WidgetKit
import SwiftUI

@main
struct MExtensionBundle: WidgetBundle {
    var body: some Widget {
        MExtension()
        MExtensionControl()
        MExtensionLiveActivity()
    }
}
