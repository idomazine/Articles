//
//  Date+Test.swift
//  ArticlesTests
//
//  Created by org on 2025/09/23.
//

import Foundation
import Foundation

extension Date {
  /// "yyyy/MM/dd HH:mm:ss"
  static func makeSample(_ string: String) -> Date {
    let formatter: DateFormatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .gregorian)
    formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
    formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
    return formatter.date(from: string)!
  }
}

final class DateMock {
  var date: Date!
  
  var dateProvider: () -> Date {
    { self.date }
  }
}
