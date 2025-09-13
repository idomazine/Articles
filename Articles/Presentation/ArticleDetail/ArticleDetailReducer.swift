//
//  ArticleDetailReducer.swift
//  Articles
//
//  Created by org on 2025/09/10.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ArticleDetailReducer {
  typealias Content = ArticleDetailContentReducer
  typealias Loadable = LoadableReducer<Int, Content>
  @Dependency(\.apiClient.getArticleWithId) var getArticleWithId
  
  @ObservableState
  struct State: Equatable {
    var loadableContent: Loadable.State
    
    init(id: Int) {
      loadableContent = .init(parameter: id)
    }
  }
  
  enum Action {
    case loadableContent(Loadable.Action)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .loadableContent:
        return .none
      }
    }
    Scope(state: \.loadableContent,
          action: \.loadableContent) {
      Loadable(
        loadTask: { id in
          let article = try await getArticleWithId(id)
          let state = Content.State(article: article)
          return state
        },
        makeContent: {
          Content()
        })
    }
  }
}
