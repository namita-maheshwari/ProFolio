import Combine
import Foundation

public final class ProfileUseCase {
    private let repository: ProfileRepository
    
    public init(repository: ProfileRepository) {
        self.repository = repository
    }
    
    public func getProfile(userId: String) -> AnyPublisher<User, Error> {
        repository.getProfile(userId: userId)
    }
}