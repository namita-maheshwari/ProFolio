import Combine
import Foundation

public protocol ConnectionRepository {
    func getConnections(for userId: String) -> AnyPublisher<[User], Error>
    func sendConnectionRequest(to userId: String) -> AnyPublisher<Void, Error>
    func acceptConnectionRequest(from userId: String) -> AnyPublisher<Void, Error>
}