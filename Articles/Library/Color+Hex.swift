//
//  Color+Hex.swift
//  Articles
//
//  Created by org on 2025/09/14.
//

import Foundation
import SwiftUI

extension Color {
  init?(hex: String) {
    let hex = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#")).uppercased()
    guard hex.count == 6, let intVal = Int(hex, radix: 16) else { return nil }
    let r = Double((intVal >> 16) & 0xFF) / 255.0
    let g = Double((intVal >> 8) & 0xFF) / 255.0
    let b = Double(intVal & 0xFF) / 255.0
    self = Color(red: r, green: g, blue: b)
  }
}
