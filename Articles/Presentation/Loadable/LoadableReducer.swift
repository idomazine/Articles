//
//  LoadableReducer.swift
//  Articles
//
//  Created by org on 2025/09/08.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct LoadableReducer<Parameter: Sendable, Content: Sendable>: Reducer, Sendable {
  public struct State {
    @CasePathable
    public enum LoadingStatus {
      case initial
      case loading
      case success(Content)
      case failure(String)
    }
    
    public let parameter: Parameter
    public var loadingStatus: LoadingStatus = .initial
    
    public init(parameter: Parameter,
                loadingStatus: LoadingStatus = .initial) {
      self.parameter = parameter
      self.loadingStatus = loadingStatus
    }
  }
  
  @CasePathable
  public enum Action {
    case task
    case reload
    case response(Result<Content, Error>)
  }
  
  public let loadTask: @Sendable (Parameter) async throws -> Content
  
  public init(loadTask: @Sendable @escaping (Parameter) async throws -> Content) {
    self.loadTask = loadTask
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .task:
        if state.loadingStatus.is(\.initial)
            || state.loadingStatus.is(\.failure) {
          return startLoading(state: &state)
        } else {
          return .none
        }
      case .reload:
        return startLoading(state: &state)
      case let .response(.success(content)):
        state.loadingStatus = .success(content)
        return .none
      case let .response(.failure(error)):
        state.loadingStatus = .failure(error.localizedDescription)
        return .none
      }
    }
  }
  
  private func startLoading(state: inout State) -> Effect<Action> {
    state.loadingStatus = .loading
    let param = state.parameter
    return .run { send in
      do {
        let content = try await loadTask(param)
        await send(.response(.success(content)))
      } catch {
        await send(.response(.failure(error)))
      }
    }
  }
}
