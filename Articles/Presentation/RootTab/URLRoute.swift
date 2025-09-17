//
//  URLRoute.swift
//  Articles
//
//  Created by org on 2025/09/18.
//

import Foundation
import CasePaths

@CasePathable
enum URLRoute: Equatable {
  case articlesList
  case article(id: Int)
  case favoritesList
  case profile
  
  init?(url: URL) {
    guard url.scheme == "articles",
          let host = url.host else { return nil }
    
    switch host {
    case "articles":
      if url.pathComponents.count == 2,
         let id = Int(url.pathComponents[1]) {
        self = .article(id: id)
      } else {
        self = .articlesList
      }
    case "favorites":
      self = .favoritesList
    case "profile":
      self = .profile
    default:
      return nil
    }
  }
}
