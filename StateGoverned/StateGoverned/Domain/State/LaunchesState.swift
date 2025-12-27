//
//  LaunchesState.swift
//  StateGoverned
//
//  Created by m47145 on 23/12/2025.
//

import Foundation

enum LaunchesState: Equatable {
    case idle
    case loading(previousData: [Launch]?, activeRocketFilter: String? = nil)
    case loaded([Launch], activeRocketFilter: String? = nil)
    case failed(failure: LoadFailure, recoverability: Recoverability, activeRocketFilter: String? = nil)
    
    static var initial: LaunchesState {
        .idle
    }
}





