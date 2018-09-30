//
//  Season.swift
//  WikiGOT
//
//  Created by Noelia Alvarez on 28/09/2018.
//  Copyright © 2018 Noelia Alvarez. All rights reserved.
//

import Foundation

typealias Episodes = Set<Episode>

final class Season {

    // MARK: - Properties
    let name: String
    let firstAiredDate: Date
    private var _episodes: Episodes

    var sortedEpisodes: [Episode] {
        return _episodes.sorted()
    }
    
    // MARK: - Initialization
    init(name: String, firstAiredDate: Date) {
        self.name = name
        self.firstAiredDate = firstAiredDate
        self._episodes = Episodes()
    }
}


extension Season {
    var count: Int {
        return _episodes.count
    }

    func add(episode: Episode) {
        _episodes.insert(episode)
    }

    func add(episodes: Episode...) {
        episodes.forEach { add(episode: $0) }
    }
}

extension Season: CustomStringConvertible {
    var description: String {
        return "\(name), First Aired date: \(firstAiredDate.toString())"
    }
}

extension Season {
    var proxyForEquality: String {
        return "\(name)\(firstAiredDate.toString(style: .short))\(self.count)"
    }

    var proxyForComparison: Date {
        return firstAiredDate
    }
}

extension Season: Equatable {
    static func ==(lhs:Season, rhs:Season) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Season: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue 
    }
}

extension Season: Comparable {
    static func <(lhs: Season, rhs:Season) -> Bool {
        // Alphabetic order
        return (lhs.proxyForComparison < rhs.proxyForComparison)
    }
}
