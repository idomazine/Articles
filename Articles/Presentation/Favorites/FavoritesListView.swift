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
        Button {
          store.send(.didSelectArticle(id: favorite.id))
        } label: {
          Text(favorite.title)
        }
      }
      .onDelete {
        $0.forEach {
          store.send(.deleteFavorite(id: store.favorites[$0].id))
        }
      }
    }
    .overlay {
      if store.favorites.isEmpty {
        ContentUnavailableView(
          "お気に入りはありません",
          systemImage: "star",
          description: Text("記事をお気に入りに追加するとここに表示されます。"),
        )
      }
    }
    .onAppear { store.send(.onAppear) }
    .navigationTitle("お気に入り")
    .navigationDestination(store: store.scope(state: \.$articleDetail,
                                              action: \.articleDetail)) { store in
      ArticleDetailView(store: store)
    }
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
