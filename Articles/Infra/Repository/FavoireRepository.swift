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
  var getAll: () throws -> AsyncThrowingStream<[Favorite], Error>
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
          predicate: #Predicate { $0.articleId == id },
        )
        fetch.fetchLimit = 1
        
        return try context.fetch(fetch).first
      },
      getAll: {
        let context = try makeModelContext()
        return makeAsyncStream(for: context)
      },
      addFavorite: { favorite in
        let context = try makeModelContext()
        
        let targetId = favorite.articleId
        var fetch = FetchDescriptor<Favorite>(
          predicate: #Predicate { $0.articleId == targetId }
        )
        fetch.fetchLimit = 1
        
        if let existing = try context.fetch(fetch).first {
          context.delete(existing)
        } else {
          context.insert(favorite)
        }
        try context.save()
      },
      removeFavoriteById: { id in
        let context = try makeModelContext()
        
        var fetch = FetchDescriptor<Favorite>(
          predicate: #Predicate { $0.articleId == id }
        )
        fetch.fetchLimit = 1
        
        if let existing = try context.fetch(fetch).first {
          context.delete(existing)
        }
        try context.save()
      }
    )
  }()
  
  static var testValue: FavoireRepository { liveValue }
}

extension DependencyValues {
  var favoriteRepository: FavoireRepository {
    get { self[FavoireRepository.self] }
    set { self[FavoireRepository.self] = newValue }
  }
}

private func makeAsyncStream(for context: ModelContext) -> AsyncThrowingStream<[Favorite], Error> {
  AsyncThrowingStream<[Favorite], Error> { continuation in
    let token = NotificationCenter.default.addObserver(
      forName: ModelContext.didSave,
      object: context,
      queue: .main
    ) { _ in
      
      do {
        let favorites = try context.fetch(FetchDescriptor<Favorite>()).map { $0 }
        continuation.yield(favorites)
      } catch {
        continuation.finish(throwing: error)
      }
    }
    
    continuation.onTermination = { _ in
      NotificationCenter.default.removeObserver(token)
    }
  }
}
