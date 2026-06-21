import Combine
import Foundation

public final class DefaultMessageRepository: MessageRepository {
    private let remoteDataSource: MessageRemoteDataSource
    private let messageMapper: MessageMapper
    
    init(remoteDataSource: MessageRemoteDataSource, messageMapper: MessageMapper) {
        self.remoteDataSource = remoteDataSource
        self.messageMapper = messageMapper
    }
    
    public func getMessages(for userId: String) -> AnyPublisher<[Message], Error> {
        remoteDataSource.fetchMessages(userId: userId)
            .map { $0.map { self.messageMapper.toDomain($0) } }
            .eraseToAnyPublisher()
    }
    
    public func sendMessage(_ message: Message) -> AnyPublisher<Void, Error> {
        let dto = messageMapper.toDTO(message)
        return remoteDataSource.sendMessage(dto)
    }
}
