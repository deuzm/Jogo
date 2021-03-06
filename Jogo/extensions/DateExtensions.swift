//
//  DateExtensions.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/13/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import Foundation

//MARK: - start/end of week and toString date extension
extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }

    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
    
    var toString: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: TimeZone.current.abbreviation() ?? "")
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: self)
    }
    func convertToLocalTime(fromTimeZone timeZoneAbbreviation: String) -> Date? {
        if let timeZone = TimeZone(abbreviation: timeZoneAbbreviation) {
            let targetOffset = TimeInterval(timeZone.secondsFromGMT(for: self))
            let localOffeset = TimeInterval(TimeZone.autoupdatingCurrent.secondsFromGMT(for: self))

            return self.addingTimeInterval(targetOffset - localOffeset)
        }

        return nil
    }
}
