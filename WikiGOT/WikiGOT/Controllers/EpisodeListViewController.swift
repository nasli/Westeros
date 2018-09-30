//
//  EpisodeListViewController.swift
//  WikiGOT
//
//  Created by Noelia Alvarez on 29/09/2018.
//  Copyright © 2018 Noelia Alvarez. All rights reserved.
//

import UIKit

protocol EpisodeListViewControllerDelegate: class {
    func episodeListViewController(_ vc: EpisodeListViewController, didSelectEpisode episode: Episode)
}

class EpisodeListViewController: UIViewController {

    // MARK: - Properties
    var model: [Episode]
    var delegate: EpisodeListViewControllerDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Initialization
    init(model: [Episode]) {
        self.model = model

        super.init(nibName: nil, bundle: nil)
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

        title = "Episodes"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector:  #selector(seasonDidChange), name: .seasonDidChangeNotification, object: nil)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Notifications
    @objc func seasonDidChange(notification: Notification) {
        // Get episodes of season
        guard let info = notification.userInfo,
            let season: Season = info[Constants.seasonKey] as? Season else { return }

        model = season.sortedEpisodes

        syncModelWithView()
    }

    // MARK: - Sync
    func syncModelWithView() {
        self.tableView.reloadData()
    }
    
}

extension EpisodeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let episode = model[indexPath.row]

        let cellId = "EpisodeCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }

        cell?.textLabel?.text = "Episode \(indexPath.row): \(episode.name)"
        cell?.detailTextLabel?.text = episode.airDate.toString()

        return cell!
    }
}

extension EpisodeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let theEpisode = episode(at: indexPath.row)

        delegate?.episodeListViewController(self, didSelectEpisode: theEpisode)

        // keep state
        saveLastSelectedEpisode(at: indexPath.row)

        let episodeDetailViewController = EpisodeDetailViewController(model: theEpisode)
        navigationController?.pushViewController(episodeDetailViewController, animated: true)
    }
}

// MARK: - Persistence
extension EpisodeListViewController {

    func saveLastSelectedEpisode(at index: Int) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(index, forKey: Constants.lastEpisodeKey)
    }

    func lastSelectedEpisode() -> Episode {
        let row = UserDefaults.standard.integer(forKey: Constants.lastEpisodeKey)

        return episode(at: row)
    }

    func episode(at index: Int) -> Episode {
        return model[index]
    }
}
