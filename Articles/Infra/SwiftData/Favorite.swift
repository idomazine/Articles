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
  @Attribute(.unique) var id: Int
  var title: String
  var createdAt: Date
  
  init(id: Int, title: String, createdAt: Date) {
    self.id = id
    self.title = title
    self.createdAt = createdAt
  }
}
