//
//  ContentView.swift
//  Articles
//
//  Created by org on 2025/09/07.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    var body: some View {
      RootTabView(
        store: Store(initialState: .init()) {
          RootTabReducer()
        }
      )
    }
}

#Preview {
    ContentView()
}
