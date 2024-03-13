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
            nameView
            dosage
            timeView
            addButtonView
        }
    }
}

#Preview {
    SettingView()
}

extension SettingView {
    
    var nameView: some View {
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
    }
    
    var dosage: some View {
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
    }
    
    var timeView: some View {
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
    }
    
    var addButtonView: some View {
        ZStack {
            Capsule()
                .frame(width: 250, height: 50)
                .foregroundColor(Color(uiColor: .label))
            Text("追加")
                .foregroundColor(Color(uiColor: .systemBackground))
        }
    }
    
}
