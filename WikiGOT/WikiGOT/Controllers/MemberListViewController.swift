//
//  MemberListViewController.swift
//  WikiGOT
//
//  Created by Noelia Alvarez on 28/09/2018.
//  Copyright © 2018 Noelia Alvarez. All rights reserved.
//

import UIKit

protocol MemberListViewControllerDelegate: class {
    func memberListViewController(_ vc: MemberListViewController, didSelectMember member: Person)
}

class MemberListViewController: UIViewController {

    // MARK: - Properties
    var model: [Person]
    var delegate: MemberListViewControllerDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Initialization
    init(model: [Person]) {
        self.model = model

        super.init(nibName: nil, bundle: nil)

        title = "Members"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector:  #selector(houseDidChange), name: .houseDidChangeNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Notifications
    @objc func houseDidChange(notification: Notification) {
        // Get info
        guard let info = notification.userInfo,
            let house: House = info[Constants.houseKey] as? House else { return }

        self.model = house.sortedMembers

        syncModelWithView()
    }

    // MARK: - Sync
    func syncModelWithView() {

        self.tableView.reloadData()
    }
}

extension MemberListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let person = model[indexPath.row]

        let cellId = "PersonCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }

        cell?.textLabel?.text = person.name
        cell?.detailTextLabel?.text = person.alias

        return cell!
    }
}

extension MemberListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let theMember = member(at: indexPath.row)

        delegate?.memberListViewController(self, didSelectMember: theMember)

        // keep state
        saveLastSelectedMember(at: indexPath.row)

        let memberDetailViewController = MemberDetailViewController(model: theMember)
        navigationController?.pushViewController(memberDetailViewController, animated: true)
    }
}

// MARK: - Persistence
extension MemberListViewController {

    func saveLastSelectedMember(at index: Int) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(index, forKey: Constants.lastMemberKey)
    }

    func lastSelectedEpisode() -> Person {
        let row = UserDefaults.standard.integer(forKey: Constants.lastMemberKey)
        return member(at: row)
    }

    func member(at index: Int) -> Person {
        return model[index]
    }
}
