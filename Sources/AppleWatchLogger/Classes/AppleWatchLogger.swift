import SwiftUI

public var AppleWatchLogger = ObservableLogger.shared

final public class ObservableLogger: ObservableObject {
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
  
  struct Event: Identifiable {
    let id: UUID
    let date: Date
    let level: Level
    let title: String?
    let message: String
    let error: Error?
    let file: StaticString
    let line: Int
    
    let dateString: String
    let timeString: String
    
    init(
      level: Level,
      title: String? = nil,
      message: String,
      error: Error?,
      date: Date,
      timeFormat: String = "hh:mm:ss.sss",
      dateFormat: String = "yyyy-MM-dd",
      timeZone: TimeZone = TimeZone.current,
      locale: Locale = Locale.current,
      _ file: StaticString = #file,
      _ line: Int = #line
    ) {
      self.id = UUID()
      self.date = date
      self.level = level
      self.title = title
      self.message = message
      self.error = error
      self.file = file
      self.line = line
      
      let timeFormatter = DateFormatter()
      timeFormatter.dateFormat = timeFormat
      timeFormatter.timeZone = timeZone
      timeFormatter.locale = locale
      
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = dateFormat
      dateFormatter.timeZone = timeZone
      dateFormatter.locale = locale
      
      self.timeString = timeFormatter.string(from: date)
      self.dateString = dateFormatter.string(from: date)
    }
  }
  
  static public var shared: ObservableLogger = ObservableLogger()
  
  private let lock: NSLock = .init()
  private let name: String?
  
  private let dateFormat: String
  private let timeFormat: String
  private let timeZone: TimeZone
  private let locale: Locale
  
  @Published private (set) var logs: [Event]
  
  private init(
    name: String? = nil,
    logs: [Event] = [],
    dateFormat: String = "yyyy-MM-dd",
    timeFormat: String = "hh:mm:ss.sss",
    timeZone: TimeZone = TimeZone.current,
    locale: Locale = Locale.current
  ) {
    self.name = name
    self.logs = logs
    self.dateFormat = dateFormat
    self.timeFormat = timeFormat
    self.timeZone = timeZone
    self.locale = locale
  }
  
  public func log(
    level: Level,
    title: String? = nil,
    message: String,
    error: Error? = nil,
    _ file: StaticString = #fileID,
    _ line: Int = #line
  ) {
    guard Thread.current.isMainThread else {
      return DispatchQueue.main.async {
        self.log(
          level: level,
          title: title,
          message: message,
          error: error,
          file,
          line
        )
      }
    }
    
    lock.lock()
    defer { lock.unlock() }
    
    logs.append(
      Event(
        level: level,
        title: title,
        message: message,
        error: error,
        date: .init(),
        file,
        line
      )
    )
  }
  
  public func verbose(
    title: String? = nil,
    message: String,
    _ file: StaticString = #fileID,
    _ line: Int = #line
  ) {
    self.log(
      level: .verbose,
      title: title,
      message: message,
      file,
      line
    )
  }
  
  public func success(
    title: String? = nil,
    message: String,
    _ file: StaticString = #fileID,
    _ line: Int = #line
  ) {
    self.log(
      level: .success,
      title: title,
      message: message,
      file,
      line
    )
  }
  
  public func unsure(
    title: String? = nil,
    message: String,
    error: Error?,
    _ file: StaticString = #fileID,
    _ line: Int = #line
  ) {
    self.log(
      level: .unsure,
      title: title,
      message: message,
      error: error,
      file,
      line
    )
  }
  
  public func info(
    title: String? = nil,
    message: String,
    _ file: StaticString = #fileID,
    _ line: Int = #line
  ) {
    self.log(
      level: .info,
      title: title,
      message: message,
      file,
      line
    )
  }
  
  public func warning(
    title: String? = nil,
    message: String,
    _ file: StaticString = #fileID,
    _ line: Int = #line
  ) {
    self.log(
      level: .warning,
      title: title,
      message: message,
      file,
      line
    )
  }
  
  public func error(
    title: String? = nil,
    message: String,
    error: Error?,
    _ file: StaticString = #fileID,
    _ line: Int = #line
  ) {
    self.log(
      level: .error,
      title: title,
      message: message,
      error: error,
      file,
      line
    )
  }
  
  public func fatal(
    title: String? = nil,
    message: String,
    error: Error?,
    _ file: StaticString = #fileID,
    _ line: Int = #line
  ) {
    self.log(
      level: .fatalError,
      title: title,
      message: message,
      error: error,
      file,
      line
    )
  }
}
