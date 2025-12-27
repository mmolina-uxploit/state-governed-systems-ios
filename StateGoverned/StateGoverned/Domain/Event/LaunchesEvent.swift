//
//  LaunchesEvent.swift
//  StateGoverned
//
//  Created by m47145 on 23/12/2025.
//

import Foundation

enum LaunchesEvent {
    case onAppear
    case dataReceived([Launch])
    case failureReceived(LoadFailure)
    case retry(previousData: [Launch]?)
    case setRocketFilter(String?)
}


