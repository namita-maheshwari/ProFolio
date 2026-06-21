import Foundation

public struct User: Identifiable {
    public let id: String
    public let name: String
    public let headline: String
    public let profilePictureURL: String
    public let email: String
    public let connections: [String]? // IDs of connected users
    
    public init(id: String, name: String, headline: String, profilePictureURL: String, email: String, connections: [String]? = nil) {
        self.id = id
        self.name = name
        self.headline = headline
        self.profilePictureURL = profilePictureURL
        self.email = email
        self.connections = connections
    }
}