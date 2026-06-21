import Combine
import Foundation

protocol ConnectionRemoteDataSource {
    func fetchConnections(userId: String) -> AnyPublisher<[UserDTO], Error>
    func sendRequest(to userId: String) -> AnyPublisher<Void, Error>
    func acceptRequest(from userId: String) -> AnyPublisher<Void, Error>
}