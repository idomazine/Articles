//
//  ArticlesListReducer.swift
//  ArticlesTests
//
//  Created by org on 2025/09/13.
//

import Testing
import ComposableArchitecture
@testable import Articles

@Suite("ArticlesListReducer")
struct ArticlesListReducerTests {
  @Test
  @MainActor
  func loadArticles_success() async throws {
    let store = TestStore(initialState: ArticlesListReducer.State()) {
      ArticlesListReducer()
    }
    
    store.exhaustivity = .off
    
    store.dependencies.apiClient.getArticles = {
      ArticleAPIResponse.sampleList
    }
    
    await store.send(\.loadableContent.task) {
      $0.loadableContent.loadingStatus = .loading
    }
    
    await store.receive(\.loadableContent.response.success) {
      $0.loadableContent.loadingStatus = .loaded
      $0.loadableContent.content?.articles[0].id = 101
      $0.loadableContent.content?.articles[1].id = 102
      $0.loadableContent.content?.articles[2].id = 103
    }
  }

  @Test
  @MainActor
  func loadArticles_failure() async throws {
    enum DummyError: Error, Equatable { case failed }
    
    let store = TestStore(initialState: ArticlesListReducer.State()) {
      ArticlesListReducer()
    }
    
    store.exhaustivity = .off
    
    store.dependencies.apiClient.getArticles = {
      throw DummyError.failed
    }
    
    await store.send(\.loadableContent.task) {
      $0.loadableContent.loadingStatus = .loading
    }
    
    await store.receive(\.loadableContent.response.failure)
    #expect(store.state.loadableContent.loadingStatus.is(\.failure))
  }
}

private extension ArticleAPIResponse {
  static var sampleList: [ArticleAPIResponse] {
    [
      ArticleAPIResponse(
        id: 101,
        title: "Swift Concurrency実践ガイド",
        body: "async/awaitとTaskの組み合わせでUI応答性を維持する設計を紹介します。",
        backgroundColor: "#4CAF50",
        tags: ["Swift", "Concurrency", "iOS"]
      ),
      ArticleAPIResponse(
        id: 102,
        title: "Composable Architecture入門",
        body: "State/Action/Reducerの分離と依存差し替えの基本パターンを整理します。",
        backgroundColor: "#2196F3",
        tags: ["TCA", "Architecture"]
      ),
      ArticleAPIResponse(
        id: 103,
        title: "Swift Testingの基本",
        body: "新しいTestingフレームワークでのテスト記述と移行のポイントを解説します。",
        backgroundColor: "#FF9800",
        tags: ["Testing", "Swift"]
      )
    ]
  }
}

