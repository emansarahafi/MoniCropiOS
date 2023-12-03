//
//  Components.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/26/22.
//

import SwiftUI

struct SecureTextField: View {
    
    @State private var isSecureField: Bool = true
    @Binding var text: String
    
    var body: some View {
        HStack {
            if isSecureField {
                SecureField("Insert Password", text: $text)
            } else {
                TextField(text, text: $text)
            }
        }.overlay(alignment: .trailing) {
            Image(systemName: isSecureField ? "eye.slash": "eye")
                .onTapGesture {
                    isSecureField.toggle()
                }
        }
    }
}

struct ReSecureTextField: View {
    
    @State private var isSecureField: Bool = true
    @Binding var text: String
    
    var body: some View {
        HStack {
            if isSecureField {
                SecureField("Retype Password", text: $text)
            } else {
                TextField(text, text: $text)
            }
        }.overlay(alignment: .trailing) {
            Image(systemName: isSecureField ? "eye.slash": "eye")
                .onTapGesture {
                    isSecureField.toggle()
                }
        }
    }
}

struct RadioButtonField: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let bgColor: Color
    let textSize: CGFloat
    let isMarked:Bool
    let callback: (String)->()
    
    init(
        id: String,
        label:String,
        size: CGFloat = 20,
        color: Color = Color.black,
        bgColor: Color = Color.black,
        textSize: CGFloat = 14,
        isMarked: Bool = false,
        callback: @escaping (String)->()
        ) {
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.bgColor = bgColor
        self.textSize = textSize
        self.isMarked = isMarked
        self.callback = callback
    }
    
    var body: some View {
        Button(action:{
            self.callback(self.id)
        }) {
            HStack(alignment: .center) {
                Image(systemName: self.isMarked ? "largecircle.fill.circle" : "circle")
                    .clipShape(Circle())
                    .foregroundColor(self.bgColor)
                Text(label)
                    .font(Font.system(size: textSize))
                Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(Color.white)
    }
}

struct User: Identifiable {
    let id = UUID()
    var emailAccount: String = ""
    var password: String = ""
    var accountType: String = ""
    var firstName: String = ""
    var middleName: String = ""
    var lastName: String = ""
    var workPlaceName: String = ""
    var workPlacePosition: String = ""
    var date: Date
}


struct Items: Hashable {
    var image: String
    var name: String
    var date: String
    var price: String
}

struct ItemsViewModel: Identifiable, Hashable {
    let id = UUID()
    var item: Items
    var image: String {
        return item.image
    }
    var name: String {
        return item.name
    }
    var date: String {
        return item.date
    }
    var price: String {
        return item.price
    }
}

class ApplicationData: ObservableObject {
    @Published var listOfItems: [ItemsViewModel]
    @Published var userData: [User]
    
    init() {
        userData = [
            User(emailAccount: "Person1@email.com", password: "1234", accountType: "Farmer", firstName: "Person1Fname", middleName: "Person1Mname", lastName: "Person1Lname", workPlaceName: "Person1WorkPlaceName", workPlacePosition: "Person1WorkPlacePosition", date: Date()),
            
                User(emailAccount: "Person2@email.com", password: "1234", accountType: "Business", firstName: "Person2Fname", middleName: "Person2Mname", lastName: "Person2Lname", workPlaceName: "Person2WorkPlaceName", workPlacePosition: "Person2WorkPlacePosition", date: Date())
                    ]
        
        listOfItems = [
            ItemsViewModel(item:Items(image: "mango", name: "Mango", date: "22 Nov 2022", price: "2 BHD")),
            
            ItemsViewModel(item:Items(image: "apple", name: "Apple", date: "20 Dec 2022", price: "5 BHD")),
            
            ItemsViewModel(item:Items(image: "carrot", name: "Carrot", date: "10 Dec 2022", price: "3 BHD")),
            
            ItemsViewModel(item:Items(image: "strawberry", name: "Strawberry", date: "13 Oct 2022", price: "6 BHD")),
            
            ItemsViewModel(item:Items(image: "pear", name: "Pear", date: "17 Oct 2022", price: "4 BHD")),

            ]
        }
    }

struct CellItem: View {
    let item: ItemsViewModel
    var body: some View {
        HStack {
            Image(item.image)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            VStack (alignment: .leading){
                Text("Item: \(item.name)").bold()
                Text("Date: \(item.date)").bold()
                Text("Price: \(item.price)").bold()
            }
        }
    }
}

struct BarView: View{

    var value: CGFloat
    var cornerRadius: CGFloat
    
    var body: some View {
        VStack {
            ZStack (alignment: .bottom) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: 30, height: 200).foregroundColor(.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: 30, height: value).foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                
            }.padding(.bottom, 8)
        }
        
    }
}

