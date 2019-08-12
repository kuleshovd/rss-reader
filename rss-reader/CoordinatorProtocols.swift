//
//  Coordinator protocols.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 10/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import UIKit

protocol CoordinationDelegate: class {
    func finished()
}

protocol Coordinator: CoordinationDelegate {
    var rootViewController: UIViewController { get }
}
