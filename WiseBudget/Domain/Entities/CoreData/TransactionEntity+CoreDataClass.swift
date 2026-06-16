//
//  TransactionEntity+CoreDataClass.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 10.06.2026.
//
//

public import Foundation
public import CoreData

public typealias TransactionEntityCoreDataClassSet = NSSet

@objc(TransactionEntity)
public class TransactionEntity: NSManagedObject {

}

public typealias TransactionEntityCoreDataPropertiesSet = NSSet

extension TransactionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionEntity> {
        return NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
    }

    @NSManaged public var amount: Double
    @NSManaged public var categoryId: UUID?
    @NSManaged public var createdAt: Date?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var note: String?
    @NSManaged public var type: String?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var account: AccountEntity?

}

extension TransactionEntity : Identifiable {

}
