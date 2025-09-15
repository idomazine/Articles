//
//  FavoireRepository.swift
//  Articles
//
//  Created by org on 2025/09/15.
//

import Foundation
import Dependencies
import SwiftData

struct FavoireRepository {
  var getFavoriteById: (Int) throws -> Favorite?
  var addFavorite: (Favorite) throws -> Void
  var removeFavoriteById: (Int) throws -> Void
}

extension FavoireRepository: DependencyKey {
  static let liveValue: FavoireRepository = {
    @Dependency(\.modelContextFactory.make) var makeModelContext
    
    return .init(
      getFavoriteById: { id in
        let context = try makeModelContext()
        var fetch = FetchDescriptor<Favorite>(
          predicate: #Predicate { $0.id == id },
        )
        fetch.fetchLimit = 1
        
        return try context.fetch(fetch).first
      },
      addFavorite: { favorite in
        let context = try makeModelContext()
        
        var fetch = FetchDescriptor<Favorite>(
          predicate: #Predicate { $0.id == favorite.id },
        )
        fetch.fetchLimit = 1
        
        if let existing = try context.fetch(fetch).first {
          context.delete(existing)
        } else {
          context.insert(favorite)
        }
      },
      removeFavoriteById: { id in
        let context = try makeModelContext()
        
        var fetch = FetchDescriptor<Favorite>(
          predicate: #Predicate { $0.id == id },
        )
        fetch.fetchLimit = 1
        
        if let existing = try context.fetch(fetch).first {
          context.delete(existing)
        }
      }
    )
  }()
  
  static var testValue: FavoireRepository { liveValue }
}

extension DependencyValues {
  var favoireRepository: FavoireRepository {
    get { self[FavoireRepository.self] }
    set { self[FavoireRepository.self] = newValue }
  }
}
