//
//  CreateAccountManager.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 31.05.2026.
//

import Foundation
import CoreData

class AccountManager: AccountDataSource {
    
    private let context = PersistentContainer.shared.persistentContainer.viewContext
    
    func createNewAccount(account: Account) throws {
        let _ = AccountMapper.toEntity(from: account, context: context)
        try context.save()
    }
    
    func updateAccount(account: Account) throws {
        let req: NSFetchRequest<AccountEntity> = AccountEntity.fetchRequest()
        
        req.predicate = NSPredicate(format: "id == %@", argumentArray: [account.id])
        
        guard let entity = try context.fetch(req).first else { return }
        
        entity.name = account.name
        entity.balance = account.balance
        entity.currencyCode = account.currencyCode
        entity.iconName = account.iconName
        entity.iconColorName = account.iconColorName
        entity.updatedAt = account.updatedAt
        
        try context.save()
    }
    
    func fetchAccounts(completion: (Result<[Account], any Error>) -> Void) throws {
        let req = AccountEntity.fetchRequest()
        let accounts = try context.fetch(req)
        
        let domainAccounts = accounts.map { item in
            AccountMapper.toDomain(from: item)
        }
        
        completion(.success(domainAccounts))
    }
    
    func deleteAccount(id: UUID) throws {
        let req: NSFetchRequest<AccountEntity> = AccountEntity.fetchRequest()
        req.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        let entities = try context.fetch(req)

        entities.forEach(context.delete)

        try context.save()
    }
}
