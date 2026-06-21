import Combine
import Foundation

public final class DefaultJobRepository: JobRepository {
    private let remoteDataSource: JobRemoteDataSource
    private let jobMapper: JobMapper
    
    init(remoteDataSource: JobRemoteDataSource, jobMapper: JobMapper) {
        self.remoteDataSource = remoteDataSource
        self.jobMapper = jobMapper
    }
    
    public func getJobs() -> AnyPublisher<[Job], Error> {
        remoteDataSource.fetchJobs()
            .map { $0.map { self.jobMapper.toDomain($0) } }
            .eraseToAnyPublisher()
    }
    
    public func apply(to jobId: String) -> AnyPublisher<Void, Error> {
        remoteDataSource.apply(to: jobId)
    }
}
