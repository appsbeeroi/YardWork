import SwiftUI

struct ContentView: View {
    
    @State private var isLaunched = false
    
    var body: some View {
        if isLaunched {
            AppRouter()
        } else {
            SplashScreen(isLaunched: $isLaunched)
        }
    }
}

#Preview {
    AppRouter()
}
