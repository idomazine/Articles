//
//  ArticlesListView.swift
//  Articles
//
//  Created by org on 2025/09/07.
//

import ComposableArchitecture
import Foundation
import SwiftUI

import SwiftUI
import ComposableArchitecture

struct ArticlesListView: View {
  let store: StoreOf<ArticlesListReducer>
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      Group {
        if let content = store.scope(state: \.content, action: \.content) {
          ArticlesListContentView(store: content)
        }
        if viewStore.isLoading {
          ProgressView("読み込み中…")
        } else if let message = viewStore.errorMessage {
          VStack(spacing: 8) {
            Text("読み込みに失敗しました")
              .font(.headline)
            Text(message)
              .font(.footnote)
              .foregroundColor(.secondary)
          }
          .padding(.top, 24)
        }
      }
      .navigationTitle("ニュース一覧")
      .onAppear { viewStore.send(.onAppear) }
    }
  }
}

#Preview {
  NavigationView {
    ArticlesListView(
      store: Store(initialState: ArticlesListReducer.State()) {
        ArticlesListReducer()
      }
    )
  }
}
