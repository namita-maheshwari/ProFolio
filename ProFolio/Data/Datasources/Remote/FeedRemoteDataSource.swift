import Combine
import Foundation

protocol FeedRemoteDataSource {
    func fetchFeed(page: Int) -> AnyPublisher<[PostDTO], Error>
}