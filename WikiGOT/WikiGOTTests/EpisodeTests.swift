//
//  EpisodeTests.swift
//  WikiGOTTests
//
//  Created by Noelia Alvarez on 28/09/2018.
//  Copyright © 2018 Noelia Alvarez. All rights reserved.
//

import XCTest
@testable import WikiGOT

class EpisodeTests: XCTestCase {

    var season1: Season!
    var episode1_1: Episode!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        season1 = Season(name: "Season1", firstAiredDate: "April 17, 2011".toDate())
        episode1_1 = Episode(name: "Winter is Coming", airDate: "April 17, 2011".toDate(), season: season1)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEpisodeExistence() {
        XCTAssertNotNil(episode1_1)
    }

    func testSeason_DisplayEpisode_ShownCustomRepresentationOfEpisode() {
        XCTAssertEqual(episode1_1.description,
            "Title: Winter is Coming, Air date: April 17, 2011, Season1",
                        "Error episode description wrong")
    }

    func testEpisodeEquality() {
        // 1. Identity
        XCTAssertEqual(episode1_1, episode1_1)

        //2. Equality
        let episode = Episode(name: "Winter is Coming", airDate: "April 17, 2011".toDate(), season: season1)
        XCTAssertEqual(episode, episode1_1)

        //3. Inequity
        let episode1_2 = Episode(name: "The Kingsroad", airDate: "April 24, 2011".toDate(), season: season1)
        XCTAssertNotEqual(episode1_1, episode1_2)
    }

    func testEpisodeHashable() {
        XCTAssertNotNil(episode1_1.hashValue)
    }

    func testEpisodeComparison() {
        let episode1_2 = Episode(name: "The Kingsroad", airDate: "April 24, 2011".toDate(), season: season1)
        let episode1_3 = Episode(name: "Lord Snow", airDate: "May 1, 2011".toDate(), season: season1)
        XCTAssertLessThan(episode1_2, episode1_3, "Error comparing episodes: Episode2 is not less than Episode3")
        XCTAssertGreaterThan(episode1_2, episode1_1, "Error comparing episodes: Episode2 is not greater than Episode1")
    }


}
