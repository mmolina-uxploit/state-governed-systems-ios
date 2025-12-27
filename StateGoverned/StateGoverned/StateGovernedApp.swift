//
//  StateGovernedApp.swift
//  StateGoverned
//
//  Created by m47145 on 23/12/2025.
//

import SwiftUI

@main
struct StateGovernedApp: App {

    @StateObject private var store = LaunchesStore(service: SpaceXLaunchesService())

    var body: some Scene {
        WindowGroup {
            LaunchesScreen(store: store)
        }
    }
}
