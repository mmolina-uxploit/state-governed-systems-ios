//
//  LoadFailure.swift
//  StateGoverned
//
//  Created by m47145 on 23/12/2025.
//

import Foundation

enum LoadFailure: Equatable {
    case network
    case decoding
    case unauthorized
}
