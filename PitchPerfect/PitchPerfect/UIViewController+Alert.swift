//
//  UIViewController+Alert.swift
//  PitchPerfect
//
//  Created by hourunjing on 2017/4/28.
//  Copyright © 2017年 hbzs. All rights reserved.
//

import UIKit

extension UIViewController {
  // MARK: Alerts

  struct Alerts {
    static let DismissAlert = "Dismiss"
  }

  func showAlert(_ title: String, message: String? = "") {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: Alerts.DismissAlert, style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
