//
//  LaunchesViewState.swift
//  StateGoverned
//
//  Created by m47145 on 23/12/2025.
//

import Foundation

enum LaunchesViewState: Equatable {
    case idle
    case loading(previousData: [Launch]?)
    case content([Launch])
    case error(
        message: String,
        canRetry: Bool,
        previousData: [Launch]?
    )
    
    init(from state: LaunchesState) {
        
        switch state {
            
        case .idle:
            self = .idle
            
        case .loading(let previousData, _):
            self = .loading(previousData: previousData)
            
        case .loaded(let launches, _):
            self = .content(launches)
            
        case .failed(let failure, let recoverability, _):
            self = .error(
                message: LaunchesViewState.message(for: failure),
                canRetry: recoverability == .retryable,
                previousData: nil
            )

        
        }
    }
    
    private static func message(for failure: LoadFailure) -> String {
        
        switch failure {
            
        case .network:
            return "Problema de red"
        
        case .decoding:
            return "Error procesando datos"
        
        case .unauthorized:
            return "No autorizado"
            
        }
        
    }
    
}
