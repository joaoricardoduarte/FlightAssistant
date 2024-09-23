//
//  DateUtils.swift
//  FlightAssistant
//
//  Created by Joao Duarte on 10/04/2024.
//

import Foundation

extension Date {
  static func dateFromISOString(_ isoString: String) -> Date? {
    let isoDateFormatter = ISO8601DateFormatter()
    isoDateFormatter.formatOptions = [.withFullDate]  // ignores time!
    return isoDateFormatter.date(from: isoString)  // returns nil, if isoString is malformed.
  }
}
