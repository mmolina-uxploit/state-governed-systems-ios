//
//  LaunchDetailView.swift
//  StateGoverned
//
//  Created by m47145 on 23/12/2025.
//

import SwiftUI

struct LaunchDetailView: View {
    
    let launch: Launch
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Imagen principal
                if let url = launch.imageURL {
                    CachedAsyncImageView(url: url)
                        .frame(maxHeight: 250)
                        .cornerRadius(12)
                }

                
                // Nombre y número de vuelo
                Text(launch.name)
                    .font(.title)
                    .bold()
                
                Text("Flight #\(launch.flightNumber)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                // Fecha y precisión
                Text("Date: \(launch.date.formatted(date: .abbreviated, time: .shortened)) (\(launch.datePrecision))")
                    .font(.subheadline)
                
                // Estado del lanzamiento
                HStack {
                    Text("Status:")
                        .bold()
                    Text(launch.wasSuccessful == true ? "Success ✅" :
                         launch.wasSuccessful == false ? "Failure ❌" : "Unknown ⚠️")
                        .foregroundColor(statusColor)
                }
                
                // Detalles
                if let details = launch.details {
                    Text(details)
                        .font(.body)
                        .padding(.top, 4)
                }
                
                // Links
                VStack(alignment: .leading, spacing: 8) {
                    if let webcast = launch.webcastURL {
                        Link("Watch Webcast 🎥", destination: webcast)
                    }
                    if let article = launch.articleURL {
                        Link("Read Article 📰", destination: article)
                    }
                    if let wiki = launch.wikipediaURL {
                        Link("Wikipedia 📚", destination: wiki)
                    }
                }
                .font(.subheadline)
                .padding(.top, 8)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Launch Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var statusColor: Color {
        switch launch.wasSuccessful {
        case true: return .green
        case false: return .red
        default: return .orange
        }
    }
}
