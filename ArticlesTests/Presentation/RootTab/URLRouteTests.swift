//
//  URLRouteTests.swift
//  ArticlesTests
//
//  Created by org on 2025/09/18.
//

import Foundation
import Testing
import CasePaths

@testable import Articles

private func route(_ s: String) -> URLRoute? {
  guard let url = URL(string: s) else { return nil }
  return URLRoute(url: url)
}

struct URLRouteCasePathsTests {
  @Test
  func articlesList() {
    #expect(
      (/URLRoute.articlesList).extract(from: route("articles://articles")) != nil
    )
  }
  
  @Test
  func article_withID() {
    let extractedID = (/URLRoute.article).extract(from: route("articles://articles/42")!)
    #expect(extractedID == 42)
  }
  
  @Test
  func favoritesList() {
    #expect(
      (/URLRoute.favoritesList).extract(from: route("articles://favorites")) != nil
    )
  }
  
  @Test
  func profile() {
    #expect(
      (/URLRoute.profile).extract(from: route("articles://profile")) != nil
    )
  }
  
  @Test
  func malformedID_returnsNil() {
    #expect(
      (/URLRoute.article).extract(from: route("articles://articles/abc")!) == nil
    )
  }
}
