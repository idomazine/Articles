//
//  RootTab.swift
//  MultiSimp
//
//  Created by org on 2025/08/09.
//

import SwiftUI
import ComposableArchitecture

struct RootTabView: View {
  @Bindable var store: StoreOf<RootTabReducer>
  
  var body: some View {
    TabView(selection: $store.selectedTab.sending(\.selectTab)) {
      NavigationStack {
        ArticlesListView(store: store.scope(state: \.articles,
                                            action: \.articles))
      }
      .tabItem {
        Label("ニュース", systemImage: "book.closed")
      }
      .tag(RootTabReducer.Tab.books)
      
      NavigationStack {
        ProfileView(store: store.scope(state: \.profile,
                                       action: \.profile))
      }
      .tabItem {
        Label("プロフィール", systemImage: "person.crop.circle")
      }
      .tag(RootTabReducer.Tab.profile)
    }
  }
}

#Preview {
  RootTabView(
    store: Store(initialState: .init()) {
      RootTabReducer()
    }
  )
}
