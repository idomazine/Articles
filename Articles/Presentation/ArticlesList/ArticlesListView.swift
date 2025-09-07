//
//  ArticlesListView.swift
//  Articles
//
//  Created by org on 2025/09/07.
//

import ComposableArchitecture
import Foundation
import SwiftUI

struct ArticlesListView: View {
  var store: StoreOf<ArticlesListReducer>
  
  var body: some View {
    List(store.articles) { article in
      VStack(alignment: .leading, spacing: 4) {
        Text(article.title)
          .font(.headline)
        Text(article.body)
          .font(.subheadline)
          .foregroundColor(.secondary)
      }
      .padding(.vertical, 4)
    }
    .onAppear {
      store.send(.onAppear)
    }
    .navigationTitle("ニュース一覧")
  }
}

// MARK: - Preview
#Preview {
  NavigationView {
    ArticlesListView(
      store: Store(initialState: ArticlesListReducer.State()) {
        ArticlesListReducer()
      }
    )
  }
}
