//
//  FavoritesListReducer.swift
//  Articles
//
//  Created by org on 2025/09/15.
//

import Foundation
import ComposableArchitecture

@Reducer
struct FavoritesListReducer {
  @Dependency(\.favoriteRepository) var favoireRepository

  struct Favorite: Identifiable, Equatable {
    var id: Int
    var title: String
  }
  
  @ObservableState
  struct State {
    var favorites: [Favorite] = []
    @Presents var articleDetail: ArticleDetailReducer.State? = nil
  }
  
  @CasePathable
  enum Action {
    case onAppear
    case updateFavoirets([Favorite])
    case deleteFavorite(id: Int)
    case didSelectArticle(id: Int)
    case articleDetail(PresentationAction<ArticleDetailReducer.Action>)
  }
  
  private enum CancelID {
    case updateFavoirets
  }
  
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        state.favorites = try! favoireRepository.getAll()
          .map {
            Favorite(id: $0.articleId,
                     title: $0.title)
          }
        return .none
      case let .updateFavoirets(favorites):
        state.favorites = favorites
        return .none
      case let .deleteFavorite(id):
        do {
          try favoireRepository.removeFavoriteById(id)
          state.favorites.removeAll {
            $0.id == id
          }
          return .none
        }
        catch {
          return .none
        }
      case let .didSelectArticle(id):
        state.articleDetail = ArticleDetailReducer.State(id: id)
        return .none
      case .articleDetail:
        return .none
      }
    }
    .ifLet(\.$articleDetail, action: \.articleDetail) {
      ArticleDetailReducer()
    }
  }
}
