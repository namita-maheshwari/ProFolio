import Combine
import Foundation

public final class DefaultProfileRepository: ProfileRepository {
    private let remoteDataSource: ProfileRemoteDataSource
    private let userMapper: UserMapper
    
    init(remoteDataSource: ProfileRemoteDataSource, userMapper: UserMapper) {
        self.remoteDataSource = remoteDataSource
        self.userMapper = userMapper
    }
    
    public func getProfile(userId: String) -> AnyPublisher<User, Error> {
        remoteDataSource.fetchUser(userId: userId)
            .map { self.userMapper.toDomain($0) }
            .eraseToAnyPublisher()
    }
    
    public func updateProfile(user: User) -> AnyPublisher<Void, Error> {
        let dto = userMapper.toDTO(user)
        return remoteDataSource.updateUser(dto)
    }
}
