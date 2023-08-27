//
//  View+Extension.swift
//  AppleWatchLogger
//
//  Created by 황인우 on 2023/08/26.
//

import SwiftUI

// MARK: - Internal
extension View {
  func hiddenIf(_ shouldHide: Bool) -> some View {
    opacity(shouldHide ? 0 : 1)
  }
}

// MARK: - Public
public extension View {
  func appleWatchLog(
    logViewOpacity: Double = 0.2,
    draggableButtonOpacity: Double = 0.4
  ) -> some View {
    modifier(
      WatchLogViewModifier(
        logOpacity: logViewOpacity,
        draggableButtonOpacity: draggableButtonOpacity
      )
    )
  }
}
