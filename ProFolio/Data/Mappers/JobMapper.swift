import Foundation

struct JobDTO: Decodable {
    let id: String
    let title: String
    let company: String
    let location: String
    let description: String
    let postedDate: Date
    let isRemote: Bool
}

struct JobMapper {
    func toDomain(_ dto: JobDTO) -> Job {
        Job(id: dto.id,
            title: dto.title,
            company: dto.company,
            location: dto.location,
            description: dto.description,
            postedDate: dto.postedDate,
            isRemote: dto.isRemote)
    }
}
