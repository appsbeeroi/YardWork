enum RevenuePeriodType: Identifiable, CaseIterable {
    case day
    case week
    case month
    
    var id: Self {
        self
    }
    
    var title: String {
        switch self {
            case .day:
                "Day"
            case .week:
                "Week"
            case .month:
                "Month"
        }
    }
}
