//
//  RepoContainer.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 28/01/21.
//  Copyright © 2021 Nunzio Giulio Caggegi. All rights reserved.
//

import Foundation

class RepoContainer {
    static var repoContainer: [NSObject] = [NSObject]() {
        didSet {
            for repo in repoContainer {
                print(repo)
            }
        }
    }
    
    static func addContainer(repo: NSObject) {
        self.repoContainer.append(repo)
    }
}
