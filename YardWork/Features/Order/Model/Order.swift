import Foundation

struct Order: Identifiable, Codable, Hashable {
    let id: UUID
    var customer: Customer?
    var workType: Service?
    var date: Date
    var volume: String
    var payment: String
    var notes: String
    var status: OrderStatus?
    
    var isLock: Bool {
        customer == nil || workType == nil || status == nil || volume == "" || payment == "" || notes == ""
    }
    
    init(isReal: Bool) {
        self.id = UUID()
        self.customer = isReal ? nil : Customer(isReal: false)
        self.workType = isReal ? nil : Service(isReal: false)
        self.date = Date()
        self.volume = isReal ? "" : "1"
        self.payment = isReal ? "" : "100"
        self.notes = isReal ? "" : "Test"
        self.status = isReal ? nil : .completed
    }
}
