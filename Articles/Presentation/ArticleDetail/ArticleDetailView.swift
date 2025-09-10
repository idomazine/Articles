//
//  ArticleDetailView.swift
//  Articles
//
//  Created by org on 2025/09/10.
//

import ComposableArchitecture
import SwiftUI

struct ArticleDetailView: View {
  var store: StoreOf<ArticleDetailReducer>
  
  init(store: StoreOf<ArticleDetailReducer>) {
    self.store = store
  }
  
  var body: some View {
    content
      .navigationTitle("記事詳細")
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button(action: { store.send(.reloadTapped) }) { Image(systemName: "arrow.clockwise") }
            .disabled(store.isLoading)
        }
      }
      .task { store.send(.onAppear) }
  }
  
  @ViewBuilder
  private var content: some View {
    if store.isLoading && store.article == nil {
      ProgressView("読み込み中…")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    } else if let article = store.article {
      ScrollView {
        VStack(alignment: .leading, spacing: 16) {
          ZStack {
            RoundedRectangle(cornerRadius: 16)
              .fill(Color(hex: article.backgroundColor) ?? .secondary.opacity(0.2))
              .frame(height: 100)
            Text(article.title)
              .font(.title2).bold()
              .multilineTextAlignment(.center)
              .padding()
          }
          
          if !article.tags.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
              HStack(spacing: 8) {
                ForEach(article.tags, id: \.self) { tag in
                  Text(tag)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Capsule().fill(Color.gray.opacity(0.15)))
                }
              }
            }
          }
        }
      }
    }
  }
}

// MARK: - Helpers

extension Color {
  init?(hex: String) {
    var hex = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#")).uppercased()
    guard hex.count == 6, let intVal = Int(hex, radix: 16) else { return nil }
    let r = Double((intVal >> 16) & 0xFF) / 255.0
    let g = Double((intVal >> 8) & 0xFF) / 255.0
    let b = Double(intVal & 0xFF) / 255.0
    self = Color(red: r, green: g, blue: b)
  }
}
