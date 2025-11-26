import Foundation
import Combine

final class CustomerViewModel: ObservableObject {
    
    private let udService = UDService.shared
    
    @Published var customers: [Customer] = []
    @Published var path: [CustomerScreens] = []
    
    func loadCustomers() {
        Task {
            let customers = await udService.get([Customer].self, for: .customer) ?? []
            
            await MainActor.run {
                self.customers = customers
            }
        }
    }
    
    func save(_ customer: Customer) {
        Task {
            Task {
                var customers = await udService.get([Customer].self, for: .customer) ?? []
                
                if let index = customers.firstIndex(where: { $0.id == customer.id }) {
                    customers[index] = customer
                } else {
                    customers.append(customer)
                }
                
                await udService.set(customers, for: .customer)
                
                await MainActor.run {
                    self.path.removeAll()
                }
            }
        }
    }
    
    func remove(_ customer: Customer) {
        Task {
            var customers = await udService.get([Customer].self, for: .customer) ?? []
            
            
            if let index = customers.firstIndex(where: { $0.id == customer.id }) {
                customers.remove(at: index)
            }
            
            await udService.set(customers, for: .customer)
            
            
            await MainActor.run {
                self.path.removeAll()
            }
        }
    }
}
