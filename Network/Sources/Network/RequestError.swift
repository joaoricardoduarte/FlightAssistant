//
//  RequestError.swift
//
//
//  Created by Joao Duarte on 03/04/2024.
//

import Foundation

public enum RequestError: Error {
  case decode
  case invalidURL
  case noResponse
  case unauthorized
  case unexpectedStatusCode
  case unknown
  case badImage
  
  public var customMessage: String {
    switch self {
    case .decode:
      return "Decode error"
    case .unauthorized:
      return "Session expired"
    case .badImage:
      return "Bad Image"
    default:
      return "Unknown error"
    }
  }
}
