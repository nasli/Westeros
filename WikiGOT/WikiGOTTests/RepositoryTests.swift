//
//  RepositoryTests.swift
//  WikiGOTTests
//
//  Created by Noelia Alvarez on 28/09/2018.
//  Copyright © 2018 Noelia Alvarez. All rights reserved.
//

import XCTest

@testable import WikiGOT

class RepositoryTests: XCTestCase {

    var localHouses: [House]!
    var localSeasons: [Season]!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        localHouses = Repository.local.houses
        localSeasons = Repository.local.seasons
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        localHouses = nil
        localSeasons = nil
    }

    func testLocalRepositoryExistence() {
        XCTAssertNotNil(Repository.local)
    }

    // MARK: - Houses

    func testLocalRepositoryHousesCreation() {
        XCTAssertNotNil(localHouses)
        XCTAssertEqual(localHouses.count, 3)
    }

    func testLocalRepositoryReturnSortedArrayOfHouses() {
        XCTAssertEqual(localHouses, localHouses.sorted())
    }

    func testLocalRepositoryReturnsHousesByNameCaseInsensitively() {
        let stark = Repository.local.house(named: "sTaRk")

        XCTAssertEqual(stark?.name, "Stark")

        let keepcoding = Repository.local.house(named: "Keepcoding")
        XCTAssertNil(keepcoding)
    }

    func testLocalRepositoryReturnsHousesByNameType() {
        let stark = Repository.local.house(named: .stark)

        XCTAssertEqual(stark?.name, "Stark")
    }

    func testLocalRepositoryHouseFiltering() {
        var filtered = Repository.local.houses {$0.count == 1}
        XCTAssertEqual(filtered.count, 1)

        filtered = Repository.local.houses {$0.count == 100}
        XCTAssertTrue(filtered.isEmpty)
    }

    // MARK: - Seasons

    func testLocalRepositorySeasonCreation() {
        XCTAssertNotNil(localSeasons)
        XCTAssertEqual(localSeasons.count, 7)
    }
}
