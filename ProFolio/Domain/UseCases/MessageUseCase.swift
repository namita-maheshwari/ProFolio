import Combine
import Foundation

public final class MessageUseCase {
    private let repository: MessageRepository
    
    public init(repository: MessageRepository) {
        self.repository = repository
    }
    
    public func getMessages(for userId: String) -> AnyPublisher<[Message], Error> {
        repository.getMessages(for: userId)
    }
    
    public func sendMessage(_ message: Message) -> AnyPublisher<Void, Error> {
        repository.sendMessage(message)
    }
}