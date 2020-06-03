//
//  NCOperationQueue.swift
//  Nextcloud
//
//  Created by Marino Faggiana on 03/06/2020.
//  Copyright © 2020 Marino Faggiana. All rights reserved.
//
//  Author Marino Faggiana <marino.faggiana@nextcloud.com>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//


import Foundation
import Queuer

@objc class NCOperationQueue: ConcurrentOperation {
    @objc public static let shared: NCOperationQueue = {
        let instance = NCOperationQueue()
        return instance
    }()
    
    let transferQueue = Queuer(name: "transferQueue", maxConcurrentOperationCount: 5, qualityOfService: .default)

    @objc func download(metadata: tableMetadata, selector: String, setFavorite: Bool = false) {
        let concurrentOperation = ConcurrentOperation { operation in
            
            NCNetworking.shared.download(metadata: metadata, selector: selector, setFavorite: setFavorite) { (errorCode) in
            }
        }
        concurrentOperation.addToQueue(transferQueue)
    }
}