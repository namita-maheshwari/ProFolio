import Combine
import Foundation

public protocol MessageRepository {
    func getMessages(for userId: String) -> AnyPublisher<[Message], Error>
    func sendMessage(_ message: Message) -> AnyPublisher<Void, Error>
}