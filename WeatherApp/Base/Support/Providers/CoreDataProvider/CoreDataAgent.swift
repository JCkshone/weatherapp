//
//  CoreDataAgent.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation
import CoreData
import Combine

class CoreDataAgent<Entity: NSManagedObject> {
    lazy var container: NSPersistentContainer = {
         let container = NSPersistentContainer(name: "Weather")
         container.loadPersistentStores { (_, error) in
             if let error = error {
                 fatalError("Failed to load persistent stores: \(error)")
             }
         }
         return container
     }()

     var context: NSManagedObjectContext {
         return container.viewContext
     }
    
    func add(_ body: @escaping (inout Entity) -> Void) -> AnyPublisher<Entity, WeatherError.Api> {
        Deferred { [context] in
            Future  { promise in
                context.perform {
                    var entity = Entity(context: context)
                    body(&entity)
                    do {
                        try context.save()
                        promise(.success(entity))
                    } catch {
                        debugPrint("[ERROR - Core Data] Entity \(String(describing: Entity.self)) - \(error.localizedDescription)")
                        promise(.failure(.invalidResponse))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func object(_ id: NSManagedObjectID) -> AnyPublisher<Entity, WeatherError.Api> {
        Deferred { [context] in
            Future { promise in
                context.perform {
                    guard let entity = try? context.existingObject(with: id) as? Entity else {
                        promise(.failure(.invalidObject))
                        return
                    }
                    promise(.success(entity))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func delete(_ entity: Entity) -> AnyPublisher<Void, WeatherError.Api> {
        Deferred { [context] in
            Future { promise in
                context.perform {
                    do {
                        context.delete(entity)
                        try context.save()
                        promise(.success(()))
                    } catch {
                        debugPrint("[ERROR - Core Data] Entity \(String(describing: Entity.self)) - \(error.localizedDescription)")
                        promise(.failure(.invalidResponse))
                    }
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func fetch(sortDescriptors: [NSSortDescriptor] = [],
               predicate: NSPredicate? = nil) -> AnyPublisher<[Entity], WeatherError.Api> {
        Deferred { [context] in
            Future { promise in
                context.perform {
                    let request = Entity.fetchRequest()
                                        request.sortDescriptors = sortDescriptors
                    request.predicate = predicate
                    do {
                        let results = try context.fetch(request) as! [Entity]
                        promise(.success(results))
                    } catch {
                        debugPrint("[ERROR - Core Data] Entity \(String(describing: Entity.self)) - \(error.localizedDescription)")
                        promise(.failure(.invalidResponse))
                    }
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
