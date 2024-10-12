//
//  Formatters.swift
//  unitedsetups
//
//  Created by Paras KCD on 11/10/24.
//

import Foundation

struct Formatters {
    public static func getDateFromString(_ dateTimeString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        return dateFormatter.date(from:dateTimeString) ?? Date()
    }
}
