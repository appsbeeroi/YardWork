import SwiftUI

struct OrderDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: OrderViewModel
    
    let order: Order
    
    @State private var isShowRemovalAlert = false
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .resize()
            
            VStack {
                navigationBar
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        VStack(spacing: 24) {
                            status
                            
                            VStack(spacing: 10) {
                                date
                                
                                HStack {
                                    volume
                                    payment
                                }
                                
                                notes
                            }
                        }
                        .padding(.vertical, 22)
                        .padding(.horizontal, 12)
                        .background(Color(hex: "3B4D00"))
                        .cornerRadius(15)
                        
                        client
                        workType
                    }
                    .padding(.horizontal, 30)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top)
        }
        .navigationBarBackButtonHidden()
        .alert("Are you sure you want to delete this entry?", isPresented: $isShowRemovalAlert) {
            Button("OK", role: .destructive) {
                viewModel.remove(order)
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
                    viewModel.path.append(.add(order))
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
    
    private var status: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(width: 106, height: 106)
            .foregroundStyle(.ywLightGreen)
            .overlay {
                VStack {
                    if let status = order.status {
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
    
    private var date: some View {
        HStack {
            let date = order.date.formatted(.dateTime.year().month(.twoDigits).day())
            
            Text(date)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.white)
            
            Image(.Icons.calendar)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
        }
    }
    
    private var volume: some View {
        VStack {
            Text("Volume / Hours")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.white.opacity(0.5))
            
            Text(order.volume)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.white)
        }
    }
    
    private var payment: some View {
        VStack {
            Text("Payment")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.white.opacity(0.5))
            
            Text("$\(order.payment)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.white)
        }
    }
    
    private var notes: some View {
        VStack {
            Text("Notes")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.white.opacity(0.5))
            
            Text(order.notes)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.white)
        }
    }
    
    private var client: some View {
        VStack {
            Text("Client")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.white)
            
            HStack {
                VStack {
                    Text(order.customer?.name ?? "N/A")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 25, weight: .bold))
                        .foregroundStyle(.white)
                    
                    Text(order.customer?.phone ?? "N/A")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.5))
                }
                .padding(.vertical, 22)
                .padding(.horizontal, 12)
                
                if (order.customer?.isRegular ?? false) {
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
            .background(Color(hex: "3B4D00"))
            .cornerRadius(15)
        }
        .padding(9)
        .background(Color(hex: "2E3C00"))
        .cornerRadius(15)
    }
    
    private var workType: some View {
        VStack {
            Text("Work Type")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.white)
            
            VStack(spacing: 16) {
                if let service = order.workType {
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
            }
            .padding(.vertical, 22)
            .padding(.horizontal, 12)
            .frame(height: 104)
            .background(.ywGreen)
            .cornerRadius(15)
        }
        .padding(9)
        .background(Color(hex: "2E3C00"))
        .cornerRadius(15)
    }
}

#Preview {
    OrderDetailView(order: Order(isReal: false))
}
