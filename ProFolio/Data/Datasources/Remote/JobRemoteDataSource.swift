import Combine
import Foundation

protocol JobRemoteDataSource {
    func fetchJobs() -> AnyPublisher<[JobDTO], Error>
    func apply(to jobId: String) -> AnyPublisher<Void, Error>
}