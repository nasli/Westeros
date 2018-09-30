//
//  UISplitViewController+ChildViews.swift
//  WikiGOT
//
//  Created by Noelia Alvarez on 30/09/2018.
//  Copyright © 2018 Noelia Alvarez. All rights reserved.
//

import UIKit

extension UISplitViewController {
    var masterViewController: UIViewController? {
        return self.viewControllers.first
    }

    var detailViewController: UIViewController? {
        return self.viewControllers.count > 1 ? self.viewControllers[1] : nil
    }
}
