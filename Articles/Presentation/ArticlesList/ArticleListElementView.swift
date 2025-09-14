//
//  ArticleListElementView.swift
//  Articles
//
//  Created by org on 2025/09/14.
//

import Foundation
import SwiftUI

struct ArticleListElementView: View {
  let article: ArticlesListContentReducer.Article
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(article.title)
        .font(.headline)
      Text(article.body)
        .font(.subheadline)
        .foregroundColor(.secondary)
        .lineLimit(1)
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 12, style: .continuous)
        .fill(Color(.systemBackground))
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    )
    .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    .listRowSeparator(.hidden)
  }
}

#Preview {
  List {
    ArticleListElementView(article: .init(
      id: 1,
      title: "再生可能エネルギーで画期的な進展を達成",
      body: """
        科学者たちが前例のない効率を持つ新しい太陽電池技術を開発。
        この進歩によりエネルギー供給の持続可能性が大きく向上する。
        専門家は今後10年で実用化が進むと予測している。
        """,
      backgroundColor: "#FFAA00",
      tags: ["環境", "科学"]
    ))
    .listRowBackground(Color.clear)
    .listRowSeparator(.hidden)
  }
  .listStyle(.plain)
}
