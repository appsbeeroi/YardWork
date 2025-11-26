import SwiftUI

struct OrderView: View {
    
    @StateObject private var viewModel = OrderViewModel()
    
    @Binding var hasTabBar: Bool
    
    var isAvailableToStart: Bool {
        !viewModel.services.isEmpty && !viewModel.customers.isEmpty
    }
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            ZStack {
                Image(.Images.BG)
                    .resize()
                
                VStack {
                    navigationBar
                    
                    if viewModel.orders.isEmpty {
                        stumb
                    } else {
                        orders
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top)
            }
            .navigationDestination(for: OrderScreen.self) { screen in
                switch screen {
                    case .add(let order):
                        AddOrderView(order: order, hasDateSelected: order.customer != nil)
                    case .detail(let order):
                        OrderDetailView(order: order)
                }
            }
            .onAppear {
                hasTabBar = true
                viewModel.loadData()
            }
        }
        .environmentObject(viewModel)
    }
    
    private var navigationBar: some View {
        Text("Order book")
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
            
            let text = "Add your first job to start keeping track of your work"
            let notReadyText = "You need to add your first service and customer to start ordering"
            
            Text(isAvailableToStart ? text : notReadyText)
                .font(.system(size: 25, weight: .semibold))
                .multilineTextAlignment(.center)
            
            if isAvailableToStart {
                addButton
            }
        }
        .padding(.vertical, 22)
        .padding(.horizontal, 12)
        .background(.ywGreen)
        .cornerRadius(20)
        .padding(.horizontal, 30)
        .foregroundStyle(.white)
        .frame(maxHeight: .infinity)
    }
    
    private var addButton: some View {
        Button {
            hasTabBar = false
            viewModel.path.append(.add(Order(isReal: true)))
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
    
    private var orders: some View {
        VStack(spacing: 24) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 8) {
                    ForEach(viewModel.orders) { order in
                        Button {
                            hasTabBar = false
                            viewModel.path.append(.detail(order))
                        } label: {
                            HStack(spacing: 12) {
                                if let status = order.status {
                                    RoundedRectangle(cornerRadius: 15)
                                        .frame(width: 80, height: 80)
                                        .foregroundStyle(.ywLightGreen)
                                        .overlay {
                                            VStack(spacing: 0) {
                                                Image(status.icon)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 48, height: 48)
                                                
                                                Text(status.title)
                                                    .font(.system(size: 14, weight: .semibold))
                                                    .foregroundStyle(.white)
                                            }
                                        }
                                }
                                
                                VStack(spacing: 3) {
                                    HStack {
                                        Image(.Icons.calendar)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 29, height: 29)
                                        
                                        Text(order.date.formatted(.dateTime.year().month(.twoDigits).day()))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundStyle(.white)
                                    }
                                    
                                    Text(order.workType?.name ?? "N/A")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundStyle(.white)
                                    
                                    HStack(spacing: 0) {
                                        Image(systemName: "person.fill")
                                            .font(.system(size: 14, weight: .medium))
                                        
                                        Text(order.customer?.name ?? "N/A")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.system(size: 13, weight: .medium))
                                    }
                                    .foregroundStyle(.white.opacity(0.5))
                                }
                            }
                            .padding(.vertical, 16)
                            .padding(.horizontal, 8)
                            .frame(height: 113)
                            .background(.ywGreen)
                            .cornerRadius(20)
                        }
                    }
                }
                .padding(.top)
                .padding(.horizontal, 30)
            }
            
            addButton
        }
        .padding(.bottom, 100)

    }
}

#Preview {
    OrderView(hasTabBar: .constant(false))
}
