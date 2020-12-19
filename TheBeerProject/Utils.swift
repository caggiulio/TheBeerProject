//
//  Utils.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 20/08/2019.
//  Copyright © 2019 Nunzio Giulio Caggegi. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

public extension UISearchBar {
    func setTextColorAndTextFont(color: UIColor, font: UIFont?) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
        if font != nil {
            tf.font = font
        }
    }
}

extension Array where Element: Equatable {
      mutating func removeEqualItems(_ item: Element) {
            self = self.filter { (currentItem: Element) -> Bool in
              return currentItem != item
            }
      }
}
