import Foundation

public struct Comment: Identifiable {
    public let id: String
    public let author: User
    public let text: String
    public let timestamp: Date
    
    public init(id: String, author: User, text: String, timestamp: Date) {
        self.id = id
        self.author = author
        self.text = text
        self.timestamp = timestamp
    }
}