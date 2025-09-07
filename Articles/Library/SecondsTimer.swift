//
//  SecondsTimer.swift
//  Articles
//
//  Created by org on 2025/09/07.
//

import Foundation

public struct SecondsTimer {
  public init() {}
  
  public func wait(seconds: Int) async {
    try? await Task.sleep(nanoseconds: UInt64(seconds) * 1_000_000_000)
  }
}
