//
//  AccountView.swift
//  account
//
//  Created by Student on 19.03.2024.
//

import SwiftUI

import PhotosUI
struct AccountView: View {
    @State private var firstname: String = "John"
    @State private var lastname: String = "Smith"
    @State private var email: String = "JohnSmith@email.com"
    @State private var nickname: String = "john"
    @State private var phone: String = "+7(916)0000000"
    @State var date = Date(timeIntervalSinceReferenceDate: 0)
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @State private var shouldPresentPhotoPicker: Bool = false
    
    var body: some View {
        Form {
            Section {
                TextField("First name", text: $firstname)
                TextField("Last name", text: $lastname)
                TextField("Email", text: $email)
                TextField("Nickname", text: $nickname)
                TextField("Phone", text: $phone)
                
                DatePicker("Date of Birth", selection: $date)
            }
        }
        
        HStack{
          VStack {
              
              if(avatarImage == nil) {
                Image(systemName: "person")
                      .font(.system(size: 60, weight: .medium))
              } else {
                avatarImage?
                    .resizable()
                    .frame(width: 80, height: 80)
                    .aspectRatio(contentMode: .fit)
              }
              
              Button(action: {
                  shouldPresentPhotoPicker = true;
              }, label: {
                 Image(systemName: "person").font(.system(size: 60, weight: .medium))
              })
              .photosPicker(isPresented: $shouldPresentPhotoPicker,
                      selection: $avatarItem)
          }
            
          .onChange(of: avatarItem) {
              _ in
              Task {
                if let loaded = try? await avatarItem?.loadTransferable(type: Image.self) {
                   avatarImage = loaded
                   } else {
                   print("Failed")
                   }
             }
          }
            
            VStack {
                Text(firstname + " " + lastname)
               .font(.title)
               .frame(maxWidth: .infinity,
                      alignment: .leading)
                                    
               Text(email)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
            }
        }
    }
}



struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
