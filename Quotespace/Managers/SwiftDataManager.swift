//
//  SwiftDataManager.swift
//  Quotespace
//
//  Created by Jonathan Ricky Sandjaja on 17/04/25.
//

import SwiftData
import SwiftUI

class SwiftDataManager {
    
    static let shared = SwiftDataManager()
    
    func addToLocal(context: ModelContext, data: any PersistentModel) {
        do {
            context.insert(data)
            try context.save()
        } catch {
            print("❌ Failed to save data in SwiftData: \(error)")
        }
    }
    
    func updateItem(context: ModelContext, action: (() -> Void)?) {
        action?()
        
        do {
            try context.save()
        } catch {
            print("❌ Failed to update data: \(error)")
        }
    }
    
    func deleteItem(context: ModelContext, data: any PersistentModel) {
        withAnimation {
            context.delete(data)
        }
        
        do {
            try context.save()
        } catch {
            print("❌ Failed to delete data: \(error)")
        }
    }
    
}
