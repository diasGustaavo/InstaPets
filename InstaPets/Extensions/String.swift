import Foundation

extension String: Identifiable {
    public var id: String { self }
}

extension String {
  func toMarkdown() -> AttributedString {
    do {
      return try AttributedString(markdown: self)
    } catch {
      print("DEBUG: Error parsing Markdown for string \(self): \(error)")
      return AttributedString(self)
    }
  }
}
