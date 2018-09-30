//
//  Episode.swift
//  WikiGOT
//
//  Created by Noelia Alvarez on 28/09/2018.
//  Copyright © 2018 Noelia Alvarez. All rights reserved.
//

import Foundation

final class Episode {

    // MARK: - Properties
    let name: String
    let airDate: Date
    weak var season: Season? 

    // MARK: - Initialization
    init(name: String, airDate: Date, season: Season) {
        self.name = name
        self.airDate = airDate
        self.season = season

        // TODO: Add episode in season directly

    }
}

extension Episode: CustomStringConvertible {
    var description: String {
        return "Title: \(name), Air date: \(airDate.toString()), \(season!.name)"
    }
}

extension Episode {
    var proxyForEquality: String {
        return "\(name)\(airDate.toString(style: .short))"
    }

    var proxyForComparison: String {
        return airDate.toString(style: .short)
    }
}

extension Episode: Equatable {
    static func ==(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Episode: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Episode: Comparable {
    static func < (lhs: Episode, rhs: Episode) -> Bool {
        // Alphabetic order
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
