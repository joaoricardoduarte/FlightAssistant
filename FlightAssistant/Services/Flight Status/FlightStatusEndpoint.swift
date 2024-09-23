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
    let queryParams = ["withAircraftImage": "true", "withLocation": "false"]
    return queryParams.map { URLQueryItem(name: $0, value: $1) }
  }
  
  var headers: [String: String]? {
    let key = "\("vovihwey876v87ew6bvwe786v87we6vbe")\("98687vwe67nv986wev875wbe687vnew")"
    let apiKey = CryptoUtils.decode("ZKDEdyuFJ6DVwt1woWWLsGSGEtbu4YzjZIxoE8FojvIx+erExrY+n4Z3+yLzkveY10Vgm2XHLA1IhS2MsYPs0Ii7JQxcBwIRntJCIfjL", withKey: key) ?? ""
    let apiHost = CryptoUtils.decode("cEVtzEA2rihrXjd2LCjbccVT0SpFJBvghUIbvBO1zl4Van6JgIZMCQoBZP52k4boF9EQJmui", withKey: key) ?? ""
    
    return ["X-RapidAPI-Key": apiKey,
            "X-RapidAPI-Host": apiHost,
            "Accept": "application/json",
            "Content-Type": "application/json",
            "x-rapidapi-ua": "RapidAPI-Playground"]
  }
}
