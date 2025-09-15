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
    var nextPage: Int? = nil
    var isLoadingNextPage: Bool = false
    @Presents var articleDetail: ArticleDetailReducer.State? = nil
  }
  
  enum Action {
    case onAppear
    case didSelectArticle(id: Int)
    case articleDetail(PresentationAction<ArticleDetailReducer.Action>)
    case reachLastArticles
    case nextPageRequestResponse(Result<ArticlesListAPIResponse, Error>)
  }

  @Dependency(\.apiClient.getArticlesWithPage) var getArticlesWithPage

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
      case .reachLastArticles:
        if let nextPage = state.nextPage,
           !state.isLoadingNextPage {
          state.isLoadingNextPage = true
          return .run { send in
            do {
              let articlesList = try await getArticlesWithPage(nextPage)
              await send(.nextPageRequestResponse(.success(articlesList)))
            } catch {
              await send(.nextPageRequestResponse(.failure(error)))
            }
          }
        } else {
          return .none
        }
      case let .nextPageRequestResponse(result):
        state.isLoadingNextPage = false
        switch result {
        case let .success(response):
          state.articles.append(contentsOf: response.articles.map {
            .init(
              id: $0.id,
              title: $0.title,
              body: $0.body,
              backgroundColor: $0.backgroundColor,
              tags: $0.tags
            )
          })
          state.nextPage = response.nextPage
        case .failure:
          break
        }
        return .none
      }
    }
    .ifLet(\.$articleDetail, action: \.articleDetail) {
      ArticleDetailReducer()
    }
  }
}
