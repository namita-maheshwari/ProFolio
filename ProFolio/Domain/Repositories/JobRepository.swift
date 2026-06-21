import Combine
import Foundation

public protocol JobRepository {
    func getJobs() -> AnyPublisher<[Job], Error>
    func apply(to jobId: String) -> AnyPublisher<Void, Error>
}