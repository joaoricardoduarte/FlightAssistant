//
//  HomeViewModel.swift
//  FlightAssistant
//
//  Created by Joao Duarte on 04/04/2024.
//

import Foundation

class HomeViewModel: BaseViewModel<HomeViewStates>, @unchecked Sendable {
  
  // MARK: Stored Properties
  @Published private(set) var currentFlightStatus: FlightStatusResponseModel?
  
  private let service: FlightStatusServiceable
  var showingAlert: Bool
  //private unowned let coordinator: RecipeListCoordinator
  
  // MARK: Initialization
  init(service: FlightStatusServiceable = FlightStatusService()) {
    self.service = service
    self.showingAlert = false
  }
  
  func serviceInitialize(flightNo: String) {
    fetchFlightStatus(flightNo: flightNo)
  }
  
  func changeStateToEmpty() {
    currentFlightStatus = nil
      changeState(.empty)
  }
  
  func fetchFlightStatus (flightNo: String) {
    
    changeState(.loading)
    Task { [weak self] in
      guard let self = self else { return }
      
      let result = await self.service.fetchFlightStatus(flightNo: flightNo)
      self.changeState(.finished)
      
      switch result {
      case .success(let flightStatus):
        DispatchQueue.main.async {
          self.currentFlightStatus = flightStatus
        }
      case .failure(let failure):
        self.changeState(.error(error: failure.customMessage))
        self.showingAlert.toggle()
      }
    }
  }
  
  // MARK: Methods
  
  //    func open(_ recipe: Recipe) {
  //        self.coordinator.open(recipe)
  //    }
}

enum HomeViewStates: ViewStateProtocol {
    case ready
    case loading
    case finished
    case error(error: String)
    case empty
}

extension HomeViewStates: Equatable {}
