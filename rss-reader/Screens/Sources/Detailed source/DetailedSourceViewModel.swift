//
//  DetailedSourceViewModel.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 10/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import Foundation

protocol DetailedSourceViewModel {
    func getName() -> String?
    func getURLString() -> String?
    func validate(name: String?, URLString: String?, completion: @escaping (String?) ->())
    func finish()
}


