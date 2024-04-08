//
//  FlightAssistantApp.swift
//  FlightAssistant
//
//  Created by Joao Duarte on 13/02/2024.
//

import SwiftUI

@main
struct FlightAssistantApp: App {
  
  // MARK: Stored Properties
  @StateObject var coordinator = HomeCoordinator()
  
  var body: some Scene {
    WindowGroup {
      HomeView(coordinator: coordinator)
    }
  }
}
