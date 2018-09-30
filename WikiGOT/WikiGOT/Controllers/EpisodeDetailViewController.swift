//
//  EpisodeDetailViewController.swift
//  WikiGOT
//
//  Created by Noelia Alvarez on 29/09/2018.
//  Copyright © 2018 Noelia Alvarez. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    // MARK: - Properties
    var model: Episode

    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var airDateLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!

    // MARK: - Initialization
    init(model: Episode) {
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

        title = "Episode"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        syncModelWithView()
    }

    // MARK: - Sync
    func syncModelWithView() {
        nameLabel.text = model.name
        airDateLabel.text = model.airDate.toString()
        seasonLabel.text = model.season?.name

        self.loadViewIfNeeded()
    }
}

extension EpisodeDetailViewController: EpisodeListViewControllerDelegate {
    func episodeListViewController(_ vc: EpisodeListViewController, didSelectEpisode episode: Episode) {
        self.model = episode
    }
}
