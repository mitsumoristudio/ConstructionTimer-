//
//  LoginView.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 4/29/24.
//

import Foundation
import FirebaseAuth
import AuthenticationServices
import SwiftUI


struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @StateObject var viewModel = LoginViewModel()
    @Environment(\.colorScheme) var colorScheme
    @State var animate: Bool = false
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                
                Image("Capsule_Construction")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 70, height: 70)
                    .opacity(0.9)
                    .padding()
                
                VStack(alignment: .leading, spacing: 18) {
                    TextField("Enter your email", text: $email)
                        .autocapitalization(.none)
                        .modifier(ThreadTextFieldModifier())
                    
                    SecureField("Enter your password", text: $password)
                        .modifier(ThreadTextFieldModifier())
                    
                }
                
                NavigationLink(destination: {
                    ResetPasswordView()
                }, label: {
                    Text("Forgot Password")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 28)
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                })
                .padding(.top)
                
                Button(action: {
                    Task {
                        try await viewModel.loginUser(email: email, password: password)
                    }
                }, label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                        .frame(width: 352, height: 45)
                        .background(.black)
                        .cornerRadius(12)
                        .padding(.vertical, 10)
                })
                Spacer()
                
                Divider()
                
                NavigationLink(destination: {
                    RegistrationView()
                }, label: {
                    HStack(spacing: 3) {
                        Text("Don't Have An Account:").font(.subheadline) + Text(" Sign Up").font(.headline).fontWeight(.bold)
                    }
                })
                .foregroundColor(Color.black)
                .font(.footnote)
            }
            .padding(.vertical, 16)
            }
        }
    }

struct LoginView_Preview: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
