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
import Firebase
import GoogleSignIn
import GoogleSignInSwift


struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @StateObject var viewModel = LoginViewModel()
    @Environment(\.colorScheme) var colorScheme
    @State var animate: Bool = false
    
    @State var isLoading: Bool = false
    @AppStorage("log_Status") var log_Status = false
    
    private func getScreenReact() -> CGRect {
        return UIScreen.main.bounds
        
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 5) {
                
                Image("LoginPic")
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
                .disabled(password == "" || animate)
                .opacity(password == "" ? 0.8 : 1)
                .padding()
                
                Button(action: {
                    Task {
                 //       try await viewModel.signInwithGoogle()
                        try await googleHandleSignIn()
                    }
                    
                }, label: {
                    googleinView()
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

extension LoginView {
    func googleinView() -> some View {
        VStack(alignment: .leading) {
            HStack() {
                Image("googlelogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35, alignment: .center)
                    .cornerRadius(20)
                Text("Sign in with Google")
            }
            .frame(width: 352, height: 45)
            .background(.thickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
    }

extension LoginView {
    func googleHandleSignIn() async throws {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Creating Google SignIn Configuration object
        let config = GIDConfiguration(clientID: clientID)
        
        isLoading = true
        
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene =  UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window =  windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            print("There is no root view controller")
          return
        }
        do {
            let userAutentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            let user = userAutentication.user
            guard let idToken = user.idToken else {
                throw fatalError("ID token missing")
            }
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            
            let result = try await Auth.auth().signIn(with: credential)
            let firebaseUser = result.user
            print("User \(firebaseUser.uid) sign  in with email \(firebaseUser.email ?? "unknown")")
            
            withAnimation {
                log_Status = true
            }
            
            return
        } catch {
            print(error.localizedDescription)
        }
        }
    
}

