//
//  Date+Format.swift
//  WikiGOT
//
//  Created by Noelia Alvarez on 29/09/2018.
//  Copyright © 2018 Noelia Alvarez. All rights reserved.
//

import Foundation

extension Date {
    func toString(style: DateFormatter.Style = .long) -> String {
        // US English Locale (en_US)
        let formatter = DateFormatter()
        formatter.dateStyle = style
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: self)
    }
}

extension DateFormatter {

    static var customDateFormatter: DateFormatter = {
        // US English Locale (en_US)
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()

}


extension String {
    // Created just to simplify the repository file...
    func toDate(style: DateFormatter.Style = .long) -> Date {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "en_US")
        return formatter.date(from: self)!
    }
}

