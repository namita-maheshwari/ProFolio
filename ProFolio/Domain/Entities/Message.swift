import Foundation

public struct Message: Identifiable {
    public let id: String
    public let senderId: String
    public let receiverId: String
    public let text: String
    public let timestamp: Date
    public let isRead: Bool
    
    public init(id: String, senderId: String, receiverId: String, text: String, timestamp: Date, isRead: Bool) {
        self.id = id
        self.senderId = senderId
        self.receiverId = receiverId
        self.text = text
        self.timestamp = timestamp
        self.isRead = isRead
    }
}