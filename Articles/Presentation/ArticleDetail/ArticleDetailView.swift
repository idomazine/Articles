//
//  ArticleDetailView.swift
//  Articles
//
//  Created by org on 2025/09/10.
//

import ComposableArchitecture
import SwiftUI

struct ArticleDetailView: View {
  var store: StoreOf<ArticleDetailReducer>
  
  init(store: StoreOf<ArticleDetailReducer>) {
    self.store = store
  }
  
  var body: some View {
    LoadableView(store: store.scope(state: \.loadableContent,
                                    action: \.loadableContent)) {
      ArticleDetailContentView(store: $0)
    }
                                    .navigationTitle("記事詳細")
  }
}
