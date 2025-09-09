//
//  AppVersion.swift
//  MultiSimp
//
//  Created by org on 2025/08/09.
//

import Foundation
import Dependencies

public struct AppVersion: Sendable {
  public var current: String {
    Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
  }
}

extension AppVersion: DependencyKey {
  public static let liveValue = AppVersion()
}

public extension DependencyValues {
  var appVersion: AppVersion {
    get { self[AppVersion.self] }
    set { self[AppVersion.self] = newValue }
  }
}
