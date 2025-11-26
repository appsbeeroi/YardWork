import SwiftUI

struct DefaultFormInput: View {
    
    @Binding var text: String
    
    let placeholder: String
    let keyboardType: UIKeyboardType
    
    @FocusState.Binding var focused: Bool
    
    var body: some View {
        HStack {
            TextField("", text: $text, prompt: Text(placeholder)
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.white.opacity(0.5))
            )
            .font(.system(size: 22, weight: .semibold))
            .foregroundStyle(.white)
            .focused($focused)
            .keyboardType(keyboardType)
                        
            if text != "" {
                Button {
                    text = ""
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
}
