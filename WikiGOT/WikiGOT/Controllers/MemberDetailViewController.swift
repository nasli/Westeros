//
//  MemberDetailViewController.swift
//  WikiGOT
//
//  Created by Noelia Alvarez on 29/09/2018.
//  Copyright © 2018 Noelia Alvarez. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {

    // MARK: - Properties
    var model: Person

    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!

    // MARK: - Initialization
    init(model: Person) {
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
        nameLabel.text = model.name
        aliasLabel.text = model.alias

        title = model.name
        self.loadViewIfNeeded()
    }
}

extension MemberDetailViewController: MemberListViewControllerDelegate {
    func memberListViewController(_ vc: MemberListViewController, didSelectMember member: Person) {
        self.model = member
    }
}
