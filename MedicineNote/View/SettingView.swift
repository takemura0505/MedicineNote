//
//  SettingView.swift
//  MedicineNote
//
//  Created by 竹村はるうみ on 2024/03/12.
//

import SwiftUI
import CoreData

struct SettingView: View {
    
    @Binding var showingSheet: Bool
    @StateObject var viewModel = MedicineViewModel(context: PersistenceController.shared.container.viewContext)
    @State private var nameTextField: String = ""
    @State private var dosageTextField: String = ""
    @State private var timeTextField: String = ""
    
    var body: some View {
        VStack(spacing: 50) {
            nameView
            dosage
            timeView
            addButtonView
                .onTapGesture {
                    viewModel.addMedicine(name: nameTextField, dosage: dosageTextField, timeString: timeTextField)
                    showingSheet = false
                }
        }
    }
}

//#Preview {
//    SettingView()
//}

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
            TextField("量を入力", text: $dosageTextField)
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
            TextField("お薬を飲む時間を入力", text: $timeTextField)
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
