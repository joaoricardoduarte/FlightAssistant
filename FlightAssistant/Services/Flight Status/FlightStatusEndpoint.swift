//
//  FlightStatusEndpoint.swift
//  FlightAssistant
//
//  Created by Joao Duarte on 03/04/2024.
//

import Foundation
import Network

enum FlightStatusEndpoint {
  case flightStatus(flightNumber: String)
}

extension FlightStatusEndpoint: Endpoint {
  var body: [String : String]? {
    return nil
  }
  
  var path: String {
    switch self {
    case .flightStatus(let flightNumber):
      return "/flights/number/\(flightNumber)"
    }
  }
  
  var host: String {
    return "aerodatabox.p.rapidapi.com"
  }
  
  var method: RequestMethod {
    return .get
  }
  
  var queryItems: [URLQueryItem]? {
    let queryParams = ["withAircraftImage": "false", "withLocation": "false"]
    return queryParams.map { URLQueryItem(name: $0, value: $1) }
  }
  
  var headers: [String: String]? {
    return ["X-RapidAPI-Key": "0eafe7757bmsha6828f88e151e68p17ec76jsndb8f43f4ee64",
            "X-RapidAPI-Host": "aerodatabox.p.rapidapi.com"]
  }
}
