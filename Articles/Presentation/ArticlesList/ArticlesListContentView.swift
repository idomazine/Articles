//
//  ArticlesListContentView.swift
//  Articles
//
//  Created by org on 2025/09/08.
//

import SwiftUI
import ComposableArchitecture

struct ArticlesListContentView: View {
  let store: StoreOf<ArticlesListContentReducer>
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List(viewStore.articles) { article in
        VStack(alignment: .leading, spacing: 4) {
          Text(article.title)
            .font(.headline)
          Text(article.body)
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
      }
      .navigationTitle("ニュース一覧")
      .onAppear { viewStore.send(.onAppear) }
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
