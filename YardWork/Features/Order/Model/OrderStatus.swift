import UIKit

enum OrderStatus: Identifiable, CaseIterable, Hashable, Codable {
    case planned
    case inProgress
    case completed
    
    var id: Self {
        self
    }
    
    var title: String {
        switch self {
            case .planned:
                "Planned"
            case .inProgress:
                "In progress"
            case .completed:
                "Completed"
        }
    }
    
    var icon: ImageResource {
        switch self {
            case .planned:
                    .Icons.OrderStatus.planned
            case .inProgress:
                    .Icons.OrderStatus.inProgress
            case .completed:
                    .Icons.OrderStatus.completed
        }
    }
}
