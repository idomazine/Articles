//
//  ArticleDetailContentReducer.swift
//  Articles
//
//  Created by org on 2025/09/11.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ArticleDetailContentReducer {
  @ObservableState
  struct State: Equatable, Sendable {
    var article: ArticleAPIResponse
    var isFavorite: Bool = false
  }
  
  enum Action: Sendable, Equatable {
    case onAppear
    case favoriteButtonTapped
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        return .none
      case .favoriteButtonTapped:
        state.isFavorite.toggle()
        return .none
      }
    }
  }
}
