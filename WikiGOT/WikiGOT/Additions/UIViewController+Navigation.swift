//
//  UIViewController+Navigation.swift
//  WikiGOT
//
//  Created by Noelia Alvarez on 28/09/2018.
//  Copyright © 2018 Noelia Alvarez. All rights reserved.
//

import UIKit

extension UIViewController {
    func wrappedInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
