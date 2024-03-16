//
//  HomeView.swift
//  MedicineNote
//
//  Created by 竹村はるうみ on 2024/03/11.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = MedicineViewModel(context: PersistenceController.shared.container.viewContext)
    @StateObject var historyViewModel = MedicationHistoryViewModel(context: PersistenceController.shared.container.viewContext)
    @State private var showingSettingSheet = false
    @State private var showingTakenSheet = false
    @State private var selectedMedicine: Medicine? = nil
    
    
    var body: some View {
        NavigationView {
            VStack {
                topBarView
                medicineScheduleView
                buttonView
            }
            .sheet(isPresented: $showingSettingSheet) {
                SettingView(showingSettingSheet: $showingSettingSheet, viewModel: viewModel, medicine: selectedMedicine)
            }
            .sheet(isPresented: $showingTakenSheet) {
                TakenView(viewModel: viewModel, historyViewModel: historyViewModel, showingTakenSheet: $showingTakenSheet)
            }
        }
        .accentColor(Color(uiColor: .label))
    }
    
}

#Preview {
    HomeView()
}

extension HomeView {
    
    private var topBarView: some View {
        HStack {
            Spacer()
            Text("お薬")
                .font(.title3.bold())
            Spacer()
        }
        .padding()
    }
    
    private var buttonView: some View {
        ZStack {
            HStack {
                drunkButtonView
                    .onTapGesture {
                        showingTakenSheet = true
                    }
                historyButtonView
            }
            addButtonView
                .onTapGesture {
                    selectedMedicine = nil
                    showingSettingSheet = true
                }
        }
    }
    
    private var addButtonView: some View {
        ZStack {
            Circle()
                .frame(height: 100)
                .padding(.bottom)
                .foregroundColor(.lightOrange)
            VStack {
                Image(systemName: "plus")
                    .font(.title)
                    .padding(5)
                Text("追加")
                    .font(.caption)
            }
        }
    }
    
    private var drunkButtonView: some View {
        ZStack {
            Rectangle()
                .frame(height: 80)
                .foregroundColor(.lightGreen)
            VStack {
                Image(systemName: "mug")
                    .font(.title)
                    .padding(5)
                Text("飲んだ")
                    .font(.caption)
            }
        }
    }
    
    private var historyButtonView: some View {
        NavigationLink(destination: HistoryView(historyViewModel: historyViewModel)) {
            ZStack {
                Rectangle()
                    .frame(height: 80)
                    .foregroundColor(.lightPink)
                VStack {
                    Image(systemName: "clock")
                        .font(.title)
                        .padding(5)
                    Text("履歴")
                        .font(.caption)
                }
            }
            .foregroundColor(Color(uiColor: .label))
        }
    }
    
    private var medicineScheduleView: some View {
        ScrollView {
            Spacer(minLength: 5)
            ForEach(viewModel.medicineData, id: \.self) { medicine in
                MedicineListView(viewModel: viewModel, medicine: medicine)
                    .padding(.horizontal)
                    .onTapGesture {
                        selectedMedicine = medicine
                        showingSettingSheet = true
                    }
            }
        }
        .onAppear {
            viewModel.fetchMedicines()
        }
    }
    
}
