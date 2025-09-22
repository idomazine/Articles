//
//  ArticleDetailContentView.swift
//  Articles
//
//  Created by org on 2025/09/11.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct ArticleDetailContentView: View {
  var store: StoreOf<ArticleDetailContentReducer>
  
  init(store: StoreOf<ArticleDetailContentReducer>) {
    self.store = store
  }
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 16) {
        ZStack {
          RoundedRectangle(cornerRadius: 16)
            .fill(Color(hex: store.article.backgroundColor) ?? .secondary.opacity(0.2))
            .frame(height: 100)
          Text(store.article.title)
            .font(.title2).bold()
            .multilineTextAlignment(.center)
            .padding()
        }
        
        if !store.article.tags.isEmpty {
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
              ForEach(store.article.tags, id: \.self) { tag in
                Text(tag)
                  .font(.caption)
                  .padding(.horizontal, 8)
                  .padding(.vertical, 4)
                  .background(Capsule().fill(Color.gray.opacity(0.15)))
              }
            }
          }
          .padding(.horizontal)
        }
        Text(store.article.body)
          .font(.caption).bold()
          .multilineTextAlignment(.center)
          .padding()
      }
      
      Text("コメント(\(store.comments.count))")
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
  
      VStack(alignment: .leading, spacing: 3) {
        ForEach(store.comments) { comment in
          Text(comment.body)
            .padding(.horizontal)
            .font(.caption)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay {
              RoundedRectangle(cornerRadius: 4)
                .stroke(Color.gray, lineWidth: 1)
            }
            .padding(4)
        }
      }
      
      Button {
        store.send(.commentButtonTapped)
      } label: {
        Text("コメントをする")
      }
    }
    .onAppear {
      store.send(.onAppear)
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          store.send(.favoriteButtonTapped)
        } label: {
          Image(systemName: store.isFavorite ? "star.fill" : "star")
        }
      }
    }
    .sheet(
      store: store.scope(state: \.$postComment, action: \.postComment)
    ) { store in
      PostCommentView(store: store)
    }
  }
}
