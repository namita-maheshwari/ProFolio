import Combine
import Foundation

public final class ConnectionUseCase {
    private let repository: ConnectionRepository
    
    public init(repository: ConnectionRepository) {
        self.repository = repository
    }
    
    public func getConnections(for userId: String) -> AnyPublisher<[User], Error> {
        repository.getConnections(for: userId)
    }
    
    public func sendRequest(to userId: String) -> AnyPublisher<Void, Error> {
        repository.sendConnectionRequest(to: userId)
    }
    
    public func acceptRequest(from userId: String) -> AnyPublisher<Void, Error> {
        repository.acceptConnectionRequest(from: userId)
    }
}