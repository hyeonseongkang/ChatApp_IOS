//
//  ContentView.swift
//  ChatApp
//
//  Created by 강현성 on 2021/08/19.
//  Copyright © 2021 Mirror. All rights reserved.
//

import SwiftUI
import FirebaseDatabase

struct ContentView: View {

    let ref = Database.database().reference().child("user")
    @ObservedObject var friendsList = FriendList()
    
    @State var friendCount = 0
    
    @State var name: String = ""
    @State var show = false
    @State var image:Data = .init(count:0)
    
    @State var imagePickerVisible: Bool = false
    @State var selectedImage: Image? = Image(systemName: "photo")
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    
                    ZStack {
                        VStack {
                            selectedImage?
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            
                            Button(action: {
                                withAnimation {
                                    self.imagePickerVisible.toggle()
                                }
                            }) {
                                Text("Select an Image")
                            }
                        }.padding()
                        
                        if(imagePickerVisible) {
                            MyImagePicker(imagePickerVisible: $imagePickerVisible, selectedImage: $selectedImage)
                        }
                    }

             
                    List(friendsList.list) { i in
                        Text(i.name)
                       
                    }
                    
                    
                    if self.image.count != 0 {
                        Image(uiImage: UIImage(data: self.image)!).resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    } else {
                        Button (action: {
                            self.show.toggle()
                        }) {
                            Image(systemName: "person.circle.fill")
                            .resizable()
                                .frame(width:55, height: 55)
                            .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth:1))
                        }
                    }
                    
                    TextField("Username..", text: self.$name).padding()
                        .background(Color(red: 230.0/255, green: 234.0/255, blue: 243.0/255))
                    .cornerRadius(20)
                    
                    
                    Button(action: {
                        var a = self.convertImageToBase64String(img: UIImage(data: self.image)!)
    
                        
                        //userId : String, userName: String, userPw : String, userKey: String, userPhone: String, userEmail:  String, userProfile: String
                        
                        self.friendsList.addInfo(userId: "aa", userName: "123", userPw: "aaaa", userKey: "aaaaa", userPhone: "12312312", userEmail: "123123", userProfile: a)
                        //Text(self.convertImageToBase64String(img: UIImage(systemName: self.selectedImage)!))
                       // print(self.convertImageToBase64String(img: UIImage(data: self.image)!))
                    }) {
                        Text("convert")
                    }
        
                }
            }
            
        }.sheet(isPresented: self.$show, content: {
            ImagePicker(show: self.$show, image: self.$image)
        })
            


    
    }
    
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
/*
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
    let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
    let image = UIImage(data: imageData!)
    return image!
    }
  */

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
