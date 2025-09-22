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
  @Dependency(\.commentRepository.getCommentByArticleId) var getCommentByArticleId
  @Dependency(\.date) var date

  @ObservableState
  struct State: Equatable, Sendable {
    struct Comment: Equatable, Sendable, Identifiable {
      let id: Int
      var body: String
    }
    
    @Presents var postComment: PostCommentReducer.State?

    var article: ArticleAPIResponse
    var isFavorite: Bool = false
    var comments: [Comment] = []
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
        fetchComments(state: &state)
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
      case .postComment(.presented(.postResponse(.success))):
        fetchComments(state: &state)
        return .none
      case .postComment:
        return .none
      }
    }
    .ifLet(\.$postComment, action: \.postComment) {
      PostCommentReducer()
    }
  }
  
  private func fetchComments(state: inout State) {
    let comments = try? getCommentByArticleId(state.article.id).map {
      State.Comment(id: $0.id.hashValue,
                    body: $0.body)
    }
    if let comments {
      state.comments = comments
    }
  }
}
