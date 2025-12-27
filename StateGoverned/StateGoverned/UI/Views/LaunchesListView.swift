//
//  LaunchesListView.swift
//  StateGoverned
//
//  Created by m47145 on 23/12/2025.
//

import SwiftUI

struct LaunchesListView: View {
    let launches: [Launch]

    var body: some View {
        NavigationView { // 🔹 Aquí inicia la navegación
            List(launches, id: \.id) { launch in
                NavigationLink(destination: LaunchDetailView(launch: launch)) { // fila con link
                    LaunchRowView(launch: launch)
                }
            }
            .navigationTitle("SpaceX Launches") // título del nav bar
        }
    }
}

struct LaunchRowView: View {
    let launch: Launch
    
    var body: some View {
        HStack(spacing: 12) {
            if let url = launch.imageURL {
                CachedAsyncImageView(url: url)
                    .frame(height: 60)
            }


            
            VStack(alignment: .leading) {
                Text(launch.name).font(.headline)
                Text(launch.date.formattedForLaunch()).font(.caption).foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}
