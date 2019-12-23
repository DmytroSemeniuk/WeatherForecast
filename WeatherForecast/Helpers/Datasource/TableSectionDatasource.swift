//
//  TableSectionDatasource.swift
//

import UIKit

open class TableDatasource : DiffableDatasource, UITableViewDataSource {
    
    override var numberOfSections: Int {
        set {
            if newValue != sections.count {
                sections.removeAll()
                tableView?.reloadData()
                
                for x in 0..<newValue {
                    let newSection = TableSectionDatasource()
                    newSection.section = x
                    newSection.updateWithoutReload = self.updateWithoutReload
                    sections.append(newSection)
                }
                tableView?.reloadData()
            }
        }
        get {
            return super.numberOfSections
        }
    }
    
    public weak var tableView: UITableView? {
        didSet {
            if let table = tableView {
                table.dataSource = self
                for ds in sections {
                    guard let ds = ds as? TableSectionDatasource else { fatalError() }
                    ds.tableView = table
                }
            }
        }
    }
    
    // MARK: - collection datasource
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard sections.count > section else {
            return 0
        }
        guard let sectionDatasource = sections[section] as? TableSectionDatasource else {
            fatalError()
        }
        return sectionDatasource.tableView(tableView, numberOfRowsInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard sections.count > indexPath.section else {
            fatalError()
        }
        guard let sectionDatasource = sections[indexPath.section] as? TableSectionDatasource else {
            fatalError()
        }
        return sectionDatasource.tableView(tableView, cellForRowAt: indexPath)
    }
}

open class TableSectionDatasource : SectionDatasource, UITableViewDataSource {
    var section: Int = 0
    
    open var defaultInsertAnimation: UITableView.RowAnimation = .fade
    open var defaultRemoveAnimation: UITableView.RowAnimation = .fade
    open var defaultUpdateAnimation: UITableView.RowAnimation = .fade
    
    @objc public weak var tableView: UITableView? {
        didSet {
            if let table = tableView {
                table.dataSource = self
                
                for cellType in supportedCellTypes {
                    let cellId = self.cellIdFor(cellType)
                    if let cellNib = self.cellNibFor(cellType) {
                        table.register(UINib(nibName: cellNib, bundle: nil), forCellReuseIdentifier: cellId)
                    }
                }
            }
            self.contentView = tableView
        }
    }
    
//    deinit {
//        print("  # TableSectionDatasource \(#function) #")
//    }
    
    public override var isEmptyState: Bool? {
        didSet {
            if let state = isEmptyState, let table = tableView, let _ = placeholderView {
                table.isScrollEnabled = !state
            }
        }
    }
    
    @objc override open var items: [DataSourceItem] {
        willSet {
            if let table = tableView {
                table.layoutIfNeeded()
            }
        }
        didSet {            
            if let table = tableView, (!toRemove.isEmpty || !toInsert.isEmpty || !toUpdate.isEmpty) {                
                if table.numberOfRows(inSection: self.section) == 0 && !toInsert.isEmpty {
                    table.reloadData()
                } else {
                    if #available(iOS 11.0, *) {
                        table.performBatchUpdates({
                            if (!toRemove.isEmpty) {
                                let array = self.toRemove.sorted(by: > ).map( { IndexPath(item: $0, section: self.section) } )
                                table.deleteRows(at: array, with: defaultRemoveAnimation)
                            }
                            if (!toInsert.isEmpty) {
                                let array = self.toInsert.sorted(by: < ).map( { IndexPath(item: $0, section: self.section) } )
                                table.insertRows(at: array, with: defaultInsertAnimation)
                            }
                            if !toUpdate.isEmpty {
                                let array = self.toUpdate.map( { IndexPath(item: $0, section: self.section) } )
                                table.reloadRows(at: array, with: defaultUpdateAnimation)
                            }
                        }) { (_) in
                            if let block = self.onItemsUpdated {
                                block()
                            }
                        }
                    } else {
                        table.beginUpdates()
                        if (!toRemove.isEmpty) {
                            let array = self.toRemove.sorted(by: > ).map( { IndexPath(item: $0, section: self.section) } )
                            table.deleteRows(at: array, with: defaultRemoveAnimation)
                        }
                        if (!toInsert.isEmpty) {
                            let array = self.toInsert.sorted(by: < ).map( { IndexPath(item: $0, section: self.section) } )
                            table.insertRows(at: array, with: defaultInsertAnimation)
                        }
                        if !toUpdate.isEmpty {
                            let array = self.toUpdate.map( { IndexPath(item: $0, section: self.section) } )
                            table.reloadRows(at: array, with: defaultUpdateAnimation)
                        }
                        table.endUpdates()
                    }
                }
            }
            isEmptyState = internalItems.count == 0
        }
    }
    
    // MARK: tableview support -
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    open var cellHandler: ((_ table: UITableView, _ index: IndexPath, _ data: DataSourceItem) -> UITableViewCell?)?
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = items[indexPath.item]
        
        // не тестировалось реальным примером пока!
        if let block = cellHandler, let cell = block(tableView, indexPath, data) {
            return cell
        }
        
        let cellId = cellIdFor(data.itemType)
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? DataAwareCell {
            cell.fillWithData(data)
            return cell as! UITableViewCell
        }
                
        return tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    }
}

//extension UITableView {
//    
//    open func updateItems(at indexPaths: [IndexPath], dataSource: SectionDatasource) {
//        
//        for index in indexPaths {
//            let data = dataSource.items[index.item]
//            if let cell = self.cellForRow(at: index) as? DataAwareCell {
//                cell.fillWithData(data)
//            }
//        }
//    }
//    
//}
