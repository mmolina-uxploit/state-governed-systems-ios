//
//  LaunchesReducerTests.swift
//  StateGovernedTests
//
//  Created by m47145 on 23/12/2025.
//

import XCTest
@testable import StateGoverned

final class LaunchesReducerTests: XCTestCase {

    func test_initialState_isIdle() {
        // Given
        let initialState = LaunchesState.initial
        
        // Then
        XCTAssertEqual(initialState, .idle)
    }
    
    func test_onAppear_fromIdle_transitionsToLoading() {
        // Given
        let state = LaunchesState.idle
        let event = LaunchesEvent.onAppear
        
        // When
        let newState = LaunchesReducer.reduce(state: state, event: event)
        
        // Then
        XCTAssertEqual(newState, .loading(previousData: nil, activeRocketFilter: nil))
    }

    func test_dataReceived_fromLoading_transitionsToLoaded() {
        // Given
        let launches = [createLaunch(), createLaunch()]
        let state = LaunchesState.loading(previousData: nil, activeRocketFilter: nil)
        let event = LaunchesEvent.dataReceived(launches)
        
        // When
        let newState = LaunchesReducer.reduce(state: state, event: event)
         
        // Then
        XCTAssertEqual(newState, .loaded(launches, activeRocketFilter: nil))
    }
    
    func test_recoverableFailure_fromLoading_transitionsToFailed() {
        // Given
        let failure = LoadFailure.network
        let state = LaunchesState.loading(previousData: nil, activeRocketFilter: "filter")
        
        // When
        let newState = LaunchesReducer.reduce(state: state, event: .failureReceived(failure))
        
        // Then
        XCTAssertEqual(newState, .failed(failure: failure, recoverability: .retryable, activeRocketFilter: "filter"))
    }
    
    func test_retry_fromRecoverableFailure_transitionsToLoading_withPreviousData() {
        // Given
        let previousLaunches = [createLaunch()]
        let state = LaunchesState.failed(failure: .network, recoverability: .retryable, activeRocketFilter: "filter")
        
        // When
        let newState = LaunchesReducer.reduce(state: state, event: .retry(previousData: previousLaunches))
        
        // Then
        XCTAssertEqual(newState, .loading(previousData: previousLaunches, activeRocketFilter: "filter"))
    }
    
    func test_retry_fromTerminalFailure_doesNothing() {
        // Given
        let state = LaunchesState.failed(failure: .unauthorized, recoverability: .terminal, activeRocketFilter: "filter")
        
        // When
        let newState = LaunchesReducer.reduce(state: state, event: .retry(previousData: nil))
        
        // Then
        XCTAssertEqual(newState, state)
    }
    
    // MARK: - TDD: Filtering
    
    func test_dataReceived_withActiveFilter_onlyStoresFilteredLaunches() {
        // Given
        let allLaunches = [
            createLaunch(rocket: "falcon9"),
            createLaunch(rocket: "falconheavy")
        ]
        let state = LaunchesState.loading(previousData: nil, activeRocketFilter: "falcon9")
        
        // When
        let event = LaunchesEvent.dataReceived(allLaunches)
        let newState = LaunchesReducer.reduce(state: state, event: event)
        
        // Then
        guard case let .loaded(storedLaunches, filter) = newState else {
            XCTFail("The state should be .loaded")
            return
        }
        XCTAssertEqual(storedLaunches.count, 1)
        XCTAssertEqual(storedLaunches.first?.rocket, "falcon9")
        XCTAssertEqual(filter, "falcon9")
    }
    
    func test_setRocketFilter_updatesStateAndReloadsData() {
        // Given
        let launches = [createLaunch(rocket: "falcon9")]
        let state = LaunchesState.loaded(launches, activeRocketFilter: nil)
        let event = LaunchesEvent.setRocketFilter("falcon9")
        
        // When
        let newState = LaunchesReducer.reduce(state: state, event: event)
        
        // Then
        guard case let .loading(previousData, filter) = newState else {
            XCTFail("The state should be .loading")
            return
        }
        XCTAssertEqual(previousData, launches)
        XCTAssertEqual(filter, "falcon9")
    }
    
    // MARK: - Helper
    
    private func createLaunch(
        id: UUID = UUID(),
        flightNumber: Int = 1,
        name: String = "Test Launch",
        date: Date = Date(),
        datePrecision: String = "day",
        wasSuccessful: Bool? = true,
        details: String? = "Details",
        imageURL: URL? = URL(string: "https://example.com/image.png"),
        webcastURL: URL? = URL(string: "https://example.com/webcast"),
        articleURL: URL? = URL(string: "https://example.com/article"),
        wikipediaURL: URL? = URL(string: "https://en.wikipedia.org/wiki/Test"),
        rocket: String? = "falcon9",
        cores: [Core] = [],
        payloads: [String] = [],
        fairings: Fairings? = nil,
        failures: [Failure] = []
    ) -> Launch {
        Launch(
            id: id,
            flightNumber: flightNumber,
            name: name,
            date: date,
            datePrecision: datePrecision,
            wasSuccessful: wasSuccessful,
            details: details,
            imageURL: imageURL,
            webcastURL: webcastURL,
            articleURL: articleURL,
            wikipediaURL: wikipediaURL,
            rocket: rocket,
            cores: cores,
            payloads: payloads,
            fairings: fairings,
            failures: failures
        )
    }
}
