//
//  SeasonDetailViewController.swift
//  WikiGOT
//
//  Created by Noelia Alvarez on 29/09/2018.
//  Copyright © 2018 Noelia Alvarez. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {

    // MARK: - Properties
    var model: Season

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var episodesListButton: UIButton!

    // MARK: - Initialization
    init(model: Season) {
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

        title = "Season"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector:  #selector(seasonDidChange), name: .seasonDidChangeNotification, object: nil)
        
        syncModelWithView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Notifications
    @objc func seasonDidChange(notification: Notification) {
        // Get season
        guard let info = notification.userInfo,
            let season: Season = info[Constants.seasonKey] as? Season else { return }

        model = season

        syncModelWithView()
    }

    // MARK: - Sync
    func syncModelWithView() {
        titleLabel.text = model.name
        dateLabel.text = model.firstAiredDate.toString()
        episodesListButton.setTitle("Episodes List", for: .normal)
        episodesListButton.addTarget(self, action:#selector(displayEpisodes(_sender:)), for: .touchUpInside)
        
        self.loadViewIfNeeded()
    }

    @objc public func displayEpisodes(_sender: UIButton) {
        let episodeListViewController = EpisodeListViewController(model: model.sortedEpisodes)
        navigationController?.pushViewController(episodeListViewController, animated: true)
    }
}

extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season) {
        self.model = season
    }
}
