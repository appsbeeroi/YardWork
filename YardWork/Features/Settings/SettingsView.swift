import SwiftUI

struct SettingsView: View {
    
    @AppStorage("hasPush") var hasPush = false
    
    @Binding var hasTabBar: Bool
    
    @State private var isToggleOn = false
    @State private var isShowBrowser = false
    @State private var isShowErrorAlert = false
    @State private var isShowRemovalAlert = false
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .resize()
            
            VStack {
                navigationBar
                
                VStack(spacing: 8) {
                    Button {
                        isShowBrowser.toggle()
                    } label: {
                        HStack {
                            Text("About the application")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundStyle(.white)
                            
                            
                        }
                        .frame(height: 68)
                        .padding(.horizontal, 12)
                        .background(.ywGreen)
                        .cornerRadius(15)
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Text("Notification")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundStyle(.white)
                            
                            Toggle(isOn: $isToggleOn) {}
                                .labelsHidden()
                                .tint(.ywLightGreen)
                        }
                        .frame(height: 68)
                        .padding(.horizontal, 12)
                        .background(.ywGreen)
                        .cornerRadius(15)
                    }
                    
                    Button {
                        isShowRemovalAlert.toggle()
                    } label: {
                        HStack {
                            Text("History")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundStyle(.white)
                            
                            Image(.Icons.remove)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44, height: 44)
                        }
                        .frame(height: 68)
                        .padding(.horizontal, 12)
                        .background(.ywGreen)
                        .cornerRadius(15)
                    }
                }
                .padding(.top)
                .padding(.horizontal, 30)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top)
#warning("ссылка")
            if isShowBrowser,
               let url = URL(string: "apple.com") {
                BrowserView(url: url) {
                    isShowBrowser = false
                    hasTabBar = true
                }
                .ignoresSafeArea(edges: [.bottom])
            }
        }
        .alert("Are you sure you want to delete all the data?", isPresented: $isShowRemovalAlert) {
            Button("YES", role: .destructive) {
                Task {
                    UDService.shared.remove(.customer)
                    UDService.shared.remove(.service)
                    UDService.shared.remove(.order)
                }
            }
        }
        .alert("The notification permission denied. Open settings?", isPresented: $isShowErrorAlert) {
            Button("OK") {
                guard let settingsURL = URL(string: UIApplication.openSettingsURLString),
                      UIApplication.shared.canOpenURL(settingsURL) else { return }
                UIApplication.shared.open(settingsURL)
            }
        }
        .onChange(of: isToggleOn) { isOn in
            switch isOn {
                case true:
                    Task {
                        switch await NotificationPermissionService.shared.currentStatus {
                            case .authorized:
                                hasPush = true
                            case .denied:
                                isShowErrorAlert = true
                            case .notDetermined:
                                await NotificationPermissionService.shared.requestPermission()
                        }
                    }
                case false:
                    hasPush = false
            }
        }
}

private var navigationBar: some View {
    Text("Settings")
        .frame(height: 66)
        .padding(.horizontal, 22)
        .background(.ywGreen)
        .font(.system(size: 35, weight: .semibold))
        .foregroundStyle(.white)
        .cornerRadius(15)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(.white, lineWidth: 1)
        }
}
}

#Preview {
    SettingsView(hasTabBar: .constant(false))
}
