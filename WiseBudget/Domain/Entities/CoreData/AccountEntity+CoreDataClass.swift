//
//  AccountEntity+CoreDataClass.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 31.05.2026.
//
//

public import Foundation
public import CoreData

public typealias AccountEntityCoreDataClassSet = NSSet

@objc(AccountEntity)
public class AccountEntity: NSManagedObject {

}

public typealias AccountEntityCoreDataPropertiesSet = NSSet

extension AccountEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccountEntity> {
        return NSFetchRequest<AccountEntity>(entityName: "AccountEntity")
    }

    @NSManaged public var balance: Double
    @NSManaged public var createdAt: Date
    @NSManaged public var currencyCode: String
    @NSManaged public var iconColorName: String
    @NSManaged public var iconName: String
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var updatedAt: Date
    @NSManaged public var transactions: NSSet?

}

// MARK: Generated accessors for transactions
extension AccountEntity {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: TransactionEntity)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: TransactionEntity)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}

extension AccountEntity : Identifiable {

}
