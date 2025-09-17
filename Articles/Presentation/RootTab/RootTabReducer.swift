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
    case articlesList
    case favoritesList
    case profile
  }
  
  @ObservableState
  struct State {
    var selectedTab: Tab = .articlesList
    var articlesList = ArticlesListReducer.State()
    var favoritesList = FavoritesListReducer.State()
    var profile = ProfileReducer.State()
  }
  
  @CasePathable
  enum Action {
    case selectTab(Tab)
    case onOpenURL(URL)
    case articlesList(ArticlesListReducer.Action)
    case favoritesList(FavoritesListReducer.Action)
    case profile(ProfileReducer.Action)
  }
  
  var body: some Reducer<State, Action> {
    Scope(state: \.articlesList,
          action: \.articlesList) {
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
      case let .onOpenURL(url):
        if let urlRoute = URLRoute(url: url) {
          switch urlRoute {
          case .articlesList:
            state.selectedTab = .articlesList
          case let .article(id):
            // TODO: 個別記事への遷移
            state.selectedTab = .articlesList
          case .favoritesList:
            state.selectedTab = .favoritesList
          case .profile:
            state.selectedTab = .profile
          }
        }
        return .none
      case .articlesList:
        return .none
      case .favoritesList:
        return .none
      case .profile:
        return .none
      }
    }
  }
}
