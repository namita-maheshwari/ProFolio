//
//  ProFolioApp
//
//  Created by Namita Maheshwari on 21/06/26.
//
import Combine
import SwiftUI

class JobsViewModel: ObservableObject {
    @Published var jobs: [Job] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var appliedJobIds = Set<String>()
    
    private let jobUseCase: JobUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(jobUseCase: JobUseCase) {
        self.jobUseCase = jobUseCase
    }
    
    func loadJobs() {
        isLoading = true
        errorMessage = nil
        
        jobUseCase.getJobs()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] jobs in
                self?.jobs = jobs
            }
            .store(in: &cancellables)
    }
    
    func apply(to jobId: String) {
        guard !appliedJobIds.contains(jobId) else { return }
        isLoading = true
        
        jobUseCase.apply(to: jobId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] _ in
                self?.appliedJobIds.insert(jobId)
            }
            .store(in: &cancellables)
    }
}
