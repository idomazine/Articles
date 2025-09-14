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
      Button {
        store.send(.didSelectArticleWithId(article.id))
      } label: {
        VStack(alignment: .leading, spacing: 4) {
          Text(article.title)
            .font(.headline)
          Text(article.body)
            .font(.subheadline)
            .foregroundColor(.secondary)
            .lineLimit(1)
        }
      }
    }
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
