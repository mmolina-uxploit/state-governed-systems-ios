//
//  LaunchesService.swift
//  StateGoverned
//
//  Created by m47145 on 23/12/2025.
//

import Foundation

final class SpaceXLaunchesService: LaunchesAPI {
    func fetchLaunches() async throws -> [SpaceXLaunchDTO] {
        let url = URL(string: "https://api.spacexdata.com/v4/launches")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([SpaceXLaunchDTO].self, from: data)
    }
}
