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
  struct Article: Identifiable, Equatable {
    var id: Int
    var title: String
    var body: String
    var backgroundColor: String
    var tags: [String]
  }
  
  @ObservableState
  struct State: Equatable {
    var articles: [Article] = []
    @Presents var articleDetail: ArticleDetailReducer.State? = nil
  }
  
  enum Action {
    case onAppear
    case didSelectArticle(id: Int)
    case articleDetail(PresentationAction<ArticleDetailReducer.Action>)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        return .none
      case let .didSelectArticle(id):
        state.articleDetail = .init(id: id)
        return .none
      case .articleDetail:
        return .none
      }
    }
    .ifLet(\.$articleDetail, action: \.articleDetail) {
      ArticleDetailReducer()
    }
  }
}
