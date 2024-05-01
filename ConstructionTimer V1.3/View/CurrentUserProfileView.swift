//
//  CurrentUserProfileView.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 4/29/24.
//

import Foundation
import SwiftUI
import Firebase
import GoogleSignIn

struct CurrentUserProfileView: View {
    @StateObject var viewModel = CurrentuserProfileViewModel()
    @State private var showEditProfile: Bool = false
    
    @AppStorage("log_Status") var log_Status: Bool = false
    
    private var currentUser: UserModel? {
        return viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false, content: {
                
                VStack(spacing: 20) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 12) {
                            
                            VStack(alignment: .leading, spacing: 4) {
                                //  Text("Stashville") or
                                Text(currentUser?.fullname ?? "")
                                
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                Text(currentUser?.username ?? "")
                                
                                //      Text("stashville_nashville")
                                    .font(.subheadline)
                                
                                Spacer()
                                
                                CircularProfileImageView(user: currentUser)
                            }
                            Button(action: {
                                showEditProfile.toggle()
                            }, label: {
                                Text("Edit Profile")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.black)
                                    .frame(width: 352, height: 36)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color(.systemGray4), lineWidth: 1)
                                    }
                            })
                            
                        }
                    }
                }
                
            })
            // MARK: Add NavigationStack to show the tool bar and above the scrollview
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        
                        // MARK: Auth service for signing out user with email and pasword
                        AuthService.shared.signOutUser()
                        
                    // MARK: Signing out user using google autentication token
                        
                        GIDSignIn.sharedInstance.signOut()
                        try? Auth.auth().signOut()
                        
                        withAnimation {
                            log_Status = false
                        }
                        
                    }, label: {
                        HStack {
                            Text("Sign Out")
                            Image(systemName: "line.3.horizontal")
                        }
                    })
                    .font(.subheadline)
                    .foregroundColor(Color.black)
                }
            }
        }
    }
}
