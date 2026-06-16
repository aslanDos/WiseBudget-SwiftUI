//
//  TransactionManager.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 10.06.2026.
//

import Foundation
import CoreData

class TransactionManager: TransactionDataSource {
    
    private let context = PersistentContainer.shared.persistentContainer.viewContext
    
    func createNewTransaction(transaction: Transaction) throws {
        let _ = TransactionMapper.toEntity(from: transaction, context: context)
        try context.save()
    }
    
    func updateTransaction(transaction: Transaction) throws {
        let req: NSFetchRequest<TransactionEntity> = TransactionEntity.fetchRequest()
        req.predicate = NSPredicate(format: "id == %@", argumentArray: [transaction.id])
        
        guard let entity = try context.fetch(req).first else { return }
        
        entity.note = transaction.note
        entity.date = transaction.date
        entity.categoryId = transaction.categoryId
        entity.accountId = transaction.accountId
        entity.amount = transaction.amount
        entity.updatedAt = transaction.updatedAt
        
        try context.save()
    }
    
    func fetchTransactions(accountId: UUID?, startDate: Date, endDate: Date, completion: (Result<[Transaction], any Error>) -> Void) throws {
        let req = TransactionEntity.fetchRequest()
        
        var predicates: [NSPredicate] = []
        
        // Filter by account
        if let accountId {
            predicates.append(
                NSPredicate(
                    format: "accountId == %@",
                    accountId as CVarArg
                )
            )
        }
        
        // Filter by date range
        
        predicates.append(
            NSPredicate(
                format: "date >= %@ AND date < %@",
                startDate as NSDate,
                endDate as NSDate
            )
        )
        
        req.predicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: predicates
        )
        
        req.sortDescriptors = [
            NSSortDescriptor(
                key: "date",
                ascending: false
            )
        ]
        
        do {
            let transactions = try context.fetch(req)
            
            let domainTransactions = transactions.map {
                TransactionMapper.toDomain(from: $0)
            }
            
            completion(.success(domainTransactions))
        } catch {
            completion(.failure(error))
        }
        
    }
    
    func deleteTransaction(id: UUID) throws {
        let req: NSFetchRequest<TransactionEntity> = TransactionEntity.fetchRequest()
        req.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        let entities = try context.fetch(req)

        entities.forEach(context.delete)

        try context.save()
    }
}
