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
  }
  
  @CasePathable
  enum Action {
    case onAppear
    case onDisappear
    case updateFavoirets([Favorite])
  }
  
  private enum CancelID {
    case updateFavoirets
  }
  
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        return .run { send in
          do {
            let getFavorites = try favoireRepository.getAll()
            for try await favoritesUpdated in getFavorites {
              let favorites = favoritesUpdated
                .sorted { $0.createdAt < $1.createdAt }
                .map {
                  Favorite(id: $0.articleId,
                           title: $0.title)
                }
              await send(.updateFavoirets(favorites))
            }
          } catch {
            print(error)
          }
        }
        .cancellable(id: CancelID.updateFavoirets, cancelInFlight: true)
      case .onDisappear:
        return .cancel(id: CancelID.updateFavoirets)
      case let .updateFavoirets(favorites):
        state.favorites = favorites
        return .none
      }
        
    }
  }
}
