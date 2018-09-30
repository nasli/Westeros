//
//  SeasonListViewController.swift
//  WikiGOT
//
//  Created by Noelia Alvarez on 29/09/2018.
//  Copyright © 2018 Noelia Alvarez. All rights reserved.
//

import UIKit

protocol SeasonListViewControllerDelegate: class {
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season)
}

class SeasonListViewController: UIViewController {

    // MARK: - Properties
    let model: [Season]
    var delegate: SeasonListViewControllerDelegate?

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Initialization
    init(model: [Season]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Seasons"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        tableView.dataSource = self
        tableView.delegate = self
    }
}


extension SeasonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let season = model[indexPath.row]

        let cellId = "SeasonCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }

        cell?.textLabel?.text = season.name
        cell?.detailTextLabel?.text = season.firstAiredDate.toString()

        return cell!
    }
}

extension SeasonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let theSeason = season(at: indexPath.row)

        delegate?.seasonListViewController(self, didSelectSeason: theSeason)

        // keep state
        saveLastSelectedSeason(at: indexPath.row)

        if let seasonDetailViewController = delegate as? SeasonDetailViewController {

            if UIDevice.current.userInterfaceIdiom == .phone {
                navigationController?.pushViewController(seasonDetailViewController, animated: true)
            } else {
                splitViewController?.showDetailViewController(seasonDetailViewController.wrappedInNavigation(), sender: nil)
            }
        }
    }

}


// MARK: - Persistence
extension SeasonListViewController {

    func saveLastSelectedSeason(at index: Int) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(index, forKey: Constants.lastSeasonKey)
    }

    func lastSelectedSeason() -> Season {
        let row = UserDefaults.standard.integer(forKey: Constants.lastSeasonKey)
        return season(at: row)
    }

    func season(at index: Int) -> Season {
        return model[index]
    }
}


