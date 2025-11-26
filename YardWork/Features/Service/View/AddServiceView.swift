import SwiftUI

struct AddServiceView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: ServiceViewModel
    
    @State var service: Service
    
    @FocusState var focused: Bool
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .resize()
            
            VStack(spacing: 20) {
                navigationBar
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        name
                        rate
                        notes
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
    
    private var completeButton: some View {
        Button {
            viewModel.save(service)
        } label: {
            Image(.Icons.complete)
                .resizable()
                .scaledToFit()
                .frame(width: 130, height: 130)
                .opacity(service.isLock ? 0.6 : 1)
        }
        .disabled(service.isLock)
    }
    
    private var name: some View  {
        DefaultFormInput(
            text: $service.name,
            placeholder: "Service name",
            keyboardType: .default,
            focused: $focused
        )
    }
    
    private var rate: some View  {
        HStack {
            TextField(
                "",
                text: focused ? $service.rate : (service.rate == "" ? .constant("") : .constant("$\(service.rate)/hr")),
                prompt: Text("Rate / Unit")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.white.opacity(0.5))
            )
            .font(.system(size: 22, weight: .semibold))
            .foregroundStyle(.white)
            .focused($focused)
            .keyboardType(.numberPad)
            
            if service.rate != "" {
                Button {
                    service.rate = ""
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
    
    private var notes: some View  {
        DefaultFormInput(
            text: $service.notes,
            placeholder: "Notes",
            keyboardType: .default,
            focused: $focused
        )
    }
}

#Preview {
    AddServiceView(service: Service(isReal: false))
}
