//
//  SeasonTests.swift
//  WikiGOTTests
//
//  Created by Noelia Alvarez on 28/09/2018.
//  Copyright © 2018 Noelia Alvarez. All rights reserved.
//

import XCTest
@testable import WikiGOT

class SeasonTests: XCTestCase {

    var season1: Season!
    var episode1_1: Episode!
    var episode1_2: Episode!
    var episode1_3: Episode!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        season1 = Season(name: "Season1", firstAiredDate: "April 17, 2011".toDate())
        episode1_1 = Episode(name: "Winter Is Coming", airDate: "April 17, 2011".toDate(), season: season1)
        episode1_2 = Episode(name: "The Kingsroad", airDate: "April 24, 2011".toDate(), season: season1)
        episode1_3 = Episode(name: "Lord Snow", airDate: "May 1, 2011".toDate(), season: season1)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        season1 = nil
        episode1_1 = nil
        episode1_2 = nil
        episode1_3 = nil
    }


    func testSeasonExistence() {

        XCTAssertNotNil(season1, "Season does not exist")
    }

    func testSeason_WithoutEpisodes_ReturnsTheCorrectCountOfEpisodes() {
        XCTAssertEqual(season1.count, 0, "Season count is wrong")
    }

    func testSeason_AddEpisode_ReturnsTheCorrectCountOfEpisodes() {

        season1.add(episode: episode1_1)
        
        XCTAssertEqual(season1.count, 1, "Error adding first episode")
    }

    func testSeason_AddEpisodes_ReturnsTheCorrectCountOfEpisodes() {

        season1.add(episode: episode1_1)
        season1.add(episode: episode1_2)
        season1.add(episode: episode1_3)

        XCTAssertEqual(season1.count, 3, "Error aadding episodes")
    }

    func testSeason_AddDuplicateEpisodes_ReturnsTheCorrectCountOfEpisodes() {

        season1.add(episode: episode1_1)
        season1.add(episode: episode1_1)
        season1.add(episode: episode1_2)

        XCTAssertEqual(season1.count, 2, "Error adding duplicate episodes")
    }

    func testSeason_AddEpisodesAtOnce_ReturnsTheCorrectCountOfEpisodes() {

        season1.add(episodes: episode1_1, episode1_2)

        XCTAssertEqual(season1.count, 2, "Error adding episodes at once")
    }

    func testSeason_AddEpisodeAtOnce_ReturnsTheCorrectCountOfEpisodes() {

        season1.add(episodes: episode1_1)

        XCTAssertEqual(season1.count, 1, "Error adding episodes at once with just one episode")
    }

    func testSeason_DisplayEpisode_ShownCustomRepresentationOfSeason() {
        XCTAssertEqual(season1.description,
                       "Season1, First Aired date: April 17, 2011",
                       "Error season description wrong")
    }

    func testSeasonEquality() {
        // 1. Identity
        XCTAssertEqual(season1, season1)

        //2. Equality
        let season = Season(name: "Season1", firstAiredDate: "April 17, 2011".toDate())
        XCTAssertEqual(season, season1)

        //3. Inequity
        let season2 = Season(name: "Season2", firstAiredDate: "April 1, 2012".toDate())
        XCTAssertNotEqual(season1, season2)
    }

    func testSeasonHashable() {
        XCTAssertNotNil(season1.hashValue)
    }

    func testSeasonComparison() {
        let season2 = Season(name: "Season2", firstAiredDate: "April 1, 2012".toDate())
        let season3 = Season(name: "Season3", firstAiredDate: "March 31, 2013".toDate())
        XCTAssertLessThan(season2, season3, "Error comparing seasons: Season2 is not less than Season3")
        XCTAssertGreaterThan(season2, season1, "Error comparing seasons: Season2 is not greater than Season1")
    }

    

}
