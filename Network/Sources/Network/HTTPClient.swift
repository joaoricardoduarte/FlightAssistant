//
//  HTTPClient.swift
//
//
//  Created by Joao Duarte on 03/04/2024.
//

import Foundation

public protocol HTTPClient {
  func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type, urlSession: URLSession?) async -> Result<T, RequestError>
}

public extension HTTPClient {
  func sendRequest<T: Decodable>(
    endpoint: Endpoint,
    responseModel: T.Type,
    urlSession: URLSession? = nil
  ) async -> Result<T, RequestError> {
    var urlComponents = URLComponents()
    urlComponents.scheme = endpoint.scheme
    urlComponents.host = endpoint.host
    urlComponents.path = endpoint.path
    urlComponents.queryItems = endpoint.queryItems
    
    guard let url = urlComponents.url else {
      return .failure(.invalidURL)
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = endpoint.method.rawValue
    request.allHTTPHeaderFields = endpoint.headers
    
    if let body = endpoint.body {
      request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
    }
    
    do {
      var dataAndResponse: (Data, URLResponse)?
      
      if let session = urlSession {
        dataAndResponse = try await session.data(for: request)
      } else {
        dataAndResponse = try await URLSession.shared.data(for: request, delegate: nil)
      }
      
      guard let response = dataAndResponse?.1 as? HTTPURLResponse else {
        return .failure(.noResponse)
      }
      switch response.statusCode {
      case 200...299:
        guard let data = dataAndResponse?.0 else {
          return .failure(.unknown)
        }
        
        do {
          let decodedResponse = try JSONDecoder().decode(responseModel, from: data)
          return .success(decodedResponse)
        } catch let error as DecodingError {
          print(error)
          return .failure(.decode)
        }
        
      case 401:
        return .failure(.unauthorized)
      default:
        return .failure(.unexpectedStatusCode)
      }
    } catch {
      return .failure(.unknown)
    }
  }
}
