import SwiftUI

struct AddOrderView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: OrderViewModel
    
    @State var order: Order
    @State var hasDateSelected: Bool
    
    @State private var isClientWrapped = true
    @State private var isWorkTypeWrapperd = true
    @State private var isShowDatePicker = false
    
    @FocusState var focused: Bool
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .resize()
            
            VStack(spacing: 20) {
                navigationBar
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        client
                        workType
                        date
                        volume
                        payment
                        notes
                        status
                        completeButton
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
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top)
            .animation(.smooth, value: isClientWrapped)
            .animation(.smooth, value: isWorkTypeWrapperd)
            
            if isShowDatePicker {
                datePicker
            }
        }
        .navigationBarBackButtonHidden()
        .animation(.smooth, value: isShowDatePicker)
        .onChange(of: order.date) { _ in
            hasDateSelected = true
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
    
    private var completeButton: some View {
        Button {
            viewModel.save(order)
        } label: {
            Image(.Icons.complete)
                .resizable()
                .scaledToFit()
                .frame(width: 130, height: 130)
                .opacity(order.isLock ? 0.6 : 1)
        }
        .disabled(order.isLock)
    }
    
    private var client: some View {
        LazyVStack(spacing: 8) {
            HStack {
                Text("Client")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(.white)
                
                Button {
                    isClientWrapped.toggle()
                } label: {
                    Image(systemName: isClientWrapped ? "chevron.down" : "chevron.up")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.yellow)
                }
                .frame(minWidth: 40, minHeight: 40)
            }
            .frame(height: 66)
            .padding(.horizontal, 12)
            .background(.ywGreen)
            .cornerRadius(15)
            
            if !isClientWrapped,
                !viewModel.customers.isEmpty {
                VStack(spacing: 8) {
                    ForEach(viewModel.customers) { customer in
                        Button {
                            order.customer = customer
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
                            .background(order.customer == customer ? .ywLightGreen : Color(hex: "2E3C00"))
                            .cornerRadius(15)
                        }
                    }
                }
                .padding(9)
                .background(.ywGreen)
                .cornerRadius(15)
            }
        }
    }
    
    private var workType: some View {
        LazyVStack(spacing: 8) {
            HStack {
                Text("Work type")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(.white)
                
                Button {
                    isWorkTypeWrapperd.toggle()
                } label: {
                    Image(systemName: isWorkTypeWrapperd ? "chevron.down" : "chevron.up")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.yellow)
                }
                .frame(minWidth: 40, minHeight: 40)
            }
            .frame(height: 66)
            .padding(.horizontal, 12)
            .background(.ywGreen)
            .cornerRadius(15)
            
            if !isWorkTypeWrapperd,
                !viewModel.services.isEmpty {
                VStack(spacing: 8) {
                    ForEach(viewModel.services) { service in
                        Button {
                            order.workType = service
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
                            .background(order.workType == service ? .ywLightGreen : Color(hex: "2E3C00"))
                            .cornerRadius(15)
                        }
                    }
                }
                .padding(9)
                .background(.ywGreen)
                .cornerRadius(15)
            }
        }
    }
    
    private var date: some View {
        Button {
            isShowDatePicker.toggle()
        } label: {
            HStack {
                let date = order.date.formatted(.dateTime.year().month(.twoDigits).day())
                
                Text(hasDateSelected ? date : "Date")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(.white.opacity(hasDateSelected ? 1 : 0.5))
                
                Image(.Icons.calendar)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 49, height: 49)
            }
            .frame(height: 66)
            .padding(.horizontal, 12)
            .background(.ywGreen)
            .cornerRadius(15)
        }
    }
    
    private var datePicker: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            VStack {
                Button("Done") {
                    isShowDatePicker = false
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                DatePicker("", selection: $order.date, displayedComponents: [.date])
                    .labelsHidden()
                    .datePickerStyle(.graphical)
            }
            .padding()
            .background(.white)
            .cornerRadius(15)
            .padding(.horizontal, 16)
        }
    }
    
    private var volume: some View {
        DefaultFormInput(
            text: $order.volume,
            placeholder: "Volume / Hours",
            keyboardType: .default,
            focused: $focused
        )
    }
    
    private var payment: some View {
        HStack {
            TextField(
                "",
                text: focused ? $order.payment : (order.payment == "" ? .constant("") : .constant("$\(order.payment)/hr")),
                prompt: Text("Payment")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.white.opacity(0.5))
            )
            .font(.system(size: 22, weight: .semibold))
            .foregroundStyle(.white)
            .focused($focused)
            .keyboardType(.numberPad)
            
            if order.payment != "" {
                Button {
                    order.payment = ""
                    focused = false
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white.opacity(0.5))
                }
            }
        }
        .frame(height: 66)
        .padding(.horizontal, 12)
        .background(.ywGreen)
        .cornerRadius(15)
    }
    
    private var notes: some View {
        DefaultFormInput(
            text: $order.notes,
            placeholder: "Notes",
            keyboardType: .default,
            focused: $focused
        )
    }
    
    private var status: some View {
        HStack(spacing: 6) {
            ForEach(OrderStatus.allCases) { status in
                Button {
                    order.status = status
                } label: {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 106, height: 106)
                        .foregroundStyle(order.status == status ? .ywLightGreen : .ywGreen)
                        .overlay {
                            VStack {
                                Image(status.icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                
                                Text(status.title)
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundStyle(.white)
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    AddOrderView(order: Order(isReal: true), hasDateSelected: false)
        .environmentObject(OrderViewModel())
}

#Preview {
    AddOrderView(order: Order(isReal: false), hasDateSelected: true)
        .environmentObject(OrderViewModel())
}
