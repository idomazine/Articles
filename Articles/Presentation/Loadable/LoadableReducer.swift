//
//  LoadableReducer.swift
//  Articles
//
//  Created by org on 2025/09/08.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct LoadableReducer<Parameter: Sendable, Content: Reducer>: Reducer {
  @ObservableState
  public struct State {
    @CasePathable
    public enum LoadingStatus: Equatable {
      case initial
      case loading
      case loaded
      case failure(String)
    }
    
    public let parameter: Parameter
    public var loadingStatus: LoadingStatus = .initial
    public var content: Content.State?

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
    case refresh
    case response(Result<Content.State, Error>)
    case content(Content.Action)
  }
  
  public let loadTask: @Sendable (Parameter) async throws -> Content.State
  public let makeContent: @Sendable () -> Content

  public init(
    loadTask: @Sendable @escaping (Parameter) async throws -> Content.State,
    makeContent: @escaping @Sendable () -> Content
  ) {
    self.loadTask = loadTask
    self.makeContent = makeContent
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
      case .refresh:
        return startLoading(state: &state)
      case let .response(.success(content)):
        state.loadingStatus = .loaded
        state.content = content
        return .none
      case let .response(.failure(error)):
        state.loadingStatus = .failure(error.localizedDescription)
        state.content = nil
        return .none
      case .content:
        return .none
      }
    }
    .ifLet(\.content, action: \.content) {
      makeContent()
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

extension LoadableReducer.State: Equatable where Content.State: Equatable, Parameter: Equatable {}

public typealias LoadableState<Parameter, Content> = LoadableReducer<Parameter, Content>.State where Content: Reducer
public typealias LoadableAction<Parameter, Content> = LoadableReducer<Parameter, Content>.Action where Content: Reducer
