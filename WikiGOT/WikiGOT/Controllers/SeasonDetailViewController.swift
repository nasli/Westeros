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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        syncModelWithView()
    }

    // MARK: - Sync
    func syncModelWithView() {
        titleLabel.text = model.name
        dateLabel.text = model.firstAiredDate.toString()
        episodesListButton.setTitle("Episodes List", for: .normal)
        episodesListButton.addTarget(self, action:#selector(displayEpisodes(_sender:)), for: .touchUpInside)
        
        title = model.name
        
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
