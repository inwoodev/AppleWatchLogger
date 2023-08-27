//
//  WatchLogView.swift
//  watch Extension
//
//  Created by 황인우 on 2023/08/09.
//

import SwiftUI

struct WatchLogView: View {
  @StateObject private var watchLogger: ObservableLogger = .shared
  private var logOpacity: Double
  private var isMainView: Bool
  private var showsIndicator: Bool
  
  private var onCancel: () -> Void
  
  @State private var selectedLogEvent: ObservableLogger.Event?
  
  init(
    logOpacity: Double,
    isMainView: Bool,
    showsIndicator: Bool = false,
    onCancel: @escaping () -> Void
  ) {
    self.logOpacity = logOpacity
    self.isMainView = isMainView
    self.showsIndicator = showsIndicator
    self.onCancel = onCancel
  }
  
  @State private var isDetailViewPresent: Bool = false
  
  var body: some View {
    NavigationView {
      ScrollViewReader { proxy in
        ScrollView(showsIndicators: self.showsIndicator) {
          ForEach(watchLogger.logs, id: \.id) {
            logEvent in
            Button {
              isDetailViewPresent = true
              selectedLogEvent = logEvent
            } label: {
              logRowView(of: logEvent)
            }

          }
        }
        .fullScreenCover(item: $selectedLogEvent, content: { logEvent in
          logDetailView(logEvent)
        })
        .disabled(!isMainView)
        .onChange(of: watchLogger.logs.count) { _ in
          if let lastEvent = watchLogger.logs.last {
            withAnimation(.easeIn) {
              proxy.scrollTo(lastEvent.id)
            }
          }
        }
      }
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Blur Log", action: onCancel)
            .opacity(isMainView ? 1.0 : 0.0)
        }
      }
    }
    .opacity(isMainView ? 1.0 : logOpacity)
  }
  
  private func logDetailView(_ logEvent: ObservableLogger.Event) -> some View {
    ScrollView {
      VStack {
        HStack(alignment: .top) {
          Text("\(logEvent.level.emoji.description) [\(logEvent.level.rawValue)]")
          Spacer()
          Text("\(logEvent.title ?? "")")
        }
        .padding(.top, 10)
        
        
        Rectangle()
          .frame(height: 1)
        
        Text("Description:")
          .frame(maxWidth: .infinity, alignment: .leading)
        Text("\(logEvent.message)")
          .frame(maxWidth: .infinity, alignment: .leading)
        
        Rectangle()
          .frame(height: 1)
        
        HStack {
          Text("Date:")
          Spacer()
          Text("\(logEvent.dateString)")
        }
        
        
        Rectangle()
          .frame(height: 1)
        
        HStack {
          Text("Time:")
          Spacer()
          Text("\(logEvent.timeString)")
        }
        
        Rectangle()
          .frame(height: 1)
        
        Text("File: \(logEvent.file.description)[Line:\(logEvent.line)]")
          .frame(
            maxWidth: .infinity,
            alignment: .leading
          )
        
      }
    }
  }
  
  private func logRowView(of logEvent: ObservableLogger.Event) -> some View {
    VStack(alignment: .leading) {
      Text("🕓 \(logEvent.timeString)")
      
      HStack {
        Text("\(logEvent.level.emoji.description) \(logEvent.title ?? logEvent.message)")
      }
    }
    .lineLimit(1)
  }
}

struct LogView_Previews: PreviewProvider {
  static var previews: some View {
    WatchLogView(logOpacity: 0.2, isMainView: true) {
      
    }
  }
}
