//
//  ArticleDetailReducer.swift
//  Articles
//
//  Created by org on 2025/09/10.
//

import ComposableArchitecture
import Foundation

@Reducer
public struct ArticleDetailReducer {
  @Dependency(\.apiClient.getArticleWithId) private var getArticleWithId
  
  @ObservableState
  struct State: Equatable, Sendable {
    let id: Int
    var isLoading: Bool = false
    var errorMessage: String?
    var article: ArticleAPIResponse?

    init(id: Int, article: ArticleAPIResponse? = nil) {
      self.id = id
      self.article = article
    }
  }
  
  enum Action: Sendable, Equatable {
    case onAppear
    case reloadTapped
    case _response(TaskResult<ArticleAPIResponse>)
  }
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear, .reloadTapped:
        state.isLoading = true
        state.errorMessage = nil
        let id = state.id
        return .run { send in
          await send(._response(TaskResult { try await getArticleWithId(id) }))
        }
        
      case let ._response(.success(article)):
        state.isLoading = false
        state.article = article
        return .none
        
      case let ._response(.failure(error)):
        state.isLoading = false
        state.errorMessage = (error as NSError).localizedDescription
        return .none
      }
    }
  }
}
