//
//  LoadingView.swift
//  StateGoverned
//
//  Created by m47145 on 23/12/2025.
//

import SwiftUI

struct LoadingView: View {
    
    let previousData: [Launch]?
    
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
            
            if let previousData {
                LaunchesListView(launches: previousData)
                    .opacity(0.4)
            }
        }
        .padding()
    }
}
