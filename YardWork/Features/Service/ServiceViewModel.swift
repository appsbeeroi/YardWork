import Combine
import Foundation

final class ServiceViewModel: ObservableObject {
    
    private let udService = UDService.shared
    
    @Published var path: [ServiceScreen] = []
    @Published var services: [Service] = []
    
    func loadServices() {
        Task {
            let services = await udService.get([Service].self, for: .service) ?? []
            
            await MainActor.run {
                self.services = services
            }
        }
    }
    
    func save(_ service: Service) {
        Task {
            Task {
                var services = await udService.get([Service].self, for: .service) ?? []
                
                if let index = services.firstIndex(where: { $0.id == service.id }) {
                    services[index] = service
                } else {
                    services.append(service)
                }
                
                await udService.set(services, for: .service)
                
                await MainActor.run {
                    self.path.removeAll()
                }
            }
        }
    }
    
    func remove(_ service: Service) {
        Task {
            var services = await udService.get([Service].self, for: .service) ?? []
            
            if let index = services.firstIndex(where: { $0.id == service.id }) {
                services.remove(at: index)
            }
            
            await udService.set(services, for: .service)
            
            await MainActor.run {
                self.path.removeAll()
            }
        }
    }
}
