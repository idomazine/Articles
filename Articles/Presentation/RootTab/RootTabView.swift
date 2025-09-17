//
//  RootTab.swift
//  MultiSimp
//
//  Created by org on 2025/08/09.
//

import SwiftUI
import ComposableArchitecture

struct RootTabView: View {
  @Bindable var store: StoreOf<RootTabReducer>
  
  var body: some View {
    TabView(selection: $store.selectedTab.sending(\.selectTab)) {
      NavigationStack {
        ArticlesListView(store: store.scope(state: \.articles,
                                            action: \.articles))
      }
      .tabItem {
        Label("ニュース", systemImage: "book.closed")
      }
      NavigationStack {
        FavoritesListView(store: store.scope(state: \.favoritesList,
                                             action: \.favoritesList))
      }
      .tabItem {
        Label("お気に入り", systemImage: "star")
      }
      .tag(RootTabReducer.Tab.favoritesList)
      
      NavigationStack {
        ProfileView(store: store.scope(state: \.profile,
                                       action: \.profile))
      }
      .tabItem {
        Label("プロフィール", systemImage: "person.crop.circle")
      }
      .tag(RootTabReducer.Tab.profile)
    }
    .onOpenURL { url in
      store.send(.onOpenURL(url))
    }
  }
}

#Preview {
  RootTabView(
    store: Store(initialState: .init()) {
      RootTabReducer()
    }
  )
}
