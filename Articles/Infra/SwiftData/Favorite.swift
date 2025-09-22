//
//  Favorite.swift
//  Articles
//
//  Created by org on 2025/09/15.
//

import Foundation
import SwiftData

@Model
final class Favorite {
  @Attribute(.unique) var articleId: Int
  var title: String
  var createdAt: Date
  
  init(
    articleId: Int,
    title: String,
    createdAt: Date
  ) {
    self.articleId = articleId
    self.title = title
    self.createdAt = createdAt
  }
}
