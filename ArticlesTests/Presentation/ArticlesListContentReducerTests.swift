//
//  ArticlesListContentReducerTests.swift
//  ArticlesTests
//
//  Created by org on 2025/09/13.
//

import Testing
import ComposableArchitecture

@testable import Articles

@Suite("ArticlesListContentReducer")
struct ArticlesListContentReducerTests {
  @Test
  @MainActor
  func selectArticle() async throws {
    let store = TestStore(
      initialState: ArticlesListContentReducer.State.initial,
      reducer: { ArticlesListContentReducer() }
    )
    
    store.exhaustivity = .off
    
    await store.send(.didSelectArticleWithId(1)) {
      $0.articleDetail = ArticleDetailReducer.State(id: 1)
    }
  }
}

private extension  ArticlesListContentReducer.State {
  static var initial: Self {
    ArticlesListContentReducer.State(articles: [
      .init(
        id: 1,
        title: "Swift Concurrency実践ガイド",
        body: "async/awaitとTaskの組み合わせでUI応答性を維持する設計を紹介します。",
        backgroundColor: "#FFAA00",
        tags: ["環境", "科学"]
      ),
      .init(
        id: 2,
        title: "Composable Architecture入門",
        body: "State/Action/Reducerの分離と依存差し替えの基本パターンを整理します。",
        backgroundColor: "#00BFFF",
        tags: ["地域社会", "環境"]
      ),
      .init(
        id: 3,
        title: "Swift Testingの基本",
        body: "新しいTestingフレームワークでのテスト記述と移行のポイントを解説します。",
        backgroundColor: "#32CD32",
        tags: ["文化・芸術", "地域社会"]
      )
    ])
  }
}

