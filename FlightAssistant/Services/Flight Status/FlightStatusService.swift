//
//  FlightStatusService.swift
//  FlightAssistant
//
//  Created by Joao Duarte on 03/04/2024.
//

import Foundation
import Network

protocol FlightStatusServiceable {
  func fetchFlightStatus(flightNo: String) async -> Result<FlightStatusResponseModel, RequestError>
}

struct FlightStatusService: HTTPClient, FlightStatusServiceable {
  func fetchFlightStatus(flightNo: String) async -> Result<FlightStatusResponseModel, RequestError> {
    return await sendRequest(endpoint: FlightStatusEndpoint.flightStatus(flightNumber: flightNo), responseModel: FlightStatusResponseModel.self)
  }
}
