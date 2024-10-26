//
//  PassThroughWindow.swift
//  UniversalOverlay
//
//  Created by Mohammed Rokon Uddin on 10/26/24.
//

import SwiftUI

class PassThroughWindow: UIWindow {
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    guard let hitView = super.hitTest(point, with: event),
      let rootView = rootViewController?.view
    else { return nil }

    if #available(iOS 18, *) {
      for subView in rootView.subviews.reversed() {
        let pointInSubView = subView.convert(point, from: rootView)
        if subView.hitTest(pointInSubView, with: event) == subView {
          return hitView
        }
      }
      return nil
    } else {
      return hitView == rootView ? nil : hitView
    }
  }
}
