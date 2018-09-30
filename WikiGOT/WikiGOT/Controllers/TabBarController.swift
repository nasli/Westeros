//
//  TabBarController.swift
//  WikiGOT
//
//  Created by Noelia Alvarez on 30/09/2018.
//  Copyright © 2018 Noelia Alvarez. All rights reserved.
//

import UIKit

enum viewControllerTitle: String {
    case Houses
    case Seasons
}

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let lastHouseSelected = houseListViewController.lastSelectedHouse()
        let houseDetailViewController = HouseDetailViewController(model: lastHouseSelected)
        houseListViewController.delegate = houseDetailViewController

        let lastSeasonSelected = seasonListViewController.lastSelectedSeason()
        let seasonDetailViewControler = SeasonDetailViewController(model: lastSeasonSelected)
        seasonListViewController.delegate = seasonDetailViewControler

        self.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.viewControllers = [houseListViewController.wrappedInNavigation(), seasonListViewController.wrappedInNavigation()]
    }

    lazy public var houseListViewController: HouseListViewController = {

        let houses = Repository.local.houses
        let houseListViewController = HouseListViewController(model: houses)

        let title = viewControllerTitle.Houses.rawValue

        let tabBarItem = UITabBarItem(title: title, image: nil, selectedImage: nil)

        houseListViewController.tabBarItem = tabBarItem

        return houseListViewController
    }()
    

    lazy public var seasonListViewController: SeasonListViewController = {

        let seasons = Repository.local.seasons

        let seasonListViewController = SeasonListViewController(model: seasons)

        let tabBarItem = UITabBarItem(title: viewControllerTitle.Seasons.rawValue, image: nil, selectedImage: nil)

        seasonListViewController.tabBarItem = tabBarItem

        return seasonListViewController
    }()


}

extension TabBarController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")

        if UIDevice.current.userInterfaceIdiom == .phone {

        } else {
            if viewController.title == viewControllerTitle.Houses.rawValue {
                let lastHouseSelected = houseListViewController.lastSelectedHouse()
                let houseDetailViewController = HouseDetailViewController(model: lastHouseSelected)
                splitViewController?.showDetailViewController(houseDetailViewController.wrappedInNavigation(), sender: nil)
            } else {
                let lastSeasonSelected = seasonListViewController.lastSelectedSeason()
                let seasonDetailViewControler = SeasonDetailViewController(model: lastSeasonSelected)

                splitViewController?.showDetailViewController(seasonDetailViewControler.wrappedInNavigation(), sender: nil)
            }
        }
    }
}
