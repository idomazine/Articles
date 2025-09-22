//
//  Comment.swift
//  Articles
//
//  Created by org on 2025/09/22.
//

import Foundation
import SwiftData

@Model
final class Comment {
  var articleId: Int
  var body: String
  var createdAt: Date
  
  init(
    articleId: Int,
    body: String,
    createdAt: Date
  ) {
    self.articleId = articleId
    self.body = body
    self.createdAt = createdAt
  }
}
