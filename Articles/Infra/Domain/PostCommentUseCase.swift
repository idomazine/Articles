//
//  PostCommentUseCase.swift
//  Articles
//
//  Created by org on 2025/09/22.
//

import Foundation
import Dependencies

struct PostCommentUseCase {
  var postComment: ((articleId: Int, body: String)) async throws -> Void
}

extension PostCommentUseCase: DependencyKey {
  static let liveValue: PostCommentUseCase = {
    @Dependency(\.commentRepository.addComment) var addComment
    @Dependency(\.date) var date
    
    return .init(
      postComment: { (articleId: Int, body: String) in
        var comment = Comment(articleId: articleId, body: body, createdAt: date.now)
        try addComment(comment)
      }
    )
  }()
  
  static var testValue: PostCommentUseCase { liveValue }
}

extension PostCommentUseCase {
  func callAsFunction(articleId: Int, body: String) async throws {
    try await postComment((articleId: articleId, body: body))
  }
}

extension DependencyValues {
  var postCommentUseCase: PostCommentUseCase {
    get { self[PostCommentUseCase.self] }
    set { self[PostCommentUseCase.self] = newValue }
  }
}
