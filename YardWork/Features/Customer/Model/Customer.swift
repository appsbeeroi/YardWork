import Foundation

struct Customer: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var phone: String
    var adress: String
    var isRegular: Bool
    
    var isLock: Bool {
        name == "" || phone == "" || adress == ""
    }
    
    init(isReal: Bool) {
        self.id = UUID()
        self.name = isReal ? "" : "John Doe"
        self.phone = isReal ? "" : "0123456789"
        self.adress = isReal ? "" : "123 Main St, Anytown, USA"
        self.isRegular = isReal ? false : true
    }
}
