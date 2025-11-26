import UIKit

enum TabBarState: Identifiable, CaseIterable {
    case order
    case service
    case customer
    case settings
    
    var id: Self {
        self
    }
    
    var icon: ImageResource {
        switch self {
            case .order:
                    .Icons.order
            case .service:
                    .Icons.service
            case .customer:
                    .Icons.customer
            case .settings:
                    .Icons.settings
        }
    }
}
