//
//  HouseDetailViewController.swift
//  WikiGOT
//
//  Created by Noelia Alvarez on 28/09/2018.
//  Copyright © 2018 Noelia Alvarez. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {

    // MARK: - Properties
    var model: House

    // MARK: - Outlets
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var wordsLabel: UILabel!

    // MARK: - Initialization
    init(model: House) {
        self.model = model 
        super.init(nibName:nil, bundle: nil)

        title = model.name
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector:  #selector(houseDidChange), name: .houseDidChangeNotification, object: nil)
        
        syncModelWithView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Notifications
    @objc func houseDidChange(notification: Notification) {
        // Get house from info
        guard let info = notification.userInfo,
            let house: House = info[Constants.houseKey] as? House else { return }

        self.model = house

        syncModelWithView()
    }

    // MARK: - SetupUI
    func setupUI() {
        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
        let membersButton = UIBarButtonItem(title: "Members", style: .plain, target: self, action: #selector(displayMembers))
        navigationItem.rightBarButtonItems = [membersButton, wikiButton]
    }

    @objc func displayWiki() {
        let wikiViewController = WikiViewController(model: model)
        navigationController?.pushViewController(wikiViewController, animated: true)
    }

    @objc func displayMembers() {
        let memberListViewController = MemberListViewController(model: model.sortedMembers)
        navigationController?.pushViewController(memberListViewController, animated: true)
    }

    // MARK: - Sync
    func syncModelWithView() {
        houseNameLabel.text = "House \(model.name)"
        sigilImageView.image = model.sigil.image
        wordsLabel.text = model.words
        title = model.name
        self.loadViewIfNeeded()
    }
}

extension HouseDetailViewController: HouseListViewControllerDelegate {
    func houseListViewController(_ vc: HouseListViewController, didSelectHouse house: House) {
        self.model = house
    }
}
