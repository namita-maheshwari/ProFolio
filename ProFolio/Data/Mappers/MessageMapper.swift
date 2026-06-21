import Foundation

struct MessageDTO: Decodable {
    let id: String
    let senderId: String
    let receiverId: String
    let text: String
    let timestamp: Date
    let isRead: Bool
}

struct MessageMapper {
    func toDomain(_ dto: MessageDTO) -> Message {
        Message(id: dto.id,
                senderId: dto.senderId,
                receiverId: dto.receiverId,
                text: dto.text,
                timestamp: dto.timestamp,
                isRead: dto.isRead)
    }
    
    func toDTO(_ domain: Message) -> MessageDTO {
        MessageDTO(id: domain.id,
                   senderId: domain.senderId,
                   receiverId: domain.receiverId,
                   text: domain.text,
                   timestamp: domain.timestamp,
                   isRead: domain.isRead)
    }
}
