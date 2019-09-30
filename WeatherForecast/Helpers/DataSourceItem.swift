//
//  DataSourceItem.swift
//

import UIKit

public typealias CellType = String

@objc public protocol DataAwareCell {
    func fillWithData(_ data: DataSourceItem)
}

@objc open class DataSourceItem: NSObject {

    let itemType: CellType
    open var payload: AnyHashable?
    
    /// read only reuse identifier for cell
    open var cellId: String {
        return self.itemType
    }
    
    @objc required public init(_ itemType: CellType, payload: AnyHashable? = nil) {
        self.itemType = itemType
        self.payload = payload
    }

    public convenience init(_ itemType: CellType, from payload: DataSourceItem) {
        self.init(itemType)
        self.payload = payload.payload
    }
    
//    deinit {
//        print("  # DataSourceItem deinit #")
//    }
    
    // MARK: protocols -

    open func isPayloadEqual(object: Any?) -> Bool? {
        return nil
    }
    
    open func isEqual(to object: Any?) -> Bool {
        if let obj = object as? DataSourceItem {
            if self.itemType != obj.itemType {
                return false
            }
            if let result = self.isPayloadEqual(object: object) {
                return result
            }
            return self.payload == obj.payload
        } else {
            return false
        }
    }
    
    public static func == (lhs: DataSourceItem, rhs: DataSourceItem) -> Bool {
        return lhs.isEqual(to: rhs)
    }
    
    open override var hash: Int {
        if let value = payload {
            return itemType.hashValue ^ value.hashValue
        } else {
            return itemType.hashValue
        }
    }
    
}
