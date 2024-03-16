//
//  Date.swift
//  MedicineNote
//
//  Created by 竹村はるうみ on 2024/03/16.
//

import Foundation

extension Date {
    
    func formatted() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.string(from: self)
    }
    
}

