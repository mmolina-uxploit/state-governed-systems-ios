//
//  ErrorView.swift
//  StateGoverned
//
//  Created by m47145 on 23/12/2025.
//

import SwiftUI

struct ErrorView: View {
    
    let message: String
    let canRetry: Bool
    let previousData: [Launch]?
    let onRetry: () -> Void

    var body: some View {
        
        VStack(spacing: 16) {
            
            Text(message)
                .multilineTextAlignment(.center)
            
            if canRetry {
                Button("Reintentar", action: onRetry)
            }
            
            if let previousData {
                LaunchesListView(launches: previousData)
                    .opacity(0.4)
            }
        }
        .padding()
    }
}
