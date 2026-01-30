//
//  WorkplaceDetailsView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import SwiftUI

struct WorkplaceDetailsView: View {
    @EnvironmentObject var usersVM: UsersViewModel
    @EnvironmentObject var appData: ApplicationData
    
    var body: some View {
        VStack {
            Text("Workplace Details")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.title)
                .fontWeight(.bold)
            
            if let user = usersVM.currentUser {
                Group {
                    Text("\(Text("Name: ").bold())\(user.workPlaceName)")
                    Text("\(Text("Position: ").bold())\(user.workPlacePosition)")
                    Text("\(Text("Account Type: ").bold())\(user.accountType)")
                    Text("\(Text("Items: ").bold())\(itemsList)")
                }
                .multilineTextAlignment(.center)
                .font(.system(size: 20))
                .padding()
            } else {
                Text("No user data available")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
    
    private var itemsList: String {
        let names = appData.listOfItems.map { $0.name }
        if names.isEmpty {
            return "No items"
        } else if names.count == 1 {
            return names[0]
        } else {
            let allButLast = names.dropLast().joined(separator: ", ")
            return "\(allButLast) & \(names.last ?? "")"
        }
    }
}

struct WorkplaceDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkplaceDetailsView()
            .environmentObject(UsersViewModel())
            .environmentObject(ApplicationData())
    }
}