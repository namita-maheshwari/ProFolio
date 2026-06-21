import Foundation

// DTO
struct UserDTO: Decodable {
    let id: String
    let name: String
    let headline: String
    let profilePictureURL: String
    let email: String
    let connections: [String]?
}

struct UserMapper {
    func toDomain(_ dto: UserDTO) -> User {
        User(id: dto.id,
             name: dto.name,
             headline: dto.headline,
             profilePictureURL: dto.profilePictureURL,
             email: dto.email,
             connections: dto.connections)
    }
    
    func toDTO(_ domain: User) -> UserDTO {
        UserDTO(id: domain.id,
                name: domain.name,
                headline: domain.headline,
                profilePictureURL: domain.profilePictureURL,
                email: domain.email,
                connections: domain.connections)
    }
}
