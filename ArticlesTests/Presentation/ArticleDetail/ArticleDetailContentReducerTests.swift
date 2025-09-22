//
//  ArticleDetailContentReducerTests.swift
//  ArticlesTests
//
//  Created by org on 2025/09/14.
//

import Foundation

import Testing
import ComposableArchitecture

@testable import Articles

@Suite("ArticleDetailContentReducer")
struct ArticleDetailContentReducerTests {
  @Test
  @MainActor
  func favorite_tap_toggle() async {
    let store = TestStore(initialState: ArticleDetailContentReducer.State(article: .sample)) {
      ArticleDetailContentReducer()
    } withDependencies: {
      $0.date.now = Date.makeSample("2025/09/23 00:00:00")
    }
    
    await store.send(.onAppear) 

    await store.send(.favoriteButtonTapped) { state in
      state.isFavorite = true
    }
    
    await store.send(.favoriteButtonTapped) { state in
      state.isFavorite = false
    }
  }

  @Test
  @MainActor
  func favorite_tap_toggle_already_favorite() async {
    @Dependency(\.favoriteRepository) var favoriteRepository
    
    try! favoriteRepository.addFavorite(.init(
      articleId: 101,
      title: "Swift Concurrency実践ガイド",
      createdAt: Date()
    ))
    
    let store = TestStore(initialState: ArticleDetailContentReducer.State(article: .sample)) {
      ArticleDetailContentReducer()
    } withDependencies: {
      $0.favoriteRepository = favoriteRepository
      $0.date.now = Date.makeSample("2025/09/23 00:00:00")
    }
    
    await store.send(.onAppear) { state in
      state.isFavorite = true
    }

    await store.send(.favoriteButtonTapped) { state in
      state.isFavorite = false
    }
    
    await store.send(.favoriteButtonTapped) { state in
      state.isFavorite = true
    }
  }
}

private extension ArticleAPIResponse {
  static var sample: ArticleAPIResponse {
    ArticleAPIResponse(
      id: 101,
      title: "Swift Concurrency実践ガイド",
      body: "async/awaitとTaskの組み合わせでUI応答性を維持する設計を紹介します。",
      backgroundColor: "#4CAF50",
      tags: ["Swift", "Concurrency", "iOS"]
    )
  }
}

