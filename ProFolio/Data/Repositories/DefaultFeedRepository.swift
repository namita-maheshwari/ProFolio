import Combine
import Foundation

public final class DefaultFeedRepository: FeedRepository {
    private let remoteDataSource: FeedRemoteDataSource
    private let postMapper: PostMapper
    private let userMapper: UserMapper
    private var userCache: [String: User] = [:]
    
    init(remoteDataSource: FeedRemoteDataSource, postMapper: PostMapper, userMapper: UserMapper) {
        self.remoteDataSource = remoteDataSource
        self.postMapper = postMapper
        self.userMapper = userMapper
    }
    
    public func getFeed(page: Int) -> AnyPublisher<[Post], Error> {
        // First fetch all users to build cache (simplified: we need users for authors/comments)
        // In a real scenario, we would have a separate user repository.
        // For simplicity, we load users from a mock file here.
        let usersDTO: [UserDTO] = (Bundle.main.url(forResource: "users", withExtension: "json")
            .flatMap { try? Data(contentsOf: $0) }
            .flatMap { try? JSONDecoder().decode([UserDTO].self, from: $0) }) ?? []
        let users = Dictionary(uniqueKeysWithValues: usersDTO.map { ($0.id, userMapper.toDomain($0)) })
        
        return remoteDataSource.fetchFeed(page: page)
            .map { postDTOs -> [Post] in
                postDTOs.map { self.postMapper.toDomain($0, users: users) }
            }
            .eraseToAnyPublisher()
    }
}
