//
//  ContentView.swift
//  UniversalOverlay
//
//  Created by Mohammed Rokon Uddin on 10/26/24.
//

import SwiftUI

struct ContentView: View {
  @State var show: Bool = false
  @State var showSheet: Bool = false
  var body: some View {
    NavigationStack {
      List {
        Button("Floating Video Player") {
          show.toggle()
        }
        .universalOverlay(show: $show) {
          FloatingVideoPlayer(show: $show)
        }

        Button("Show A Sheet") {
          showSheet.toggle()
        }
      }
      .navigationBarTitle("Universal Overlay")
    }
    .sheet(isPresented: $showSheet) {
      Text("Hello From Sheet")
    }
  }
}

#Preview {
  RootView {
    ContentView()
  }
}
