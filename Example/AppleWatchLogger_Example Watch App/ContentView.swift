//
//  ContentView.swift
//  AppleWatchLogger_Example Watch App
//
//  Created by 황인우 on 2023/08/21.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import AppleWatchLogger
import SwiftUI

enum LogError: Error {
  case unsureError
  case fatalError
}

struct ContentView: View {
  var body: some View {
    VStack {
      Image(systemName: "applewatch")
        .imageScale(.large)
        .foregroundColor(.accentColor)
      
      Text("Introducing Apple Watch Logger!!")
        .multilineTextAlignment(.center)
    }
    .onAppear {
      print("content view on appear")
      DispatchQueue.main.async {
        AppleWatchLogger.info(message: "I developed this library in response to the difficulties I faced while attempting to debug both an Apple Watch app and an iOS app concurrently.")
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        AppleWatchLogger.verbose(message: "Debugging on iOS is typically straightforward, utilizing tools like print statements or OSLog to aid in troubleshooting via LLDB. However, the complexity increases when simultaneously working on both iOS and watchOS. Debugging the watchOS component becomes particularly challenging. Traditional debugging approaches like prints or logs are practically ineffective when trying to debug watchOS via LLDB, especially when both the iOS and watchOS apps are running concurrently. While communication methods like WCSession's sendMessage can be employed, resorting to these techniques solely for debugging purposes seems inefficient.")
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
        AppleWatchLogger.success(message: "To address this challenge, I developed a library aimed at assisting iOS developers in streamlining the debugging process for Apple Watch apps. For individuals facing the need to access real-time debugging messages, I introduced a feature: a translucent debugging list that remains visible alongside the main app interface. The feature allows developers to monitor and interact with debugging information conveniently while simultaneously engaging with the primary application on the Apple Watch.")
      }
      
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
        AppleWatchLogger.warning(message: "In addition, the library offers a draggable assistive touch button that empowers developers to access more comprehensive log information effortlessly. The decision to make this button draggable stems from the confined screen space available on the watch. The rationale behind this design choice is that affixing the button to a fixed position could lead to an inconvenience. If the button were stationary and happened to obstruct critical information or areas requiring interaction, developers might find the library less effective. To circumvent this potential hindrance, I implemented the drag-and-drop functionality. This way, if the detail button interferes with the view or interaction in any way, developers have the freedom to relocate the button to a more suitable location on the screen. This approach aims to enhance the overall usability of the library while catering to the limitations of the watch's display area.")
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
        AppleWatchLogger.unsure(message: "Like conventional loggers, the appleWatchLogger also offers a range of message levels. These levels are distinguishable through both color emoji and distinct text identifiers. You are welcome to utilize this functionality as per your requirements and preferences. Whether you need to categorize messages for different purposes or ensure clarity in the log display, the flexibility of message levels is at your disposal to enhance your debugging experience. Feel free to take advantage of this feature in a manner that aligns with your convenience and development objectives.", error: LogError.unsureError)
      }
      
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
