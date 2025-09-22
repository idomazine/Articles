//
//  PostCommentReducer.swift
//  Articles
//
//  Created by org on 2025/09/22.
//

import Foundation
import ComposableArchitecture
import Dependencies

@Reducer
struct PostCommentReducer {
  @Dependency(\.postCommentUseCase) var postCommentUseCase
  @Dependency(\.dismiss) var dismiss
  
  @ObservableState
  struct State: Equatable {
    let articleId: Int
    var bodyText: String = ""
    var isPosting: Bool = false
    @Presents var alert: AlertState<Action.Alert>?
  }
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
    case cancelButtonTapped
    case postButtonTapped
    case postResponse(Result<Void, Error>)
    case alert(PresentationAction<Alert>)
    case delegate(Delegate)
    
    enum Alert {
      case okTapped
    }
    
    enum Delegate: Equatable {
      case didPost
    }
  }
  
  var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case .cancelButtonTapped:
        return .run { _ in await dismiss() }
        
      case .postButtonTapped:
        let trimmed = state.bodyText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
          state.alert = AlertState {
            TextState("本文が空です")
          } actions: {
            ButtonState(role: .cancel, action: .okTapped) { TextState("OK") }
          } message: {
            TextState("コメントの本文を入力してください。")
          }
          return .none
        }
        state.isPosting = true
        let articleId = state.articleId
        let body = state.bodyText
        return .run { send in
          await send(.postResponse(Result {
            try await postCommentUseCase(articleId: articleId, body: body)
          }))
        }
        
      case let .postResponse(result):
        state.isPosting = false
        switch result {
        case .success:
          // 親へ通知して閉じる
          return .concatenate(
            .send(.delegate(.didPost)),
            .run { _ in await dismiss() }
          )
        case let .failure(error):
          state.alert = AlertState {
            TextState("投稿に失敗しました")
          } actions: {
            ButtonState(action: .okTapped) { TextState("OK") }
          } message: {
            TextState(error.localizedDescription)
          }
          return .none
        }
        
      case .alert:
        return .none
        
      case .delegate:
        return .none
      }
    }
  }
}
