//
//  BakingStore.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/8/22.
//

import Foundation
import SwiftUI

struct LocalStore: Identifiable, Codable {
    var id: UUID = UUID()
    var recipeList: [BreadRecipe] = BreadRecipe.sampleRecipeList
    var chosenRecipe: BreadRecipe = BreadRecipe.sampleRecipe
    
    var methodList: [BreadRecipeMethod] = [BreadRecipeMethod()]
    var chosenMethod: BreadRecipeMethod = BreadRecipeMethod()
    
}

class BakingStore: ObservableObject {
    @Published var storeData: LocalStore = LocalStore()
    
    var completedRecipe: CompletedRecipe {
        CompletedRecipe(title: storeData.chosenMethod.title, steps: storeData.chosenMethod.steps, recipe: storeData.chosenRecipe)
    }
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("forneau.data")
    }
    
    static func load() async throws -> LocalStore{
        try await withCheckedThrowingContinuation { continuation in
            load { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let store):
                    continuation.resume(returning: store)
                }
            }
        }
    }
    
    static func load(completion: @escaping (Result<LocalStore, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success(LocalStore()))
                    }
                    return
                }
                let local = try JSONDecoder().decode(LocalStore.self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(local))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    @discardableResult
    static func save(store: LocalStore) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            save(store: store) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let storeSaved):
                    continuation.resume(returning: storeSaved)
                }
            }
        }
    }
    
    static func save(store: LocalStore, completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(store)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(store.recipeList.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
}
