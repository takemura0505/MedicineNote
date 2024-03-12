//
//  Medicine.swift
//  MedicineNote
//
//  Created by 竹村はるうみ on 2024/03/12.
//

import Foundation

struct Medicine: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var dosage: String
    var time: Date
}
