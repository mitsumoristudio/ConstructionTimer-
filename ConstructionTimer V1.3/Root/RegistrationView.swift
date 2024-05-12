//
//  RegistrationView.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 4/29/24.
// Copyright 2024 Satoshi Mitsumori. All rights reserved.

import Foundation
import SwiftUI

struct RegistrationView: View {
    @ObservedObject var registrationVM = RegistrationViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @Environment (\.dismiss) var dismiss
    
    // Alert
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    func showAlertTitle(title: String) {
        alertTitle = title
        showAlert.toggle()
    }
    
    private func getScreenReact() -> CGRect {
        return UIScreen.main.bounds
    }
    
    
    var body: some View {
        NavigationStack {
            
            VStack(spacing: 10) {
                
                Image("LoginPic2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: getScreenReact().height / 3)
                    .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 18) {
                    TextField("Enter your email", text: $email)
                        .autocapitalization(.none)
                        .modifier(ThreadTextFieldModifier())
                    
                    SecureField("Enter your password", text: $password)
                        .modifier(ThreadTextFieldModifier())
                    
                    TextField("Enter your username", text: $username)
                        .modifier(ThreadTextFieldModifier())
                        .autocapitalization(.none)
                    
                    
                    Button(action: {
                        if password.count >= 4 {
                            Task {
                                try await registrationVM.createUser(email: email,
                                                                    password: password,
                                                                    username: username)
                            }
                        } else {
                            showAlertTitle(title: "Password must contain at least 4 letters or numbers")
                            
                        }
                    }, label: {
                        Text("Sign Up")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.white)
                            .frame(width: 352, height: 44)
                            .background(.black)
                            .cornerRadius(12)
                    })
                    .padding()
                    Spacer()
                    
                    Divider()
                    
                    HStack(alignment: .center, spacing: 10) {
                        Button(action: {
                            dismiss()
                        }, label: {
                            HStack(spacing: 3) {
                                Text("Already have an account:").font(.subheadline) + Text(" Sign In  ").font(.headline).fontWeight(.bold).underline()
                            }
                        }
                        )}
                    .padding(.horizontal, 80)
                }
                .foregroundColor(Color.black)
                .font(.footnote)
                
            }
            .alert(isPresented: $showAlert, content: {
                return Alert(title: Text(alertTitle))
            })
        .padding(.vertical, 16)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct RegistrationView_Preview: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
