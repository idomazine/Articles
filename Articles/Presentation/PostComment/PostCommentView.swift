//
//  PostCommentView.swift
//  Articles
//
//  Created by org on 2025/09/22.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct PostCommentView: View {
  @Bindable var store: StoreOf<PostCommentReducer>
  
  var body: some View {
    NavigationStack {
      VStack(spacing: 12) {
        TextEditor(text: $store.bodyText)
          .frame(minHeight: 200)
          .padding(8)
          .overlay(
            RoundedRectangle(cornerRadius: 8).stroke(.quaternary)
          )
          .disabled(store.isPosting)
        
        Spacer(minLength: 0)
      }
      .padding()
      .navigationTitle("コメント")
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("閉じる") { store.send(.cancelButtonTapped) }
            .disabled(store.isPosting)
        }
        ToolbarItem(placement: .confirmationAction) {
          Button("投稿") { store.send(.postButtonTapped) }
            .disabled(store.isPosting || store.bodyText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
      }
      .overlay {
        if store.isPosting {
          ZStack {
            Color.black.opacity(0.1).ignoresSafeArea()
            ProgressView().controlSize(.large)
          }
        }
      }
    }
    .alert($store.scope(state: \.alert, action: \.alert))
  }
}
