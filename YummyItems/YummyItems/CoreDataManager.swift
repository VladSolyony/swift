//
//  CoreDataManager.swift
//  YummyItems
//
//
//  Created by macOS Catalina on 19.12.2022.
//

import UIKit
import CoreData

struct CoreDataManager {
    
    static var viewContext: NSManagedObjectContext = {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        return appdelegate.persistentContainer.viewContext
    }()
    
    static func saveOrderDetails(for customer: String, details: [Item], totalPrice: String, customerImage: UIImage?) {
        
        let sameCategoryItems = Dictionary(grouping: details) { $0.id }
        let order = Order(context: viewContext)
        order.totalPrice = totalPrice
        order.customer = customer
        order.date = Date()
        order.customerImage = customerImage
        let orderDetails = NSMutableSet()
        for menu in sameCategoryItems {
            let orderItem = OrderItem(context: viewContext)
            orderItem.categoryId = menu.value.first?.category.rawValue
            orderItem.id = menu.key
            orderItem.count = "\(menu.value.count)"
            orderItem.price = menu.value.first?.cost
            orderItem.name = menu.value.first?.name
            orderDetails.add(orderItem)
        }
        order.orderDetails = orderDetails
        try? viewContext.save()
    }
    
    static func fetchOrderDetails() -> [Order]{
        
        let fetchRequest: NSFetchRequest = Order.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let result = try? viewContext.fetch(fetchRequest)
        return result ?? []
    }
}
