//
//  FlightStatusResponseModel.swift
//  FlightAssistant
//
//  Created by Joao Duarte on 03/04/2024.
//

import Foundation
import SwiftUI

struct FlightStatusResponseModelElement: Codable {
  //var id = UUID()
  let greatCircleDistance: GreatCircleDistance
  let departure, arrival: Arrival
  let number, lastUpdatedUTC, status, codeshareStatus: String
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
  //var id = UUID()
  let model: String
  let image: PlaneImage
  
  enum CodingKeys: String, CodingKey {
    case model, image
  }
}

class PlaneImage: Codable {
  //var id = UUID()
  @State var url: String
  let webURL: String
  let author, myTitle, myDescription, license: String
  let htmlAttributions: [String]
  
  enum CodingKeys: String, CodingKey {
    case url
    case webURL = "webUrl"
    case myTitle = "title"
    case myDescription = "description"
    case author, license, htmlAttributions
  }
  
  required init(from decoder:Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      url = try values.decode(String.self, forKey: .url)
    
    webURL = try values.decode(String.self, forKey: .webURL)
    author = try values.decode(String.self, forKey: .author)
    myTitle = try values.decode(String.self, forKey: .myTitle)
    myDescription = try values.decode(String.self, forKey: .myDescription)
    license = try values.decode(String.self, forKey: .license)
    htmlAttributions = try values.decode([String].self, forKey: .htmlAttributions)
      
  }
  
  
  public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(url, forKey: .url)
      try container.encode(webURL, forKey: .webURL)
      try container.encode(author, forKey: .author)
      try container.encode(myTitle, forKey: .myTitle)
      try container.encode(myDescription, forKey: .myDescription)
      try container.encode(license, forKey: .license)
      try container.encode(htmlAttributions, forKey: .htmlAttributions)
  }
}

struct Airline: Codable {
  //var id = UUID()
  let name, iata, icao: String
}

struct Arrival: Codable {
  //var id = UUID()
  let airport: Airport
  let scheduledTime: EdTime
  let terminal: String
  let quality: [String]
  let revisedTime: EdTime?
  
  enum CodingKeys: String, CodingKey {
    case airport
    case scheduledTime
    case terminal
    case quality
    case revisedTime
    
  }
}

struct Airport: Codable {
  //var id = UUID()
  let icao, iata, name, shortName: String
  let municipalityName: String
  let location: Location
  let countryCode: String
  
  enum CodingKeys: String, CodingKey {
    case icao, iata, name, shortName
    case municipalityName
    case location
    case countryCode
    
  }
}

struct Location: Codable {
  //var id = UUID()
  let lat, lon: Double
  
  enum CodingKeys: String, CodingKey {
    case lat, lon
    
  }
}

struct EdTime: Codable {
  //var id = UUID()
  let utc, local: String
  
  enum CodingKeys: String, CodingKey {
    case utc, local
    
  }
}

struct GreatCircleDistance: Codable {
  //var id = UUID()
  let meter, km, mile, nm: Double
  let feet: Double
}

typealias FlightStatusResponseModel = [FlightStatusResponseModelElement]

struct FlightStatusModelAdaptor: Codable {
  //var id = UUID()
  var flightStatusArray: FlightStatusResponseModel
  let timestamp: Date?
//  let aircraftURL: URL?
  
  enum CodingKeys: String, CodingKey {
    case flightStatusArray
    case timestamp
//    case aircraftURL
  }
}
