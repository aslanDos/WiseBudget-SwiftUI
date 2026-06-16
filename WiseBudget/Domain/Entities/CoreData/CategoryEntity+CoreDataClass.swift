//
//  CategoryEntity+CoreDataClass.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 16.06.2026.
//
//

public import Foundation
public import CoreData

public typealias CategoryEntityCoreDataClassSet = NSSet

@objc(CategoryEntity)
public class CategoryEntity: NSManagedObject {

}

public typealias CategoryEntityCoreDataPropertiesSet = NSSet

extension CategoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryEntity> {
        return NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
    }

    @NSManaged public var iconColorName: String
    @NSManaged public var iconName: String
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var type: String
    @NSManaged public var order: Int16

}

extension CategoryEntity : Identifiable {

}
