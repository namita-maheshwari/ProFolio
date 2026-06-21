//
//  ProFolioApp
//
//  Created by Namita Maheshwari on 21/06/26.
//

import SwiftUI

struct JobsView: View {
    @StateObject private var viewModel: JobsViewModel
    
    init(viewModel: JobsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.jobs) { job in
                JobRow(job: job, isApplied: viewModel.appliedJobIds.contains(job.id)) {
                    viewModel.apply(to: job.id)
                }
            }
            .navigationTitle("Jobs")
            .overlay(Group {
                if viewModel.isLoading { ProgressView() }
            })
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK") { viewModel.errorMessage = nil }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            .onAppear {
                viewModel.loadJobs()
            }
            .refreshable {
                viewModel.loadJobs()
            }
        }
    }
}

struct JobRow: View {
    let job: Job
    let isApplied: Bool
    let onApply: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(job.title)
                .font(.headline)
            Text(job.company)
                .font(.subheadline)
            Text(job.location)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(job.description)
                .font(.body)
                .lineLimit(2)
            HStack {
                if job.isRemote {
                    Label("Remote", systemImage: "wifi")
                        .font(.caption)
                }
                Spacer()
                Text(job.postedDate, style: .relative)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            Button(action: onApply) {
                Text(isApplied ? "Applied" : "Apply")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(isApplied)
        }
        .padding(.vertical, 4)
    }
}
