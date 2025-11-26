import UserNotifications
import UIKit

final class NotificationPermissionService {
    
    static let shared = NotificationPermissionService()
    
    private init() {}
    
    
    var currentStatus: PermissionStatus {
        get async {
            let notificationCenter = UNUserNotificationCenter.current()
            let settings = await notificationCenter.notificationSettings()
            return mapAuthorizationStatus(settings.authorizationStatus)
        }
    }
    
    @discardableResult
    func requestPermission() async -> Bool {
        let notificationCenter = UNUserNotificationCenter.current()
        
        do {
            return try await notificationCenter.requestAuthorization(options: [.alert, .sound, .badge])
        } catch {
            print("❗️Failed to request push permissions: \(error.localizedDescription)")
            return false
        }
    }
}

private extension NotificationPermissionService {
    func mapAuthorizationStatus(_ status: UNAuthorizationStatus) -> PermissionStatus {
        switch status {
        case .authorized, .provisional:
            return .authorized
        case .denied:
            return .denied
        case .notDetermined:
            return .notDetermined
        @unknown default:
            return .denied
        }
    }
}

enum PermissionStatus {
    case authorized
    case denied
    case notDetermined
}

