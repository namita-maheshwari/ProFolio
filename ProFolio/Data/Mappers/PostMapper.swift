import Foundation

// DTOs
struct CommentDTO: Decodable {
    let id: String
    let authorId: String
    let text: String
    let timestamp: Date
}

struct PostDTO: Decodable {
    let id: String
    let authorId: String
    let content: String
    let timestamp: Date
    let likes: Int
    let comments: [CommentDTO]
}

class PostMapper {
    private let userMapper = UserMapper()
    private var userCache: [String: User] = [:]
    
    func toDomain(_ dto: PostDTO, users: [String: User]) -> Post {
        let author = users[dto.authorId] ?? User(id: dto.authorId, name: "Unknown", headline: "", profilePictureURL: "", email: "")
        let comments = dto.comments.map { commentDTO -> Comment in
            let author = users[commentDTO.authorId] ?? User(id: commentDTO.authorId, name: "Unknown", headline: "", profilePictureURL: "", email: "")
            return Comment(id: commentDTO.id, author: author, text: commentDTO.text, timestamp: commentDTO.timestamp)
        }
        return Post(id: dto.id,
                    author: author,
                    content: dto.content,
                    timestamp: dto.timestamp,
                    likes: dto.likes,
                    comments: comments)
    }
}
