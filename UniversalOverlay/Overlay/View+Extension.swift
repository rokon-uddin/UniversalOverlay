//
//  View+Extension.swift
//  UniversalOverlay
//
//  Created by Mohammed Rokon Uddin on 10/26/24.
//

import SwiftUI

extension View {
  @ViewBuilder
  func universalOverlay<Content: View>(
    animated: Animation = .snappy,
    show: Binding<Bool>,
    @ViewBuilder content: @escaping () -> Content
  ) -> some View {
    self
      .modifier(
        UniversalOverlayModifier(
          animation: animated,
          show: show,
          viewContent: content))
  }
}
