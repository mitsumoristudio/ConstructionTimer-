//
//  CategoryCell.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 4/4/24.
//

import Foundation
import SwiftUI



struct CategoryCell: View {

    @StateObject var coreDataVM: CoreDataViewModel
 
    var backgroundGradientlight =  Color(#colorLiteral(red: 0.3628445035, green: 0.8369211084, blue: 0.7693976097, alpha: 0.7386692881))
    @State var category: String = ""
    @State var description: String = ""
    @State var dateSelect: Date = .init()
    @State var projectName: String = ""
    @State var client: String = ""
    @State var projectLocation: String = ""
    @Environment(\.dismiss) var dismiss
    @Binding var needtoRefresh: Bool
    let delayCollection: JikanEntity
    
    func TitleView(_ value: String,_ color: Color = .white.opacity(0.7))->some View{
        Text(value)
            .font(.system(size: 16))
            .foregroundColor(color)
            .fontWeight(.semibold)
    }
    
    var body: some View {
        NavigationStack {
                
            ZStack {
                backgroundGradientlight
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                            
                            TitleView("Category")
                        TextField("Category", text: $category)
                       //     TextField(coreDataVM.editTasks?.category ?? "Edit Category", text: $category)
                                .font(.headline)
                                .padding(.top, 2)
                                .foregroundColor(Color.white)
                                .modifier(TextFieldClearButton(nextText: $category))
                            
                            Rectangle()
                                .fill(.white.opacity(0.8))
                                .frame(height: 1)
                            
                            TitleView("Description")
                            
                        TextField("Delay Description", text: $description)
                         //   TextField(coreDataVM.editTasks?.delayDescription ?? "Delay Description", text: $description)
                                .font(.headline)
                                .padding(.top, 2)
                                .foregroundColor(Color.white)
                                .modifier(TextFieldClearButton(nextText: $description))
                            
                            Rectangle()
                                .fill(.white.opacity(0.8))
                                .frame(height: 1)
                            
                            TitleView("Date")
                            
                            HStack(alignment: .bottom, spacing: 12) {
                                HStack(spacing: 12) {
                             //       Text(coreDataVM.editTasks?.startDate ?? "\(dateSelect.toString("EEEE dd, MMMM"))")
                                    Text(dateSelect.toString("EEEE dd, MMMM"))
                                        .font(.subheadline)
                                    
                                    Image(systemName: "calendar")
                                        .font(.title3)
                                        .foregroundColor(Color.white)
                                        .overlay {
                                            DatePicker("", selection: $dateSelect, displayedComponents: [.date])
                                                .blendMode(.destinationOver)
                                        }
                                }
                                .offset(y: -5)
                                .overlay(alignment: .bottom) {
                                    Rectangle()
                                        .fill(.white.opacity(0.8))
                                        .frame(height: 1)
                                        .offset(y: 5)
                                }
                                HStack(spacing: 12) {
                                    Text(dateSelect.toString("hh:mm a"))
                                        .font(.subheadline)
                                    
                                    Image(systemName: "clock")
                                        .font(.title3)
                                        .foregroundColor(Color.white)
                                        .overlay {
                                            DatePicker("", selection: $dateSelect, displayedComponents: [.hourAndMinute])
                                                .blendMode(.destinationOver)
                                        }
                                }
                                .offset(y: -5)
                                .overlay(alignment: .bottom) {
                                    Rectangle()
                                        .fill(.white.opacity(0.8))
                                        .frame(height: 1)
                                        .offset(y: 5)
                                }
                            }
                            .padding(.vertical, 10)
                            
                            VStack(alignment: .leading, spacing: 10) {
                                TitleView("Project Name")
                                
                                TextField( "Project Name", text: $projectName)
                                    .font(.headline)
                                    .padding(.top, 2)
                                    .foregroundColor(Color.white)
                                    .modifier(TextFieldClearButton(nextText: $projectName))
                                
                                Rectangle()
                                    .fill(.white.opacity(0.8))
                                    .frame(height: 1)
                                
                                TitleView("Client")
                                
                                TextField("Enter Client", text: $client)
                                    .font(.headline)
                                    .padding(.top, 2)
                                    .foregroundColor(Color.white)
                                    .modifier(TextFieldClearButton(nextText: $client))
                                
                                Rectangle()
                                    .fill(.white.opacity(0.8))
                                    .frame(height: 1)
                                
                                TitleView("Location")
                                
                                TextField( "City, State", text: $projectLocation)
                                    .font(.headline)
                                    .padding(.top, 2)
                                    .foregroundColor(Color.white)
                                    .modifier(TextFieldClearButton(nextText: $projectLocation))
                                
                                Rectangle()
                                    .fill(.white.opacity(0.8))
                                    .frame(height: 1)
                                
                                VStack(spacing: 20) {
                                    Button(action: {
                                        if !category.isEmpty {
                                            delayCollection.category = category
                                            delayCollection.delayDescription = description
                                            delayCollection.projectName = projectName
                                            delayCollection.projectlocation = projectLocation
                                            delayCollection.client = client
                                            
                                            coreDataVM.saveConstructionTime()
                                            
                                            needtoRefresh.toggle()
                                            
                                            dismiss()
                                        }
                                            
                                            
                                        
                                    }, label: {
                                        Text("Save")
                                            .foregroundStyle(Color.white)
                                            .font(.title2)
                                    })
                                    .frame(width: 160, height: 55, alignment: .center)
                                    .background(Color.indigo)
                                    .clipShape(Capsule())
                                    .padding(.horizontal, 100)
                                    .padding(.vertical, 60)
                                }
                                
                            }
                    }
                    .padding()
                }
                .scrollDismissesKeyboard(.immediately)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading, content: {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "chevron.backward.circle")
                        .foregroundColor(Color.white)
                        .background(Color.black, in: Circle())
                        .font(.title)
                })
            })
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button(action: {
                  
                   
                    dismiss()
                }, label: {
                    Image(systemName: "plus.circle")
                        .foregroundColor(Color.white)
                        .background(Color.black, in: Circle())
                        .font(.title)
                })
            })
        }
    }
}

//struct CategoryCell_Preview: PreviewProvider {
//    static var previews: some View {
//        CategoryCell(needsRefresh: .constant(false), needtoRefresh: .constant(false), delayCollection: <#JikanEntity#>)
//    }
//}



extension Date {
    func toString(_ format: String)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}


