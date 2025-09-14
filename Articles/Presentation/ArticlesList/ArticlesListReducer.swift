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
  typealias Loadable = LoadableReducer<EquatableVoid, Content>
  @Dependency(\.apiClient.getArticles) var getArticles

  @ObservableState
  struct State: Equatable {
    var loadableContent: Loadable.State = .init(parameter: .init())
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
        loadTask: { _ in
          let items = try await getArticles()
          let state = Content.State(articles: items.map {
            Content.Article(
              id: $0.id,
              title: $0.title,
              body: $0.body,
              backgroundColor: $0.backgroundColor,
              tags: $0.tags
            )
          })
          return state
        },
        makeContent: {
          Content()
        })
    }
  }
}
