import SwiftUI

struct ServiceView: View {
    
    @StateObject private var viewModel = ServiceViewModel()
    
    @Binding var hasTabBar: Bool
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            ZStack {
                Image(.Images.BG)
                    .resize()
                
                VStack {
                    navigationBar
                    
                    if viewModel.services.isEmpty {
                        stumb
                    } else {
                        services
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top)
            }
            .navigationDestination(for: ServiceScreen.self) { screen in
                switch screen {
                    case .add(let service):
                        AddServiceView(service: service)
                    case .detail(let service):
                        ServiceDetailView(service: service)
                }
            }
            .onAppear {
                hasTabBar = true
                viewModel.loadServices()
            }
        }
        .environmentObject(viewModel)
    }
    
    private var navigationBar: some View {
        Text("Services List")
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
    
    private var stumb: some View {
        VStack(spacing: 24) {
            Image(.Icons.cancel)
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
            
            Text("Create your list of tasks and set prices to track earnings easily")
                .font(.system(size: 25, weight: .semibold))
                .multilineTextAlignment(.center)
            
            addButton
        }
        .padding(.vertical, 22)
        .padding(.horizontal, 12)
        .background(.ywGreen)
        .cornerRadius(20)
        .padding(.horizontal, 30)
        .foregroundStyle(.white)
        .frame(maxHeight: .infinity)
    }
    
    private var services: some View {
        VStack(spacing: 24) {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 8) {
                    ForEach(viewModel.services) { service in
                        Button {
                            hasTabBar = false
                            viewModel.path.append(.detail(service))
                        } label: {
                            VStack(spacing: 16) {
                                Text(service.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.system(size: 25, weight: .semibold))
                                    .foregroundStyle(.white)
                                
                                HStack(spacing: 14) {
                                    Text("Rate / Unit")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundStyle(.white.opacity(0.5))
                                    
                                    Text("$\(service.rate)/hr")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.system(size: 24, weight: .semibold))
                                        .foregroundStyle(.white)
                                }
                            }
                            .padding(.vertical, 22)
                            .padding(.horizontal, 12)
                            .frame(height: 104)
                            .background(.ywGreen)
                            .cornerRadius(15)
                        }
                    }
                }
                .padding(.top)
                .padding(.horizontal, 30)
            }
            
            addButton
        }
        .padding(.bottom, 110)
    }
    
    private var addButton: some View {
        Button {
            hasTabBar = false
            viewModel.path.append(.add(Service(isReal: true)))
        } label: {
            Text("Add record")
                .frame(height: 72)
                .frame(maxWidth: .infinity)
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(.white)
                .background(.ywLightGreen)
                .cornerRadius(20)
                .padding(.horizontal, 30)
        }
    }
}

#Preview {
    ServiceView(hasTabBar: .constant(false))
}
