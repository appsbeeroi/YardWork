import Foundation
import Combine

final class OrderViewModel: ObservableObject {
    
    private let udService = UDService.shared
    
    @Published var orders: [Order] = []
    @Published var customers: [Customer] = []
    @Published var services: [Service] = []
    @Published var path: [OrderScreen] = []
    
    func loadData() {
        Task {
            async let orders = await udService.get([Order].self, for: .order) ?? []
            async let customers = await udService.get([Customer].self, for: .customer) ?? []
            async let services = await udService.get([Service].self, for: .service) ?? []
            
            let result = await (orders, customers, services)
            
            await MainActor.run {
                self.orders = result.0
                self.customers = result.1
                self.services = result.2
            }
        }
    }
    
    func save(_ order: Order) {
        Task {
            Task {
                var orders = await udService.get([Order].self, for: .order) ?? []
                
                if let index = orders.firstIndex(where: { $0.id == order.id }) {
                    orders[index] = order
                } else {
                    orders.append(order)
                }
                
                await udService.set(orders, for: .order)
                
                await MainActor.run {
                    self.path.removeAll()
                }
            }
        }
    }
    
    func remove(_ order: Order) {
        Task {
            var orders = await udService.get([Order].self, for: .order) ?? []
            
            if let index = orders.firstIndex(where: { $0.id == order.id }) {
                orders.remove(at: index)
            }
            
            await udService.set(orders, for: .order)
            
            await MainActor.run {
                self.path.removeAll()
            }
        }
    }
}
