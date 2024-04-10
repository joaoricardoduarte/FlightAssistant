//
//  HomeViewModel.swift
//  FlightAssistant
//
//  Created by Joao Duarte on 04/04/2024.
//

import Foundation

class HomeViewModel: BaseViewModel<HomeViewStates>, @unchecked Sendable {
  
  // MARK: Stored Properties
  @Published private(set) var currentFlightStatus: FlightStatusModelAdaptor?
  @Published private(set) var historicFlightStatusArray: [FlightStatusModelAdaptor] = []
  
  private let service: FlightStatusServiceable
  var showingAlert: Bool
  let saveURLCodable: URL = .documentsDirectory.appending(component: "flightStatus").appendingPathExtension("json")
  
  //private unowned let coordinator: RecipeListCoordinator
  
  // MARK: Initialization
  init(service: FlightStatusServiceable = FlightStatusService()) {
    self.service = service
    self.showingAlert = false
    
    super.init()
    loadHistoricData()
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
          self.currentFlightStatus = FlightStatusModelAdaptor(flightStatusArray: flightStatus, timestamp: Date())
          self.addFlightStatusToHistoricData(flightStatus: self.currentFlightStatus)
        }
      case .failure(let failure):
        self.changeState(.error(error: failure.customMessage))
        self.showingAlert.toggle()
      }
    }
  }
  
  func addFlightStatusToHistoricData(flightStatus: FlightStatusModelAdaptor?) {
    guard let status = flightStatus else {
      return
    }
    
    historicFlightStatusArray.append(status)
    saveHistoricData()
  }
  
  
  // MARK: Methods
  
  //    func open(_ recipe: Recipe) {
  //        self.coordinator.open(recipe)
  //    }
  
  func loadHistoricData() {
    do {
      let data = try Data(contentsOf: saveURLCodable)
      historicFlightStatusArray = try JSONDecoder().decode([FlightStatusModelAdaptor].self, from: data)
      debugPrint("Retrieved: \(historicFlightStatusArray)")
    } catch {
      debugPrint(error.localizedDescription)
    }
  }
  
  func saveHistoricData() {
    do {
      let data = try JSONEncoder().encode(historicFlightStatusArray)
      try data.write(to: saveURLCodable)
      debugPrint("Saved.")
    } catch {
      debugPrint(error.localizedDescription)
    }
  }
}

enum HomeViewStates: ViewStateProtocol {
  case ready
  case loading
  case finished
  case error(error: String)
  case empty
}

extension HomeViewStates: Equatable {}
