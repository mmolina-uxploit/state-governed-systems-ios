//
//  LaunchesAPI.swift
//  StateGoverned
//
//  Created by m47145 on 23/12/2025.
//

import Foundation

protocol LaunchesAPI {
    func fetchLaunches() async throws -> [SpaceXLaunchDTO]
}
