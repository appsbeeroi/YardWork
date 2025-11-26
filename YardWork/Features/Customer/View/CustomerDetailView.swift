import SwiftUI

struct CustomerDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: CustomerViewModel
    
    let customer: Customer
    
    @State private var isShowRemovalAlert = false
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .resize()
            
            VStack {
                navigationBar
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        HStack {
                            VStack {
                                Text(customer.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundStyle(.white)
                                    .padding(.top)
                            }
                            
                            if customer.isRegular {
                                Text("Regular")
                                    .frame(width: 80, height: 32)
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundStyle(.white)
                                    .background(.ywLightGreen)
                                    .cornerRadius(20)
                                    .frame(maxHeight: .infinity, alignment: .topTrailing)
                                    .padding(.vertical)
                            }
                        }
                        
                        VStack {
                            Text("Contact Phone:")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(.white.opacity(0.5))
                            
                            Text(customer.phone)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundStyle(.white)
                        }
                        
                        VStack {
                            Text("Address:")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(.white.opacity(0.5))
                            
                            Text(customer.adress)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    .background(.ywGreen)
                    .cornerRadius(20)
                    .padding(.top)
                    .padding(.horizontal, 30)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top)
        }
        .navigationBarBackButtonHidden()
        .alert("Are you sure you want to delete this entry?", isPresented: $isShowRemovalAlert) {
            Button("OK", role: .destructive) {
                viewModel.remove(customer)
            }
        }
    }
    
    private var navigationBar: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(.Icons.back)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 85, height: 85)
            }
            
            Spacer()
            
            HStack {
                Button {
                    viewModel.path.append(.add(customer))
                } label: {
                    Image(.Icons.edit)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 77, height: 77)
                }
                
                Button {
                    isShowRemovalAlert.toggle()
                } label: {
                    Image(.Icons.remove)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 77, height: 77)
                }
            }
        }
        .padding(.horizontal, 30)
    }
}

#Preview {
    CustomerDetailView(customer: Customer(isReal: false))
}

