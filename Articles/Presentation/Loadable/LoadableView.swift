//
//  LoadableView.swift
//  Articles
//
//  Created by org on 2025/09/09.
//

import ComposableArchitecture
import Foundation
import SwiftUI

struct LoadableView<Parameter: Sendable, Content: Reducer, ContentView: View>: View {
  let store: StoreOf<LoadableReducer<Parameter, Content>>
  
  @ViewBuilder let contentBody: (StoreOf<Content>) -> ContentView
  
  var body: some View {
    VStack {
      switch store.state.loadingStatus {
      case .initial:
        progressView()
      case .loaded, .loading:
        if let content = store.scope(state: \.content,
                                     action: \.content) {
          contentBody(content)
            .refreshable {
              await store.send(.refresh).finish()
            }
        } else if store.state.loadingStatus == .loading {
          progressView()
        } else {
          EmptyView()
        }
      case .failure(let errorMsg):
        VStack(spacing: 8) {
          Text(errorMsg).foregroundColor(.red)
          Button("リトライ") {
            store.send(.reload)
          }
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .task {
      store.send(.task)
    }
  }
  
  private func progressView() -> some View {
    ProgressView("Loading...")
  }
}
