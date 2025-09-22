//
//  CommentRepository.swift
//  Articles
//
//  Created by org on 2025/09/22.
//

import Foundation
import Dependencies
import SwiftData

struct CommentRepository {
  var getCommentByArticleId: (Int) throws -> [Comment]
  var addComment: (Comment) throws -> Void
}

extension CommentRepository: DependencyKey {
  static let liveValue: CommentRepository = {
    @Dependency(\.modelContextFactory.make) var makeModelContext
    
    return .init(
      getCommentByArticleId: { articleId in
        let context = try makeModelContext()
        var fetch = FetchDescriptor<Comment>(
          predicate: #Predicate { $0.articleId == articleId },
          sortBy: [.init(\.createdAt,
                          order: .reverse)]
        )
        return try context.fetch(fetch)
      },
      addComment: { comment in
        let context = try makeModelContext()
        
        let targetId = comment.articleId
        var fetch = FetchDescriptor<Comment>(
          predicate: #Predicate { $0.articleId == targetId }
        )
        fetch.fetchLimit = 1
        
        if let existing = try context.fetch(fetch).first {
          context.delete(existing)
        } else {
          context.insert(comment)
        }
        try context.save()
      }
    )
  }()
  
  static var testValue: CommentRepository { liveValue }
}

extension DependencyValues {
  var commentRepository: CommentRepository {
    get { self[CommentRepository.self] }
    set { self[CommentRepository.self] = newValue }
  }
}
