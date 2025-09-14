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
    VStack(alignment: .leading, spacing: 4) {
      Text(article.title)
        .font(.headline)
      Text(article.body)
        .font(.subheadline)
        .foregroundColor(.secondary)
        .lineLimit(1)
    }
  }
}

#Preview {
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
}
