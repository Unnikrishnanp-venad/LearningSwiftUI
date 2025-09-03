//
//  DetailView.swift
//  Sample App
//
//  Created by Unnikrishnan Parameswaran on 03/09/25.
//

import SwiftUI

struct DetailView: View {
    @Binding var user: User
    @State private var tempName: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form{
            Section(header: Text("Edit"), content: {
                TextField("Name", text: $tempName)
            })
        }.toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("save"){
                    user.name = tempName
                    dismiss()
                }
            }
        }.onAppear(){
            tempName = user.name
        }
        
    }
}
