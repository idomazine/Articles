//
//  ModelContextFactory.swift
//  Articles
//
//  Created by org on 2025/09/15.
//

import Foundation
import Dependencies
import SwiftData

struct ModelContextFactory {
  var make: () throws -> ModelContext = {
    try ModelContext(ModelContainer(
      for:
        Favorite.self
      ,
      configurations: .init()
    ))
  }
}

extension ModelContextFactory: DependencyKey {
  static let liveValue = ModelContextFactory()
  
  static var testValue: ModelContextFactory { liveValue }
}

extension DependencyValues {
  var modelContextFactory: ModelContextFactory {
    get { self[ModelContextFactory.self] }
    set { self[ModelContextFactory.self] = newValue }
  }
}
