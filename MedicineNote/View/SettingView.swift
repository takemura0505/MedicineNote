//
//  SettingView.swift
//  MedicineNote
//
//  Created by 竹村はるうみ on 2024/03/12.
//

import SwiftUI

struct SettingView: View {
    
    @State private var nameTextField: String = ""
    
    var body: some View {
        VStack(spacing: 50) {
            HStack {
                Text("お薬の名前")
                Spacer()
                TextField("名前を入力", text: $nameTextField)
                    .padding()
                    .frame(width: 200, height: 45)
                    .background(.lightGray)
                    .clipShape(Capsule())
            }
            .padding()
            HStack {
                Text("お薬の量")
                Spacer()
                TextField("量を入力", text: $nameTextField)
                    .padding()
                    .frame(width: 200, height: 45)
                    .background(.lightGray)
                    .clipShape(Capsule())
            }
            .padding()
            HStack {
                Text("お薬を飲む時間")
                Spacer()
                TextField("お薬を飲む時間を入力", text: $nameTextField)
                    .padding()
                    .frame(width: 200, height: 45)
                    .background(.lightGray)
                    .clipShape(Capsule())
            }
            .padding()
            ZStack {
                Capsule()
                    .frame(width: 250, height: 50)
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
            }
                
        }
    }
}

#Preview {
    SettingView()
}
