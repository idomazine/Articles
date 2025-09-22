//
//  PostCommentUseCaseTests.swift
//  ArticlesTests
//
//  Created by org on 2025/09/22.
//

import Foundation
import Testing
import Dependencies
@testable import Articles

struct PostCommentUseCaseTests {
  @Test
  func postCommentSuccess() async throws {
     try await withDependencies {
      $0.apiClient.postComment = { _ in }
      $0.date.now = Date.makeSample("2025/09/23 00:00:00")
    } operation: {
      @Dependency(\.postCommentUseCase) var useCase
      @Dependency(\.commentRepository) var commentRepository
      
      try await useCase(articleId: 1, body: "Hello")
      let comment = try commentRepository.getCommentByArticleId(1).first { $0.articleId == 1 }
      
      #expect(comment?.articleId == 1)
      #expect(comment?.body == "Hello")
    }
  }
}
