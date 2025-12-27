//
//  LaunchMapper.swift
//  StateGoverned
//
//  Created by m47145 on 23/12/2025.
//

import Foundation

enum LaunchMapper {
    static func map(_ dto: SpaceXLaunchDTO) -> Launch {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let date = dto.dateUTC.flatMap { formatter.date(from: $0) } ?? .distantPast
        
        return Launch(
            id: UUID(uuidString: dto.id) ?? UUID(),
            flightNumber: dto.flightNumber ?? 0,
            name: dto.name,
            date: date,
            datePrecision: dto.datePrecision ?? "unknown",
            wasSuccessful: dto.success,
            details: dto.details,
            imageURL: dto.links?.patch?.large,
            webcastURL: dto.links?.webcast,
            articleURL: dto.links?.article,
            wikipediaURL: dto.links?.wikipedia
        )
    }
}


extension Date {
    func formattedForLaunch() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        return formatter.string(from: self)
    }
}
