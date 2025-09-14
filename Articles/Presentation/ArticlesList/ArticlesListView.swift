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
    LoadableView(store: store.scope(state: \.loadableContent,
                                    action: \.loadableContent)) {
      ArticlesListContentView(store: $0)
    }
                                    .navigationBarTitleDisplayMode(.inline)
                                    .navigationTitle("ニュース一覧")
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
