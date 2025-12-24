//
//  SecureTextFieldView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/23/25.
//

import SwiftUI

struct SecureTextFieldView: View {
    
    @State private var isSecureField: Bool = true
    @Binding var text: String
    
    var body: some View {
        HStack {
            if isSecureField {
                SecureField("Insert Password", text: $text)
                    .textContentType(.password)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
            } else {
                TextField(text, text: $text)
                    .textContentType(.password)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
            }
        }.overlay(alignment: .trailing) {
            Image(systemName: isSecureField ? "eye.slash": "eye")
                .onTapGesture {
                    isSecureField.toggle()
                }
        }
    }
}

struct SecureTextFieldView_Previews: PreviewProvider {
    struct Wrapper: View {
        @State var value: String = ""
        var body: some View { SecureTextFieldView(text: $value).padding() }
    }
    static var previews: some View {
        Wrapper()
            .previewLayout(.sizeThatFits)
    }
}
