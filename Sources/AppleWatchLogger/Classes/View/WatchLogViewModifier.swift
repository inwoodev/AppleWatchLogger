//
//  WatchLogViewModifier.swift
//  watch Extension
//
//  Created by 황인우 on 2023/08/09.
//

import SwiftUI

public struct WatchLogViewModifier: ViewModifier {
  private var logOpacity: Double
  private var draggableButtonOpacity: Double
  @State private var isLogMainView: Bool = false
  
  init(
    logOpacity: Double,
    draggableButtonOpacity: Double
  )
  {
    self.logOpacity = logOpacity
    self.draggableButtonOpacity = draggableButtonOpacity
  }
  
  public func body(content: Content) -> some View {
    #if DEBUG
    ZStack {
      content
      
      WatchLogView(
        logOpacity: logOpacity,
        isMainView: isLogMainView,
        onCancel: {
          withAnimation {
            isLogMainView = false
          }
        })
      
      AssistiveTouchButton(
        opacity: isLogMainView ? 0.0 : self.draggableButtonOpacity
      ) {
        withAnimation {
          self.isLogMainView = true
        }
      }
    }
    
    #else
    content
    
    #endif
  }
}


