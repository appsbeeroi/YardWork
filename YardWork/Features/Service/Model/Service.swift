import Foundation

struct Service: Codable, Identifiable, Hashable {
    let id: UUID
    var name: String
    var rate: String
    var notes: String
    
    var isLock: Bool {
        self.name == "" || self.rate == "" || self.notes == ""
    }
    
    init(isReal: Bool) {
        self.id = UUID()
        self.name = isReal ? "" : "Example"
        self.rate = isReal ? "" : "100"
        self.notes = isReal ? "" : "Example notes"
    }
}
