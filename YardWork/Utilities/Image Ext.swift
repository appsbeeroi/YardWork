import SwiftUI

extension Image {
    func resize() -> some View {
        GeometryReader { proxy in
            self
                .resizable()
                .scaledToFill()
                .frame(width: proxy.size.width, height: proxy.size.height)
                .clipped()
        }
        .ignoresSafeArea()
    }
}
