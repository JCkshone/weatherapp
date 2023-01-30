//
//  CoreDataAgent.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation
import CoreData
import Combine

public protocol CoreDataAgent: AnyObject {
    func save(_ object: NSManagedObject)
    func remove(_ object: NSManagedObject)
}


enum WeatherError {
    enum CoreData: Error {
        case objectNotFound
    }
}

class CoreDataRepository<Entity: NSManagedObject> {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func add(_ body: @escaping (inout Entity) -> Void) -> AnyPublisher<Entity, Error> {
        Deferred { [context] in
            Future  { promise in
                context.perform {
                    var entity = Entity(context: context)
                    body(&entity)
                    do {
                        try context.save()
                        promise(.success(entity))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func object(_ id: NSManagedObjectID) -> AnyPublisher<Entity, Error> {
        Deferred { [context] in
            Future { promise in
                context.perform {
                    guard let entity = try? context.existingObject(with: id) as? Entity else {
                        promise(.failure(WeatherError.CoreData.objectNotFound))
                        return
                    }
                    promise(.success(entity))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func delete(_ entity: Entity) -> AnyPublisher<Void, Error> {
        Deferred { [context] in
            Future { promise in
                context.perform {
                    do {
                        context.delete(entity)
                        try context.save()
                        promise(.success(()))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
