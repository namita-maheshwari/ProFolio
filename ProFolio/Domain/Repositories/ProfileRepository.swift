import Combine
import Foundation

public protocol ProfileRepository {
    func getProfile(userId: String) -> AnyPublisher<User, Error>
    func updateProfile(user: User) -> AnyPublisher<Void, Error>
}