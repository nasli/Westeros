//
//  Repository.swift
//  WikiGOT
//
//  Created by Noelia Alvarez on 28/09/2018.
//  Copyright © 2018 Noelia Alvarez. All rights reserved.
//

import UIKit

final class Repository {
    static let local = LocalFactory()
}

enum houseNameType: String {
    case lannister
    case stark
    case targaryen
}

protocol HouseFactory {
    typealias FilterHouse = (House) -> Bool

    var houses: [House] { get }

    func house(named name: String) -> House?
    func house(named type: houseNameType) -> House?

    func houses(filteredBy filter: FilterHouse ) -> [House]
}

protocol SeasonFactory {
    typealias FilterSeason = (Season) -> Bool

    var seasons: [Season] { get }

    func season(named: String) -> Season?
    func seasons(filteredBy filter: FilterSeason ) -> [Season]
}

final class LocalFactory: HouseFactory, SeasonFactory {

    var houses: [House] {

        // MARK: - Create Houses

        let starkSigil = Sigil(image: UIImage(named: "codeIsComing")!, description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: UIImage(named: "lannister.jpg")!, description: "Leon rampante")
        let targaryenSigil = Sigil(image: UIImage(named: "targaryenSmall.jpg")!, description: "Dragon tricefalo")

        let starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        let targaryenURL =  URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!

        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: starkURL)
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: lannisterURL )
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y Sangre", url:targaryenURL )

        // Characters
        let robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let jaime = Person(name: "Jaime", alias: "El matarreyes", house: lannisterHouse)
        let dani = Person(name: "Daenerys", alias: "Madre de dragones", house: targaryenHouse)

        starkHouse.add(persons: arya, robb)
        lannisterHouse.add(persons: tyrion, jaime, cersei)
        targaryenHouse.add(person: dani)

        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
    }


    // MARK: - Create Seasons

    var seasons: [Season] {
        let season1 = Season(name: "Season1", firstAiredDate: "April 17, 2011".toDate())
        let season2 = Season(name: "Season2", firstAiredDate: "April 1, 2012".toDate())
        let season3 = Season(name: "Season3", firstAiredDate: "March 31, 2013".toDate())
        let season4 = Season(name: "Season4", firstAiredDate: "April 6, 2014".toDate())
        let season5 = Season(name: "Season5", firstAiredDate: "April 12, 2015".toDate())
        let season6 = Season(name: "Season6", firstAiredDate: "April 24, 2016".toDate())
        let season7 = Season(name: "Season7", firstAiredDate: "July 16, 2017".toDate())

        // Create Episodes
        let episode1_1 = Episode(name: "Winter is Coming", airDate: "April 17, 2011".toDate(), season: season1)
        let episode1_2 = Episode(name: "The Kingsroad", airDate: "April 24, 2011".toDate(), season: season1)

        let episode2_1 = Episode(name: "The North Remembers", airDate: "April 1, 2012".toDate(), season: season2)
        let episode2_2 = Episode(name: "The Night Lands", airDate: "April 8, 2012".toDate(), season: season2)

        let episode3_1 = Episode(name: "Valar Dohaeris", airDate: "March 31, 2013".toDate(), season: season3)
        let episode3_2 = Episode(name: "Dark Wings, Dark Words", airDate: "April 7, 2013".toDate(), season: season3)

        let episode4_1 = Episode(name: "Two Swords", airDate: "April 6, 2014".toDate(), season: season4)
        let episode4_2 = Episode(name: "The Lion and the Rose", airDate: "April 13, 2014".toDate(), season: season4)

        let episode5_1 = Episode(name: "The Wars to Come", airDate: "April 12, 2015".toDate(), season: season5)
        let episode5_2 = Episode(name: "The House of Black and White", airDate: "April 19, 2015".toDate(), season: season5)

        let episode6_1 = Episode(name: "The Red Woman", airDate: "April 24, 2016".toDate(), season: season6)
        let episode6_2 = Episode(name: "Home", airDate: "May 1, 2016".toDate(), season: season6)

        let episode7_1 = Episode(name: "Dragonstone", airDate: "July 16, 2017".toDate(), season: season7)
        let episode7_2 = Episode(name: "Stormborn", airDate: "July 23, 2017".toDate(), season: season7)

        season1.add(episodes: episode1_1, episode1_2)
        season2.add(episodes: episode2_1, episode2_2)
        season3.add(episodes: episode3_1, episode3_2)
        season4.add(episodes: episode4_1, episode4_2)
        season5.add(episodes: episode5_1, episode5_2)
        season6.add(episodes: episode6_1, episode6_2)
        season7.add(episodes: episode7_1, episode7_2)

        return [season1, season2, season3, season4, season5, season6, season7].sorted()
    }


    // MARK: - Handle Houses

    func house(named name: String) -> House? {
        return houses.first{ $0.name.uppercased() == name.uppercased() }
    }

    func house(named type: houseNameType) -> House? {
        return houses.first{ $0.name.lowercased() == type.rawValue }
    }

    func houses(filteredBy: (House) -> Bool) -> [House] {
        return houses.filter(filteredBy)
    }

    // MARK: - Handle Seasons

    func season(named name: String) -> Season? {
        return seasons.first{ $0.name.uppercased() == name.uppercased() }
    }

    func seasons(filteredBy: (Season) -> Bool) -> [Season] {
        return seasons.filter(filteredBy)
    }

}
