# AppleWatchLogger
![Static Badge](https://img.shields.io/badge/platform-watchOS-blue)
![Static Badge](https://img.shields.io/badge/watchOS-7.0%2B-blue)
![Static Badge](https://img.shields.io/badge/Cocoapods-compatible-green)

## Introducing Apple Watch Logger
I developed this library in response to the difficulties I faced while attempting to debug both an Apple Watch app and an iOS app concurrently.

Debugging on iOS is typically straightforward, utilizing tools like print statements or OSLog to aid in troubleshooting via LLDB. However, the complexity increases when simultaneously working on both iOS and watchOS. Debugging the watchOS component becomes particularly challenging. Traditional debugging approaches like prints or logs are practically ineffective when trying to debug watchOS via LLDB, especially when both the iOS and watchOS apps are running concurrently. While communication methods like WCSession's `sendMessage` can be employed, resorting to these techniques solely for debugging purposes seems inefficient.

![Simulator Screen Recording - Apple Watch Series 8 (45mm) - 2023-08-27 at 19 51 26](https://github.com/inwoodev/AppleWatchLogger/assets/69072471/afd23edb-8ca4-4cfa-824b-924b55f37fbc)

To address this challenge, I developed a library aimed at assisting iOS developers in streamlining the debugging process for Apple Watch apps. For individuals facing the need to access real-time debugging messages, I introduced a feature: a translucent debugging list that remains visible alongside the main app interface. The feature allows developers to monitor and interact with debugging information conveniently while simultaneously engaging with the primary application on the Apple Watch.

---

![Simulator Screen Recording - Apple Watch Series 8 (45mm) - 2023-08-27 at 19 52 59](https://github.com/inwoodev/AppleWatchLogger/assets/69072471/da3dc8bf-6bb5-4985-9f95-56769a31236a)


In addition, the library offers a draggable assistive touch button that empowers developers to access more comprehensive log information effortlessly. The decision to make this button draggable stems from the confined screen space available on the watch. The rationale behind this design choice is that affixing the button to a fixed position could lead to an inconvenience. If the button were stationary and happened to obstruct critical information or areas requiring interaction, developers might find the library less effective. To circumvent this potential hindrance, I implemented the drag-and-drop functionality. This way, if the detail button interferes with the view or interaction in any way, developers have the freedom to relocate the button to a more suitable location on the screen. This approach aims to enhance the overall usability of the library while catering to the limitations of the watch's display area.

---

![Simulator Screen Recording - Apple Watch Series 8 (45mm) - 2023-08-27 at 19 56 41](https://github.com/inwoodev/AppleWatchLogger/assets/69072471/3541f487-f4c1-4590-a9f5-9a3afb609de1)

Like conventional loggers, the appleWatchLogger also offers a range of message levels. These levels are distinguishable through both color emoji and distinct text identifiers. You are welcome to utilize this functionality as per your requirements and preferences. Whether you need to categorize messages for different purposes or ensure clarity in the log display, the flexibility of message levels is at your disposal to enhance your debugging experience. Feel free to take advantage of this feature in a manner that aligns with your convenience and development objectives.

## Installation

AppleWatchLogger is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AppleWatchLogger'
```


#### **Be careful**
Ensure that you add the line pod 'AppleWatchLogger' to the **watch target** in your Podfile. Otherwise, you might encounter errors such as the following:

```ruby
[!] The platform of the target `YourProject` is not compatible with `AppleWatchLogger (0.1.0)`, which does not support `iOS`.

```

## Usage

### Creating a AppleWatchLogView

To integrate a LogView into your project, follow these steps:

1. Import the AppleWatchLogger module into your target project.
2. Use the `.appleWatchLog()` view modifier.

```swift
import AppleWatchLogger
import SwiftUI

@main
struct AppleWatchLogger_Example_Watch_App: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .appleWatchLog()
    }
  }
}
```
With these steps, you've integrated the AppleWatchLogView into your app's view side.

---

### Implementing AppleWatchLogger
You can implement AppleWatchLogger in various parts of your code, such as ViewModel, Repository, or Service layers. The location doesn't matter as long as you import the AppleWatchLogger module.

``` swift
import AppleWatchLogger
import Foundation

final class ExampleRepository {
  func wantVisualLog() {
    AppleWatchLogger.info(message: "Want to debug, but don't want to create extra view")
  }
}
```

---

### Log Level
AppleWatchLogger supports various levels of logging, each represented by an emoji and text:
``` swift
public enum Level: String {
    case verbose, success, unsure, info, warning, error, fatalError
    
    var emoji: Character {
      switch self {
      case .verbose:      return "⚫"
      case .success:      return "🟢"
      case .unsure:       return "🟣"
      case .info:         return "🔵"
      case .warning:      return "🟡"
      case .error:        return "🟠"
      case .fatalError:   return "🔴"
      }
    }
  }
```
With these log levels, you can easily differentiate and identify the severity of each logged message in your debugging process.

## Author

inwoodev, dlsdn1207@gmail.com

## License

AppleWatchLogger is available under the MIT license. See the LICENSE file for more info.
