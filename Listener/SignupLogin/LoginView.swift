//
//  ContentView.swift
//  Oral
//
//  Created by user207270 on 7/18/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var wrongusername = 0
    @State private var wrongpassword = 0
    @State private var showingLoginScreen = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.blue.ignoresSafeArea()
                Circle().scale(1.35).foregroundColor(.green)
                
                Circle().scale(1.7).foregroundColor(.white)
                
                VStack{
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField ("Username",text:$username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(Color.red,width: CGFloat(wrongusername))
                    
                    SecureField ("Password",text:$password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(Color.red,width: CGFloat(wrongpassword))
                    
                    Button("Login"){
                 autheticateuser(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                    NavigationLink(
                        destination:Text("You are Log in @\(username)"),isActive: $showingLoginScreen) { EmptyView()}
                    
                
                }
            }
                   }
            .navigationBarHidden(true)
    }
    func autheticateuser(username: String, password: String)  {
        if username.lowercased() == "group8" {
            wrongusername = 0
            if password.lowercased() == "abc123"{
                wrongpassword = 0
                showingLoginScreen = true
            }else{
                wrongpassword = 2
            }} else {
                wrongusername = 2
            }
        
    }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

