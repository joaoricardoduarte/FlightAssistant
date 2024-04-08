//
//  Endpoint.swift
//
//
//  Created by Joao Duarte on 03/04/2024.
//

import Foundation

public protocol Endpoint {
  var scheme: String { get }
  var host: String { get }
  var path: String { get }
  var method: RequestMethod { get }
  var headers: [String: String]? { get }
  var body: [String: String]? { get }
  var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {
  public var scheme: String {
    return "https"
  }
  
  public var queryItems: [URLQueryItem]? {
    return nil
  }
}
