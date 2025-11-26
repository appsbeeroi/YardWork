import SwiftUI

struct AddCustomerView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: CustomerViewModel
    
    @State var customer: Customer
    
    @FocusState var focused: Bool
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .resize()
            
            VStack(spacing: 20) {
                navigationBar
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        clientName
                        clientPhone
                        adress
                        status
                    }
                    .padding(.top)
                    .padding(.horizontal, 30)
                    .toolbar {
                        ToolbarItem(placement: .keyboard) {
                            Button("Done") {
                                focused = false
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
                
                completeButton
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top)
        }
        .navigationBarBackButtonHidden()
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
            
            Text("Add record")
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
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 30)
    }
    
    private var clientName: some View {
        DefaultFormInput(
            text: $customer.name,
            placeholder: "Client name",
            keyboardType: .default,
            focused: $focused
        )
    }
    
    private var clientPhone: some View {
        DefaultFormInput(
            text: $customer.phone,
            placeholder: "Contact phone",
            keyboardType: .phonePad,
            focused: $focused
        )
    }
    
    private var adress: some View {
        DefaultFormInput(
            text: $customer.adress,
            placeholder: "Adress",
            keyboardType: .default,
            focused: $focused
        )
    }
    
    private var status: some View {
        Button {
            customer.isRegular.toggle()
        } label: {
            HStack {
                Circle()
                    .stroke(.ywLightGreen, lineWidth: 1)
                    .frame(width: 24, height: 24)
                    .overlay {
                        if customer.isRegular {
                            Circle()
                                .foregroundStyle(.ywLightGreen)
                        }
                    }
                
                Text("Regular client")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(.white)
            }
            .frame(height: 66)
            .padding(.horizontal, 12)
            .background(.ywGreen)
            .cornerRadius(15)
        }
    }
    
    private var completeButton: some View {
        Button {
            viewModel.save(customer)
        } label: {
            Image(.Icons.complete)
                .resizable()
                .scaledToFit()
                .frame(width: 130, height: 130)
                .opacity(customer.isLock ? 0.6 : 1)
        }
        .disabled(customer.isLock)
    }
}

#Preview {
    AddCustomerView(customer: Customer(isReal: false))
}

#Preview {
    AddCustomerView(customer: Customer(isReal: true))
}

