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
    var articles: [News] = []
  }
  
  enum Action {
    case onAppear
    case loaded([ArticleAPIResponse])
    case failed(String)
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
        state.articles = items.map {
          News(
            id: $0.id,
            title: $0.title,
            body: $0.body
          )
        }
        state.errorMessage = nil
        return .none
        
      case let .failed(message):
        state.isLoading = false
        state.errorMessage = message
        return .none
      }
    }
  }
}
