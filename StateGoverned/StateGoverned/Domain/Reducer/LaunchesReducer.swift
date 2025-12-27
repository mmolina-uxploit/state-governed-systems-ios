//
//  LaunchesReducer.swift
//  StateGoverned
//
//  Created by m47145 on 23/12/2025.
//

import Foundation

enum LaunchesReducer {

    static func reduce(state: LaunchesState, event: LaunchesEvent) -> LaunchesState {

        switch (state, event) {

        case (.idle, .onAppear):
            return .loading(previousData: nil, activeRocketFilter: nil)

        case (.loading(_, let filter), .dataReceived(let launches)):
            if let filter = filter {
                let filteredLaunches = launches.filter { $0.rocket == filter }
                return .loaded(filteredLaunches, activeRocketFilter: filter)
            }
            return .loaded(launches, activeRocketFilter: nil)

        case (.loading(_, let filter), .failureReceived(let failure)):
            return .failed(
                failure: failure,
                recoverability: mapRecoverability(from: failure),
                activeRocketFilter: filter
            )

        case (.failed(_, let recoverability, let filter), .retry(let previousData)) where recoverability == .retryable:
            return .loading(previousData: previousData, activeRocketFilter: filter)
            
        case (.loaded(let launches, _), .setRocketFilter(let filter)):
            return .loading(previousData: launches, activeRocketFilter: filter)

        default:
            return state
        }
    }

    private static func mapRecoverability(from failure: LoadFailure) -> Recoverability {
        switch failure {
        case .network, .decoding:
            return .retryable
        case .unauthorized:
            return .terminal
        }
    }
}
