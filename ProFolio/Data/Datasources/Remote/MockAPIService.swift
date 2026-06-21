import Combine
import Foundation

// This class conforms to all remote data source protocols and provides mock data.
class MockAPIService {
    private let decoder = JSONDecoder()
    private let delay: TimeInterval = 0.5
    
    // MARK: - Helper to load JSON from bundle
    private func loadJSON<T: Decodable>(_ filename: String, as type: T.Type) -> T? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("❌ Mock file \(filename).json not found")
            return nil
        }
        do {
            self.decoder.dateDecodingStrategy = .iso8601
            let data = try Data(contentsOf: url)
            return try decoder.decode(T.self, from: data)
        } catch {
            print("❌ Failed to decode \(filename): \(error)")
            return nil
        }
    }
    
    // Simulate network delay
    private func simulateNetwork<T>(_ publisher: AnyPublisher<T, Error>) -> AnyPublisher<T, Error> {
        publisher
            .delay(for: .seconds(delay), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension MockAPIService: FeedRemoteDataSource {
    func fetchFeed(page: Int) -> AnyPublisher<[PostDTO], Error> {
        // Load posts from mock JSON
        let posts: [PostDTO] = loadJSON("posts", as: [PostDTO].self) ?? []
        // Simulate pagination
        let pageSize = 10
        let start = page * pageSize
        let end = min(start + pageSize, posts.count)
        let paginated = Array(posts[start..<end])
        return simulateNetwork(Just(paginated).setFailureType(to: Error.self).eraseToAnyPublisher())
    }
}

extension MockAPIService: ProfileRemoteDataSource {
    func fetchUser(userId: String) -> AnyPublisher<UserDTO, Error> {
        let users: [UserDTO] = loadJSON("users", as: [UserDTO].self) ?? []
        let user = users.first { $0.id == userId } ?? users.first! // fallback to first
        return simulateNetwork(Just(user).setFailureType(to: Error.self).eraseToAnyPublisher())
    }
    
    func updateUser(_ user: UserDTO) -> AnyPublisher<Void, Error> {
        // Mock update – just succeed
        return simulateNetwork(Just(()).setFailureType(to: Error.self).eraseToAnyPublisher())
    }
}

extension MockAPIService: ConnectionRemoteDataSource {
    func fetchConnections(userId: String) -> AnyPublisher<[UserDTO], Error> {
        let users: [UserDTO] = loadJSON("users", as: [UserDTO].self) ?? []
        // Assuming connections are stored in the user's connections array.
        // For simplicity, we'll return all users except the current one.
        let others = users.filter { $0.id != userId }
        return simulateNetwork(Just(others).setFailureType(to: Error.self).eraseToAnyPublisher())
    }
    
    func sendRequest(to userId: String) -> AnyPublisher<Void, Error> {
        return simulateNetwork(Just(()).setFailureType(to: Error.self).eraseToAnyPublisher())
    }
    
    func acceptRequest(from userId: String) -> AnyPublisher<Void, Error> {
        return simulateNetwork(Just(()).setFailureType(to: Error.self).eraseToAnyPublisher())
    }
}

extension MockAPIService: JobRemoteDataSource {
    func fetchJobs() -> AnyPublisher<[JobDTO], Error> {
        let jobs: [JobDTO] = loadJSON("jobs", as: [JobDTO].self) ?? []
        return simulateNetwork(Just(jobs).setFailureType(to: Error.self).eraseToAnyPublisher())
    }
    
    func apply(to jobId: String) -> AnyPublisher<Void, Error> {
        return simulateNetwork(Just(()).setFailureType(to: Error.self).eraseToAnyPublisher())
    }
}

extension MockAPIService: MessageRemoteDataSource {
    func fetchMessages(userId: String) -> AnyPublisher<[MessageDTO], Error> {
        let messages: [MessageDTO] = loadJSON("messages", as: [MessageDTO].self) ?? []
        return simulateNetwork(Just(messages).setFailureType(to: Error.self).eraseToAnyPublisher())
    }
    
    func sendMessage(_ message: MessageDTO) -> AnyPublisher<Void, Error> {
        return simulateNetwork(Just(()).setFailureType(to: Error.self).eraseToAnyPublisher())
    }
}
