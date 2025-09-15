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
  @Dependency(\.favoireRepository) var favoireRepository
  
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
        state.isFavorite = (try? favoireRepository.getFavoriteById(state.article.id)) != nil
        return .none
      case .favoriteButtonTapped:
        if state.isFavorite {
          try! favoireRepository.removeFavoriteById(state.article.id)
        } else {
          try! favoireRepository.addFavorite(.init(
            articleId: state.article.id,
            title: state.article.title,
            createdAt: Date()
          ))
        }
        state.isFavorite.toggle()
        return .none
      }
    }
  }
}
