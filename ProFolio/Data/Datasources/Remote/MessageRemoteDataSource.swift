import Combine
import Foundation

protocol MessageRemoteDataSource {
    func fetchMessages(userId: String) -> AnyPublisher<[MessageDTO], Error>
    func sendMessage(_ message: MessageDTO) -> AnyPublisher<Void, Error>
}