//
//  Person.swift
//  WikiGOT
//
//  Created by Noelia Alvarez on 28/09/2018.
//  Copyright © 2018 Noelia Alvarez. All rights reserved.
//

import Foundation

final class Person {

    // MARK: - Properties
    let name: String
    weak var house: House?
    private let _alias: String?

    var alias: String {
        get{
            return _alias ?? ""
        }
    }

    // MARK: - Initialization
    init(name: String, alias: String? = nil, house: House) {
        self.name = name
        self._alias = alias
        self.house = house
    }
}

extension Person {
    var fullName: String {
        return "\(name) \(house!.name)"
    }
}

extension Person {
    var proxyForEquality: String {
        return "\(name)\(alias)\(house!.name)"
    }

    var proxyForComparison: String {
        return fullName.uppercased()
    }
}

extension Person: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Person: Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        // Alphabetic order
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

