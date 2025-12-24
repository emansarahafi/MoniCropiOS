//
//  ErrorView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/21/23.
//

import SwiftUI

struct ErrorView : View {
    @Binding var alert : Bool
    @Binding var error : String
    
    var body: some View{
        
        GeometryReader{_ in
            VStack{
                HStack{
                    Text(self.error == "RESET" ? "Message" : "Error")
                        .titleStyle()
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    
                    Spacer()
                }
                .padding(.horizontal, 25)
                
                Text(self.error == "RESET" ? "Password reset link has been sent successfully" : self.error)
                    .foregroundColor(Color.black)
                .padding(.top)
                .padding(.horizontal, 25)
                
                Button(action: {
                    
                    self.alert.toggle()
                    
                }) {
                    
                    Text(self.error == "RESET" ? "Ok" : "Cancel")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 120)
                }
                .tint(.accent)
                .bodyStyle()
                .accessibilityIdentifier("errorAlertOkButton")
                .accessibilityLabel(self.error == "RESET" ? "Ok" : "Cancel")
                .accessibilityHint("Dismisses the message")
                .padding(.top, 25)
                
            }
            .padding(.vertical, 25)
            .frame(width: UIScreen.main.bounds.width - 70)
            .background(Color.white)
            .cornerRadius(15)
        }
        .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
    }
}

struct ErrorViewPreviewView: View {
    @State var alert: Bool = true
    @State var error: String = "Sample error message"
    var body: some View {
        ErrorView(alert: $alert, error: $error)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ErrorViewPreviewView()
        }
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
