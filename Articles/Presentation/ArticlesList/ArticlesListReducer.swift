//
//  ArticlesListReducer.swift
//  Articles
//
//  Created by org on 2025/09/07.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ArticlesListReducer {
  struct News: Identifiable, Equatable {
    var id: Int
    var title: String
    var body: String
  }

  @ObservableState
  struct State: Equatable {
    var articles: [News] = []
  }
  
  enum Action {
    case onAppear
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        // ダミー10件を生成
        state.articles = (1...10).map { i in
          News(id: i, title: "ニュースタイトル \(i)", body: "ニュース本文 \(i)")
        }
        return .none
      }
    }
  }
}
