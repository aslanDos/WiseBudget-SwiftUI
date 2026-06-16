//
//  AccountEntity+CoreDataClass.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 18.06.2026.
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

}

extension AccountEntity : Identifiable {

}
