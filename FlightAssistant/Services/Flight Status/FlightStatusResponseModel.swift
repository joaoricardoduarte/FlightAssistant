//
//  FlightStatusResponseModel.swift
//  FlightAssistant
//
//  Created by Joao Duarte on 03/04/2024.
//

import Foundation

struct FlightStatusResponseModelElement: Codable {
  let greatCircleDistance: GreatCircleDistance
  let departure, arrival: Arrival
  let lastUpdatedUTC, number, status, codeshareStatus: String
  let isCargo: Bool
  let aircraft: Aircraft
  let airline: Airline
  
  enum CodingKeys: String, CodingKey {
    case greatCircleDistance, departure, arrival
    case lastUpdatedUTC = "lastUpdatedUtc"
    case number, status, codeshareStatus, isCargo, aircraft, airline
  }
}

struct Aircraft: Codable {
  let model: String
}

struct Airline: Codable {
  let name, iata, icao: String
}

struct Arrival: Codable {
  let airport: Airport
  let scheduledTime: EdTime
  let terminal: String
  let quality: [String]
  let revisedTime: EdTime?
}

struct Airport: Codable {
  let icao, iata, name, shortName: String
  let municipalityName: String
  let location: Location
  let countryCode: String
}

struct Location: Codable {
  let lat, lon: Double
}

struct EdTime: Codable {
  let utc, local: String
}

struct GreatCircleDistance: Codable {
  let meter, km, mile, nm: Double
  let feet: Double
}

typealias FlightStatusResponseModel = [FlightStatusResponseModelElement]
