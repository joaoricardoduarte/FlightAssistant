//
//  RequestMethod.swift
//
//
//  Created by Joao Duarte on 03/04/2024.
//

import Foundation

public enum RequestMethod: String {
  case delete = "DELETE"
  case get = "GET"
  case patch = "PATCH"
  case post = "POST"
  case put = "PUT"
}

enum DataType {
  case image
  case json
}
