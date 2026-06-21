import Combine
import Foundation

protocol ProfileRemoteDataSource {
    func fetchUser(userId: String) -> AnyPublisher<UserDTO, Error>
    func updateUser(_ user: UserDTO) -> AnyPublisher<Void, Error>
}