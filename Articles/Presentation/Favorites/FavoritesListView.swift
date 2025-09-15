//
//  FavoritesListView.swift
//  Articles
//
//  Created by org on 2025/09/15.
//

import SwiftUI
import ComposableArchitecture

struct FavoritesListView: View {
  @Bindable var store: StoreOf<FavoritesListReducer>
  
  var body: some View {
    List(store.favorites) { article in
      Text(article.title)
    }
    .onAppear { store.send(.onAppear) }
    .onDisappear { store.send(.onDisappear) }
    .navigationTitle("お気に入り")
  }
}

#Preview {
  NavigationView {
    ArticlesListContentView(
      store: Store(initialState: ArticlesListContentReducer.State()) {
        ArticlesListContentReducer()
      }
    )
  }
}
