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
  var make: () throws -> ModelContext
}

extension ModelContextFactory: DependencyKey {
  static let liveValue: ModelContextFactory = {
    ModelContextFactory(
      make: {
        try makeModelContext(configuration: .init())
      }
    )
  }()
  
  static var testValue: ModelContextFactory {
    let modelContext = try! makeModelContext(configuration: .init(isStoredInMemoryOnly: true))
    return ModelContextFactory(
      make: {
        modelContext
      }
    )
  }
}

extension DependencyValues {
  var modelContextFactory: ModelContextFactory {
    get { self[ModelContextFactory.self] }
    set { self[ModelContextFactory.self] = newValue }
  }
}

private func makeModelContext(configuration: ModelConfiguration) throws -> ModelContext {
  try ModelContext(ModelContainer(
    for:
      Favorite.self
    ,
    configurations: configuration
  ))
}
