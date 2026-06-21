import Combine
import Foundation

public final class DefaultConnectionRepository: ConnectionRepository {
    private let remoteDataSource: ConnectionRemoteDataSource
    private let userMapper: UserMapper
    
    init(remoteDataSource: ConnectionRemoteDataSource, userMapper: UserMapper) {
        self.remoteDataSource = remoteDataSource
        self.userMapper = userMapper
    }
    
    public func getConnections(for userId: String) -> AnyPublisher<[User], Error> {
        remoteDataSource.fetchConnections(userId: userId)
            .map { $0.map { self.userMapper.toDomain($0) } }
            .eraseToAnyPublisher()
    }
    
    public func sendConnectionRequest(to userId: String) -> AnyPublisher<Void, Error> {
        remoteDataSource.sendRequest(to: userId)
    }
    
    public func acceptConnectionRequest(from userId: String) -> AnyPublisher<Void, Error> {
        remoteDataSource.acceptRequest(from: userId)
    }
}
