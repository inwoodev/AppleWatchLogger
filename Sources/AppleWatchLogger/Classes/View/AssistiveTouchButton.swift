//
//  AssistiveTouchButton.swift
//  AppleWatchLogger
//
//  Created by 황인우 on 2023/08/22.
//

import SwiftUI

struct AssistiveTouchButton: View {
  @State private var dragAmount: CGPoint?
  var buttonSize: CGSize
  private var opacity: Double
  private var onPress: () -> Void
  
  init(
    buttonSize: CGSize = .init(width: 50, height: 50),
    opacity: Double,
    onPress: @escaping(() -> Void)
  ) {
    self.buttonSize = buttonSize
    self.opacity = opacity
    self.onPress = onPress
  }
  
  var body: some View {
    GeometryReader { geometry in
      assistiveCircleButton
        .frame(width: buttonSize.width, height: buttonSize.height)
        .animation(.none, value: dragAmount)
        .position(
          dragAmount ??
          CGPoint(
            x: geometry.size.width - (buttonSize.width / 1.5),
            y: geometry.size.height - (buttonSize.height / 2))
        )
        .highPriorityGesture(
          DragGesture()
            .onChanged { drag in
              withAnimation {
                self.dragAmount = drag.location
              }
            }
            .onEnded { value in
              var endPosition = value.location
              
              if endPosition.y <= (geometry.size.height * 0.25) {
                endPosition.y = (buttonSize.height / 2)
              }
              
              // bottom calibration
              if endPosition.y >= (geometry.size.height * 0.75) {
                endPosition.y = geometry.size.height - (buttonSize.height / 2)
              }
              
              self.dragAmount = endPosition
            }
        )
    }
  }
  
  private var assistiveCircleButton: some View {
    Button(action: onPress) {
      Circle()
        .opacity(self.opacity)
    }
    .background(Color.black)
    .frame(width: buttonSize.width, height: buttonSize.height)
    .clipShape(Circle())
    .opacity(self.opacity)
  }
  
}

struct DraggableButton_Previews: PreviewProvider {
  static var previews: some View {
    AssistiveTouchButton(opacity: 0.5) {
      
    }
  }
}


