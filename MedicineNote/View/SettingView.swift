//
//  SettingView.swift
//  MedicineNote
//
//  Created by 竹村はるうみ on 2024/03/12.
//

import SwiftUI
import CoreData

struct SettingView: View {
    
    @State private var selectedTime = Date()
    @Binding var showingSheet: Bool
    @StateObject var viewModel = MedicineViewModel(context: PersistenceController.shared.container.viewContext)
    @State private var nameTextField: String = ""
    @State private var dosageTextField: String = ""
    @State private var deleteButton = false
    let medicine: Medicine?
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            nameView
            dosage
            timeView
            addButtonView
                .onTapGesture {
                    viewModel.addMedicine(name: nameTextField, dosage: dosageTextField, timeString: selectedTime)
                    showingSheet = false
                }
            if deleteButton {
                Button("Delete") {
                    print("Delete action")
                }
                .foregroundColor(.red)
            }
            Spacer()
        }
        .onAppear {
            if let medicine = medicine {
                nameTextField = medicine.name ?? ""
                dosageTextField = medicine.dosage ?? ""
                selectedTime = medicine.time ?? Date()
                deleteButton = true
            }
        }
    }
}

//#Preview {
//    SettingView()
//}

extension SettingView {
    
    private var nameView: some View {
        VStack {
            Text("お薬の名前")
            TextField("例 : 痛み止め", text: $nameTextField)
                .padding()
                .frame(width: 200, height: 45)
                .background(.lightGray)
                .clipShape(Capsule())
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(uiColor: .label), lineWidth: 5)
        )
    }
    
    private var dosage: some View {
        VStack {
            Text("お薬の量")
            TextField("例 : 2粒", text: $dosageTextField)
                .padding()
                .frame(width: 200, height: 45)
                .background(.lightGray)
                .clipShape(Capsule())
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(uiColor: .label), lineWidth: 5)
        )
    }
    
    private var timeView: some View {
        VStack {
            Text("お薬を飲む時間")
            DatePicker(
                "時間を選択",
                selection: $selectedTime,
                displayedComponents: .hourAndMinute
            )
            .labelsHidden()
            .datePickerStyle(WheelDatePickerStyle())
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(uiColor: .label), lineWidth: 5)
        )
    }
    
    private var addButtonView: some View {
        ZStack {
            Capsule()
                .frame(width: 250, height: 50)
                .foregroundColor(Color(uiColor: .label))
            Text("追加")
                .foregroundColor(Color(uiColor: .systemBackground))
        }
    }
    
}
