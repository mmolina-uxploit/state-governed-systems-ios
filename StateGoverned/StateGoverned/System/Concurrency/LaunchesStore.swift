//
//  LaunchesStore.swift
//  StateGoverned
//
//  Created by m47145 on 23/12/2025.
//
import Foundation

@MainActor
final class LaunchesStore: ObservableObject {
    
    @Published private(set) var state: LaunchesState
    
    private let reducer: (LaunchesState, LaunchesEvent) -> LaunchesState
    private let service: LaunchesAPI
    private var task: Task<Void, Never>?
    
    init(
        initialState: LaunchesState = .initial,
        service: LaunchesAPI,
        reducer: @escaping (LaunchesState, LaunchesEvent) -> LaunchesState = LaunchesReducer.reduce
    ) {
        self.state = initialState
        self.service = service
        self.reducer = reducer
    }
    
    func send(_ event: LaunchesEvent) {
        state = reducer(state, event)
    }
    
    func loadLaunches() {
        task?.cancel()
        
        task = Task {
            send(.onAppear)
            do {
                let url = URL(string: "https://api.spacexdata.com/v4/launches")!
                let (data, _) = try await URLSession.shared.data(from: url)
                print("✅ Bytes recibidos: \(data.count)")
                
                let dtos = try JSONDecoder().decode([SpaceXLaunchDTO].self, from: data)
                let launches = dtos.map(LaunchMapper.map)
                send(.dataReceived(launches))
            } catch {
                print("❌ Error: \(error)")
                send(.failureReceived(.network))
            }
        }

    }
    
    func cancel() {
        task?.cancel()
        task = nil
    }
}
