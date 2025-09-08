//
//  ArticlesListReducer.swift
//  Articles
//
//  Created by org on 2025/09/07.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ArticlesListReducer {
  typealias Content = ArticlesListContentReducer
  @Dependency(\.apiClient.getArticles) var getArticles
  
  struct News: Identifiable, Equatable {
    var id: Int
    var title: String
    var body: String
  }

  @ObservableState
  struct State: Equatable {
    var isLoading: Bool = false
    var errorMessage: String? = nil
    var content: Content.State? = nil
  }
  
  enum Action {
    case onAppear
    case loaded([ArticleAPIResponse])
    case failed(String)
    case content(Content.Action)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        guard !state.isLoading else { return .none }
        
        state.isLoading = true
        state.errorMessage = nil
        
        return .run { send in
          do {
            let items = try await getArticles()
            await send(.loaded(items))
          } catch {
            await send(.failed(error.localizedDescription))
          }
        }
      case let .loaded(items):
        state.isLoading = false
        state.content = Content.State(articles: items.map {
          .init(
            id: $0.id,
            title: $0.title,
            body: $0.body
          )
        })
        state.errorMessage = nil
        return .none
        
      case let .failed(message):
        state.isLoading = false
        state.errorMessage = message
        return .none
      case .content:
        return .none
      }
    }
    .ifLet(\.content, action: \.content) {
      Content()
    }
  }
}
