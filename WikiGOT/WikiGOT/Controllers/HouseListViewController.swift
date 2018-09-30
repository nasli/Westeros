//
//  HouseListViewController.swift
//  WikiGOT
//
//  Created by Noelia Alvarez on 28/09/2018.
//  Copyright © 2018 Noelia Alvarez. All rights reserved.
//

import UIKit

protocol HouseListViewControllerDelegate {
    func houseListViewController(_ vc: HouseListViewController, didSelectHouse house: House)
}

class HouseListViewController: UITableViewController {

    // MARK: - Properties
    let model: [House]
    var delegate: HouseListViewControllerDelegate?

    // MARK: - Initialization
    init(model: [House]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Houses"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCustomCell()

        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func registerCustomCell() {
        let nib = UINib(nibName: "HouseCell", bundle: nil) // TODO: constant cell
        tableView.register(nib, forCellReuseIdentifier: HouseCell.reuseIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let house = model[indexPath.row]

        // Configure the cell...
        let cellId = HouseCell.reuseIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! HouseCell

        cell.sigilImageView.image = house.sigil.image
        cell.nameLabel.text = house.name
        cell.wordsLabel.text = house.words

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let theHouse = house(at: indexPath.row)

        // keep state
        saveLastSelectedHouse(at: indexPath.row)

        delegate?.houseListViewController(self, didSelectHouse: theHouse)

        // Notify
        let nc = NotificationCenter.default
        let notification = Notification(name: .houseDidChangeNotification, object: self, userInfo: [Constants.houseKey : theHouse])
        nc.post(notification)

        if let houseDetailViewController = delegate as? HouseDetailViewController {

            if UIDevice.current.userInterfaceIdiom == .phone {
                navigationController?.pushViewController(houseDetailViewController, animated: true)
            }
        }
    }
}

// MARK: - Persistence 
extension HouseListViewController {
    func saveLastSelectedHouse(at index: Int) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(index, forKey: Constants.lastHouseKey)
    }

    func lastSelectedHouse() -> House {
        let row = UserDefaults.standard.integer(forKey: Constants.lastHouseKey)
        return house(at: row)
    }

    func house(at index: Int) -> House {
        return model[index]
    }
}
