import SwiftUI

struct AppRouter: View {
    
    @State private var currentPage: TabBarState = .order
    
    @State private var hasTabBar = true
    
    init() {
        hideTabbar()
    }
    var body: some View {
        ZStack {
            TabView(selection: $currentPage) {
                OrderView(hasTabBar: $hasTabBar)
                    .tag(TabBarState.order)
                
                ServiceView(hasTabBar: $hasTabBar)
                    .tag(TabBarState.service)
                
                CustomerView(hasTabBar: $hasTabBar)
                    .tag(TabBarState.customer)
                
                SettingsView(hasTabBar: $hasTabBar)
                    .tag(TabBarState.settings)
            }
            
            VStack {
                HStack {
                    ForEach(TabBarState.allCases) { state in
                        Button {
                            currentPage = state
                        } label: {
                            Image(state.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .opacity(currentPage == state ? 1 : 0.5)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .opacity(hasTabBar ? 1 : 0)
            .animation(.default, value: hasTabBar)
        }
    }
    
    private func hideTabbar() {
        UITabBar.appearance().isHidden = true
    }
}

#Preview {
    ContentView()
}

