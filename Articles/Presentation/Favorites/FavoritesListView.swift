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
    List {
      ForEach(store.favorites) { favorite in
        Text(favorite.title)
      }
      .onDelete {
        $0.forEach {
          store.send(.deleteFavorite(id: store.favorites[$0].id))
        }
      }
    }
    .onAppear { store.send(.onAppear) }
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
