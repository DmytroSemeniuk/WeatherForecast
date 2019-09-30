//
//  SectionDatasource.swift
//

import UIKit


open class DiffableDatasource: NSObject {
    
    public var updateWithoutReload: Bool = false {
        didSet {
            guard oldValue != updateWithoutReload else {
                return
            }
            for section in sections {
                section.updateWithoutReload = updateWithoutReload
            }            
        }
    }
    
    var sections: [SectionDatasource] = []

    var numberOfSections: Int {
        set {
        }
        get {
            return sections.count
        }
    }
    
    public init(with numberOfSections: Int = 1) {
        super.init()
        
        self.numberOfSections = numberOfSections
    }
    
    public subscript(index: Int) -> [DataSourceItem] {
        get {
            return sections[index].items
        }
        set(newValue) {
            sections[index].items = newValue
        }
    }
}
open class SectionDatasource: NSObject {
    open var supressAnimation = false

    public var updateWithoutReload: Bool = false

    public var internalItems = [DataSourceItem]()
    
    open var supportedCellTypes: [CellType] {
        get {
            return []
        }
    }
    
    var toRemove = Set<Int>()
    var toInsert = Set<Int>()
    var toUpdate = Set<Int>()
    
    open var isHaveChanges: Bool {
        get {
            return toRemove.count > 0 || toInsert.count > 0 || toUpdate.count > 0;
        }
    }

    open var items:[DataSourceItem] {
        get {
            return internalItems;
        }
        set {
            var countChanged = false
            
            toRemove.removeAll()
            toInsert.removeAll()
            toUpdate.removeAll()
            
            repeat {
                if ((internalItems.count == 0 && newValue.count == 0) || internalItems == newValue) {
                    break
                } else if (internalItems.count == 0 && newValue.count > 0) {
                    // insert all
                    for index in 0..<newValue.count {
                        toInsert.insert(index)
                    }
                    
                    countChanged = true
                    break
                } else if (internalItems.count > 0 && newValue.count == 0) {
                    // remove all
                    for index in 0..<internalItems.count {
                        toRemove.insert(index)
                    }
                    countChanged = true
                    break
                }
                
                var temp = [[Int]](repeating: [Int](repeating: 0, count: newValue.count + 1), count: internalItems.count + 1)
                for index in 0...newValue.count {
                    temp[0][index] = index
                }
                for index in 0...internalItems.count {
                    temp[index][0] = index
                }
                
                for i in 1...internalItems.count {
                    for j in 1...newValue.count {
                        if (internalItems[i - 1] == newValue[j - 1]) {
                            temp[i][j] = temp[i - 1][j - 1];
                        } else {
                            temp[i][j] = 1 + min(temp[i - 1][j - 1], temp[i - 1][j], temp[i][j - 1]);
                        }
                    }
                }
                
                var i = internalItems.count
                var j = newValue.count
                while true {
                    if (i == 0 && j == 0) {
                        break
                    }
                    
                    if (i > 0 && j > 0 && internalItems[i - 1] == newValue[j - 1]) {
                        i = i - 1;
                        j = j - 1;
                    } else if (i > 0 && j > 0 && temp[i][j] == temp[i - 1][j - 1] + 1){
                        //                print("replace \(fromArray[i - 1]) with \(toArray[j - 1])")
                        toUpdate.insert(i - 1);
                        i = i - 1;
                        j = j - 1;
                    } else if (i > 0 && temp[i][j] == temp[i - 1][j] + 1) {
                        //                print("delete \(fromArray[i - 1]) @ index \((i - 1))")
                        countChanged = true
                        
                        toRemove.insert(i - 1);
                        i = i - 1;
                    } else if (j > 0 && temp[i][j] == temp[i][j - 1] + 1){
                        //                print("Insert \(toArray[j - 1]) @ index \((j - 1))")
                        countChanged = true
                        
                        toInsert.insert(j - 1);
                        j = j - 1;
                    } else {
                        print("WTF?");
                        assert(false, "позовите Витю и покажите ситуацию")
                    }
                }
                
                
            } while false
            
            internalItems = newValue
            
            if let handler = onNumberOfItemsChanged, countChanged {
                handler()
            }
        }
    }

    public var onNumberOfItemsChanged: (() -> ())?

    public var onItemsUpdated: (() -> ())?

    
    func objectsEqual(obj1: AnyHashable, obj2: AnyHashable) -> Bool {
        return obj1 == obj2
    }
    
    // MARK: endless scrolling -
    func shiftDataPrev()  {
        var data = items
        if let firstObject = data.first {
            data.removeFirst()
            data.append(firstObject)
            
            UIView.performWithoutAnimation {
                items = data
            }
        }
    }
    
    func shiftDataNext() {
        var data = items
        if let lastObject = data.last {
            data.removeLast()
            data.insert(lastObject, at: 0)
            
            UIView.performWithoutAnimation {
                items = data
            }
        }
    }
    
    // MARK: cells registration -
    open func cellNibFor(_ cellType: CellType) -> String? {
        return nil
    }
    
    open func cellIdFor(_ cellType: CellType) -> String {
        return cellType
    }
    
    // MARK: - placeholder
    public weak var contentView: UIView?
    public var placeholderView: UIView? {
        didSet {
            guard let content = contentView, let placeholder = placeholderView else { return }
            
            placeholder.frame = content.bounds
            placeholder.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            placeholder.alpha = 0
            content.addSubview(placeholder)
        }
    }
    
    public var isEmptyState: Bool? {
        didSet {
            guard let newState = isEmptyState, oldValue != isEmptyState,
                let placeholderView = self.placeholderView,
                let _ = self.contentView else {
                return
            }
            if newState {
                placeholderView.alpha = 0
                UIView.animate(withDuration: 0.2) {
                    placeholderView.alpha = 1
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    placeholderView.alpha = 0
                }
            }            
        }
    }
}
