//
//  ProfileReducer.swift
//  MultiSimp
//
//  Created by org on 2025/08/09.
//

import Foundation
import ComposableArchitecture
import SwiftUI

@Reducer
struct ProfileReducer: Reducer {
  @Dependency(\.appVersion.current) var appVersion: String
  
  @ObservableState
  struct State: Equatable {
    @Shared(.appStorage("email")) var email: String = "test@example.com"
    var appVersion: String = ""
  }
  
  enum Action: BindableAction {
    case onAppear
    case onSubmitEmail
    case binding(BindingAction<State>)
  }
  
  var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .onAppear:
        state.appVersion = appVersion
        return .none
      case .onSubmitEmail:
        return .none
      case .binding:
        return .none
      }
    }
  }
}
