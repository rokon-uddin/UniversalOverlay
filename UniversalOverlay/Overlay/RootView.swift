//
//  RootView.swift
//  UniversalOverlay
//
//  Created by Mohammed Rokon Uddin on 10/26/24.
//

import SwiftUI

struct RootView<Content: View>: View {
  var content: Content
  private var model = UniversalOverlayModel()

  init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content()
  }

  var body: some View {
    content
      .environment(model)
      .onAppear {
        if let windowScene = (UIApplication.shared.connectedScenes.first as? UIWindowScene), model.window == nil {
          let window = PassThroughWindow(windowScene: windowScene)
          window.isHidden = false
          window.isUserInteractionEnabled = true

          let rootViewController = UIHostingController(rootView: UniversalOverlayView().environment(model))
          rootViewController.view.backgroundColor = .clear
          window.rootViewController = rootViewController
          model.window = window
        }
      }
  }
}
