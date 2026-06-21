import Foundation

public struct Post: Identifiable {
    public let id: String
    public let author: User
    public let content: String
    public let timestamp: Date
    public let likes: Int
    public let comments: [Comment]
    
    public init(id: String, author: User, content: String, timestamp: Date, likes: Int, comments: [Comment]) {
        self.id = id
        self.author = author
        self.content = content
        self.timestamp = timestamp
        self.likes = likes
        self.comments = comments
    }
}