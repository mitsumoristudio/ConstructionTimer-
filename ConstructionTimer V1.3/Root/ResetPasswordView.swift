//
//  ResetPasswordView.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 4/29/24.
// Copyright 2024 Satoshi Mitsumori. All rights reserved.

import Foundation
import SwiftUI


struct ResetPasswordView: View {
    @StateObject var viewModel = RegistrationViewModel()
    @State var email: String = ""
    @Environment(\.dismiss) var dismiss
    @State var animate: Bool = false
    
    func sendButtonUI() -> some View {
        Text("Send Reset Password Link")
            .font(.headline)
            .foregroundColor(Color.white)
            .frame(width: 320, height: 50)
            .background(Color.black).opacity(0.9)
            .clipShape(Capsule())
            .padding()
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Image("Capsule_Construction")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 70, height: 70)
                    .opacity(0.9)
                    .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    TextField("Enter your email", text: $email)
                        .autocapitalization(.none)
                        .modifier(ThreadTextFieldModifier())
                        .padding(.vertical, 10)
                    
                    Button(action: {
                        Task {
                            try await viewModel.resetUserPassword(email: email)
                        }
                    }, label: {
                        sendButtonUI()
                    })
                    .disabled(email == "" || animate)
                    .opacity(email == "" ? 0.7: 1)
                    
                    .padding(.horizontal, 20)
                    
                    
                    Spacer()
                    
                    Divider()
                    
                    VStack(alignment: .center, spacing: 5) {
                        Group {
                            Text("Note: Check junk email box for link")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.vertical, 5)
                            
                            
                            Button(action: {
                                dismiss()
                            }, label: {
                                HStack {
                                    Text("Don't have an account:")
                                        .font(.system(size: 16))
                                    Text("Sign Up")
                                        .font(.system(size: 16, weight: .bold))
                                        .underline()
                                }
                                .foregroundStyle(Color.black)
                            })
                        }
                    }
                    .padding(.horizontal, 60)
                    .navigationBarBackButtonHidden(true)
                }
                }
            }
            
        }
    }

struct ResetPasswordView_Preview: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
