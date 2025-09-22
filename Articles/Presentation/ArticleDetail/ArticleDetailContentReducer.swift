//
//  ArticleDetailContentReducer.swift
//  Articles
//
//  Created by org on 2025/09/11.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ArticleDetailContentReducer {
  @Dependency(\.favoriteRepository) var favoireRepository
  @Dependency(\.date) var date

  @ObservableState
  struct State: Equatable, Sendable {
    @Presents var postComment: PostCommentReducer.State?

    var article: ArticleAPIResponse
    var isFavorite: Bool = false
  }
  
  enum Action: Sendable {
    case postComment(PresentationAction<PostCommentReducer.Action>)
    case onAppear
    case favoriteButtonTapped
    case commentButtonTapped
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        state.isFavorite = (try? favoireRepository.getFavoriteById(state.article.id)) != nil
        return .none
      case .favoriteButtonTapped:
        if state.isFavorite {
          try! favoireRepository.removeFavoriteById(state.article.id)
        } else {
          try! favoireRepository.addFavorite(.init(
            articleId: state.article.id,
            title: state.article.title,
            createdAt: date.now
          ))
        }
        state.isFavorite.toggle()
        return .none
      case .commentButtonTapped:
        state.postComment = .init(articleId: state.article.id)
        return .none
      case .postComment:
        return .none
      }
    }
    .ifLet(\.$postComment, action: \.postComment) {
      PostCommentReducer()
    }
  }
}
