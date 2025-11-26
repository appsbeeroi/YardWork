import SwiftUI

struct ServiceDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: ServiceViewModel
    
    let service: Service
    
    @State private var selectedRevenuePeriodType: RevenuePeriodType = .week
    @State private var isShowRemovalAlert = false
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .resize()
            
            VStack {
                navigationBar
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        VStack(spacing: 30) {
                            Text(service.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 35, weight: .semibold))
                                .foregroundStyle(.white)
                            
                            HStack {
                                Text("Rate / Unit")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(.white.opacity(0.5))
                                
                                Text("$\(service.rate)/hr")
                                    .font(.system(size: 36, weight: .semibold))
                                    .foregroundStyle(.white)
                            }
                            
                            VStack {
                                Text("Notes")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(.white.opacity(0.5))
                                
                                Text(service.notes)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.system(size: 22, weight: .semibold))
                                    .foregroundStyle(.white)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        .padding(.top)
                        .padding(.horizontal)
                        .padding(.bottom)
                        .background(.ywGreen)
                        .cornerRadius(20)
                        
                        VStack(spacing: 12) {
                            Text("Revenue")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundStyle(.white)
                            
                            HStack(spacing: 0) {
                                ForEach(RevenuePeriodType.allCases) { type in
                                    Button {
                                        selectedRevenuePeriodType = type
                                    } label: {
                                        Text(type.title)
                                            .frame(height: 38)
                                            .frame(maxWidth: .infinity)
                                            .padding(.horizontal, 2)
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundStyle(.white)
                                            .background(selectedRevenuePeriodType == type ? .ywLightGreen : .clear)
                                            .cornerRadius(10)
                                    }
                                }
                            }
                            .frame(minHeight: 42)
                            .background(.ywGreen)
                            .cornerRadius(10)
                            .animation(.default, value: selectedRevenuePeriodType)
                            
                            let rate = Int(service.rate) ?? 0
                            let rateString = switch selectedRevenuePeriodType {
                                case .day:
                                    rate * 8
                                case .week:
                                    rate * 8 * 5
                                case .month:
                                    rate * 8 * 5 * 4
                            }
                            
                            Text("$\(rateString)")
                                .font(.system(size: 48, weight: .bold))
                                .foregroundStyle(.white)
                        }
                        .padding(12)
                        .background(.ywGreen)
                        .cornerRadius(20)
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
                viewModel.remove(service)
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
                    viewModel.path.append(.add(service))
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
    ServiceDetailView(service: Service(isReal: false))
}
