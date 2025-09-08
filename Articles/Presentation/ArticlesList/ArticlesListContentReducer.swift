//
//  ArticlesListContentReducer.swift
//  Articles
//
//  Created by org on 2025/09/08.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ArticlesListContentReducer {
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
        return .none
      }
    }
  }
}
