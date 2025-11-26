import SwiftUI

struct SplashScreen: View {
    
    @Binding var isLaunched: Bool
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .resize()
            
            Image(.Images.splash)
                .resizable()
                .scaledToFit()
                .scaleEffect(isAnimating ? 1.1 : 1)
                .animation(.smooth.repeatForever(), value: isAnimating)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isAnimating = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    isLaunched = true
                }
            }
        }
    }
}

#Preview {
    SplashScreen(isLaunched: .constant(false))
}

