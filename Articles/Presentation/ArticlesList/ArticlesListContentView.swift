//
//  ArticlesListContentView.swift
//  Articles
//
//  Created by org on 2025/09/08.
//

import SwiftUI
import ComposableArchitecture

struct ArticlesListContentView: View {
  @Bindable var store: StoreOf<ArticlesListContentReducer>
  
  var body: some View {
    List(store.articles) { article in
      ArticleListElementView(article: article) {
        store.send(.didSelectArticleWithId(article.id))
      }
    }
    .listStyle(.plain)
    .onAppear { store.send(.onAppear) }
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
