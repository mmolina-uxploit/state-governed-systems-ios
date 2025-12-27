//
//  LaunchesScreen.swift
//  StateGoverned
//
//  Created by m47145 on 23/12/2025.
//

import SwiftUI

struct LaunchesScreen: View {
    
    @StateObject private var store: LaunchesStore
    
    init(store: LaunchesStore) {
        _store = StateObject(wrappedValue: store)
    }
    
    private var viewState: LaunchesViewState {
        LaunchesViewState(from: store.state)
    }
    
    var body: some View {
        content
            .onAppear {
                store.loadLaunches()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewState {
        case .idle:
            EmptyView()
        case .loading(let previousData):
            LoadingView(previousData: previousData)
        case .content(let launches):
            LaunchesListView(launches: launches)
        case .error(let message, let canRetry, let previousData):
            ErrorView(
                message: message,
                canRetry: canRetry,
                previousData: previousData,
                onRetry: {
                    store.loadLaunches()
                }
            )
        }
    }
}
