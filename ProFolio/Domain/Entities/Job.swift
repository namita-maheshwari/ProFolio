import Foundation

public struct Job: Identifiable {
    public let id: String
    public let title: String
    public let company: String
    public let location: String
    public let description: String
    public let postedDate: Date
    public let isRemote: Bool
    
    public init(id: String, title: String, company: String, location: String, description: String, postedDate: Date, isRemote: Bool) {
        self.id = id
        self.title = title
        self.company = company
        self.location = location
        self.description = description
        self.postedDate = postedDate
        self.isRemote = isRemote
    }
}