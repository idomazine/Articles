//
//  RootTabReducer.swift
//  MultiSimp
//
//  Created by org on 2025/08/09.
//

import Foundation
import ComposableArchitecture

@Reducer
struct RootTabReducer {
  enum Tab: Equatable {
    case books
    case favoritesList
    case profile
  }
  
  @ObservableState
  struct State {
    var selectedTab: Tab = .books
    var articles = ArticlesListReducer.State()
    var favoritesList = FavoritesListReducer.State()
    var profile = ProfileReducer.State()
  }
  
  @CasePathable
  enum Action {
    case selectTab(Tab)
    case articles(ArticlesListReducer.Action)
    case favoritesList(FavoritesListReducer.Action)
    case profile(ProfileReducer.Action)
  }
  
  var body: some Reducer<State, Action> {
    Scope(state: \.articles,
          action: \.articles) {
      ArticlesListReducer()
    }
    Scope(state: \.favoritesList,
          action: \.favoritesList) {
      FavoritesListReducer()
    }
    Scope(state: \.profile,
          action: \.profile) {
      ProfileReducer()
    }
    Reduce { state, action in
      switch action {
      case let .selectTab(selectedTab):
        state.selectedTab = selectedTab
        return .none
      case .articles:
        return .none
      case .favoritesList:
        return .none
      case .profile:
        return .none
      }
    }
  }
}
