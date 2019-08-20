//
//  UserDefaultsStorageManager.swift
//  rss-reader
//
//  Created by Daniil Kuleshov on 10/08/2019.
//  Copyright © 2019 kuleshov. All rights reserved.
//

import Foundation

/*

 I know that this class is so bad, but I didn't want to use Realm or CoreData for such a simple 'database',
 but UserDefaults is so bad when it comes to work with custom objects.
 
 So I implement StoreManager database type methods with UserDefaults. :(

 
 */

class UserDefaultsStorageManager: StorageManager {
    
    let sourcesKey = "sources"

    let userDefaults = UserDefaults.standard
    
    func remove(source: Source) {
        var sources = retrieveSourceEntities()
        if let index = sources.firstIndex(where: { $0.identifier == source.identifier }) {
            sources.remove(at: index)
            storeSourceEntities(sourceEntities: sources)
        }
    }
    
    func getSources() -> [Source] {
        return retrieveSourceEntities().map { Source(entity: $0) }
    }
    
    func update(source: Source) {
        var sources = retrieveSourceEntities()
        if let index = sources.firstIndex(where: { $0.identifier == source.identifier }) {
            sources[index] = SourceEntity(source: source)
            storeSourceEntities(sourceEntities: sources)
        }
    }
    
    func add(source: Source) {
        var sources = retrieveSourceEntities()
        sources.append(SourceEntity(source: source))
        storeSourceEntities(sourceEntities: sources)
        
    }

    private func retrieveSourceEntities() -> [SourceEntity] {
        var sourceEntities = [SourceEntity]()
        if let sourcesData = userDefaults.array(forKey: sourcesKey) as! [Data]?  {
            let decoder = JSONDecoder()
            
            for sourceData in sourcesData {
                if let sourceEntity = try? decoder.decode(SourceEntity.self, from: sourceData) {
                    sourceEntities.append(sourceEntity)
                }
            }
        }
        return sourceEntities
    }
    
    private func storeSourceEntities(sourceEntities: [SourceEntity]) {
        let encoder = JSONEncoder()
        var sourcesData = [Data]()
        for sourceEntity in sourceEntities {
            if let sourceData = try? encoder.encode(sourceEntity) {
                sourcesData.append(sourceData)
            }
        }
        userDefaults.set(sourcesData, forKey: sourcesKey)
        userDefaults.synchronize()
    }
    
    
}
