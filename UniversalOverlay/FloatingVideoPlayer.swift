//
//  FloatingVideoPlayer.swift
//  UniversalOverlay
//
//  Created by Mohammed Rokon Uddin on 10/26/24.
//

import AVKit
import SwiftUI

struct FloatingVideoPlayer: View {
  @Binding var show: Bool
  @State private var player: AVPlayer?
  @State private var offset: CGSize = .zero
  @State private var lastStoreOffset: CGSize = .zero

  var body: some View {
    GeometryReader {
      let size = $0.size

      Group {
        if videoURL != nil {
          VideoPlayer(player: player)
            .background(.black)
            .clipShape(.rect(cornerRadius: 24))
        } else {
          RoundedRectangle(cornerRadius: 24)
        }
      }
      .overlay(alignment: .topTrailing) {
        Button {
          show = false
        } label: {
          Image(systemName: "xmark.circle.fill")
            .font(.title)
            .foregroundStyle(.white.opacity(0.3))
            .offset(x: -8, y: 8)
        }

      }
      .frame(height: 246)
      .offset(offset)
      .gesture(
        DragGesture()
          .onChanged { value in
            let translation = value.translation + lastStoreOffset
            offset = translation
          }.onEnded { value in
            withAnimation(.bouncy) {
              offset.width = 0

              if offset.height < 0 {
                offset.height = 0
              }

              if offset.height > (size.height - 246) {
                offset.height = (size.height - 246)
              }

              lastStoreOffset = offset
            }
          }
      )
      .frame(maxHeight: .infinity, alignment: .top)
    }
    .padding(.horizontal, 16)
    .transition(.blurReplace)
    .onAppear {
      if let videoURL {
        player = AVPlayer(url: videoURL)
        player?.play()
      }
    }
  }

  private var videoURL: URL? {
    guard let path = Bundle.main.path(forResource: "Rango", ofType: "mp4") else { return nil }
    return URL(fileURLWithPath: path)
  }
}

extension CGSize {
  static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
    return .init(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
  }
}
