import SwiftUI

struct CustomerView: View {
    
    @StateObject private var viewModel = CustomerViewModel()
    
    @Binding var hasTabBar: Bool
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            ZStack {
                Image(.Images.BG)
                    .resize()
                
                VStack {
                    navigationBar
                    
                    if viewModel.customers.isEmpty {
                        stumb
                    } else {
                        customers
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top)
            }
            .navigationDestination(for: CustomerScreens.self) { screen in
                switch screen {
                    case .add(let customer):
                        AddCustomerView(customer: customer)
                    case .detail(let customer):
                        CustomerDetailView(customer: customer)
                }
            }
            .onAppear {
                hasTabBar = true
                viewModel.loadCustomers()
            }
        }
        .environmentObject(viewModel)
    }
    
    private var navigationBar: some View {
        Text("Customer list")
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
            
            Text("Add customer information to keep your contacts and past jobs handy")
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
    
    private var customers: some View {
        VStack(spacing: 24) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 8) {
                    ForEach(viewModel.customers) { customer in
                        Button {
                            hasTabBar = false
                            viewModel.path.append(.detail(customer))
                        } label: {
                            HStack {
                                VStack {
                                    Text(customer.name)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.system(size: 25, weight: .bold))
                                        .foregroundStyle(.white)
                                    
                                    Text(customer.phone)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.system(size: 22, weight: .semibold))
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                                .padding(.vertical, 22)
                                .padding(.horizontal, 12)
                                
                                if customer.isRegular {
                                    Text("Regular")
                                        .frame(width: 80, height: 32)
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundStyle(.white)
                                        .background(.ywLightGreen)
                                        .cornerRadius(20)
                                        .frame(maxHeight: .infinity, alignment: .topTrailing)
                                        .padding()
                                }
                            }
                            .frame(height: 104)
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
    
    private var addButton: some View {
        Button {
            hasTabBar = false
            viewModel.path.append(.add(Customer(isReal: true)))
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
    CustomerView(hasTabBar: .constant(false))
}
