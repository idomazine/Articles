//
//  ProfileView.swift
//  MultiSimp
//  
//  Created by idomazine on 2025/08/11
//  
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct ProfileView: View {
  @Bindable var store: StoreOf<ProfileReducer>
  
  var body: some View {
    Form {
      Section("アカウント") {
        HStack {
          Text("メールアドレス")
          Spacer()
          TextField("", text: $store.email)
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .submitLabel(.done)
            .onSubmit {
              store.send(.onSubmitEmail)
            }
        }
      }
      
      Section("アプリ情報") {
        HStack {
          Text("バージョン")
          Spacer()
          Text(store.appVersion)
            .monospaced()
            .foregroundStyle(.secondary)
        }
      }
    }
    .navigationTitle("プロフィール")
    .task {
      // 表示時に現在のアプリバージョンを取得して state に反映
      store.send(.onAppear)
    }
  }
}

// プレビュー
#Preview {
  NavigationStack {
    ProfileView(
      store: Store(
        initialState: ProfileReducer.State(
          email: "test@example.com",
          appVersion: "—"
        )
      ) {
        ProfileReducer()
      }
    )
  }
}
