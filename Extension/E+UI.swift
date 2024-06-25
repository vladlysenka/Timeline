// Created by Vlad Lysenka 25.06.2024 

import SwiftUI
import UIKit

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.isHidden = true
    }
}
