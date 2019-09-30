//
//  CollectionSectionDatasource.swift
//

import UIKit

open class CollectionDatasource : DiffableDatasource, UICollectionViewDataSource {
    
    override var numberOfSections: Int {
        set {
            if newValue != sections.count {
                sections.removeAll()
                collectionView?.reloadData()
                
                for x in 0..<newValue {
                    let newSection = CollectionSectionDatasource()
                    newSection.section = x
                    newSection.updateWithoutReload = self.updateWithoutReload
                    sections.append(newSection)
                }
                collectionView?.reloadData()
            }
        }
        get {
            return super.numberOfSections
        }
    }
    
    public weak var collectionView: UICollectionView? {
        didSet {
            if let collection = collectionView {
                collection.dataSource = self
                for ds in sections {
                    guard let ds = ds as? CollectionSectionDatasource else { fatalError() }
                    ds.collectionView = collection
                }
            }
        }
    }
    
    // MARK: - collection datasource
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard sections.count > section else {
            return 0
        }
        guard let sectionDatasource = sections[section] as? CollectionSectionDatasource else {
            fatalError()
        }
        return sectionDatasource.collectionView(collectionView, numberOfItemsInSection: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard sections.count > indexPath.section else {
            return UICollectionViewCell() // ну а шо тут сделать
        }
        guard let sectionDatasource = sections[indexPath.section] as? CollectionSectionDatasource else {
            fatalError()
        }
        return sectionDatasource.collectionView(collectionView, cellForItemAt: indexPath)
    }
}

open class CollectionSectionDatasource : SectionDatasource, UICollectionViewDataSource {
    var section: Int = 0
    
    public weak var collectionView: UICollectionView? {
        didSet {
            if let collection = collectionView {
                if collection.dataSource == nil {
                    collection.dataSource = self
                }
                
                for cellType in supportedCellTypes {
                    let cellId = self.cellIdFor(cellType)
                    if let cellNib = self.cellNibFor(cellType) {
                        collection.register(UINib(nibName: cellNib, bundle: nil), forCellWithReuseIdentifier: cellId)
                    }
                }
//                collection.layoutIfNeeded()
            }
            self.contentView = collectionView
        }
    }
    
    public override var isEmptyState: Bool? {
        didSet {
            if let state = isEmptyState, let collection = collectionView, let _ = placeholderView {
                collection.isScrollEnabled = !state
            }
        }
    }
    
    // MARK: overrides -
    override open var items:[DataSourceItem] {
        willSet {
            if let collection = collectionView {
                collection.layoutIfNeeded()
            }
        }
        didSet {
            if let collection = collectionView {
                let updateAction = {
                    collection.performBatchUpdates({
                        
                        if self.internalItems.count > 0 {
                            self.isEmptyState = false
                        }

                        if (!self.toRemove.isEmpty) {
                            let sorted = self.toRemove.sorted(by: > ).map( { IndexPath(item: $0, section: self.section) } )
                            collection.deleteItems(at: sorted)
                        }
                        if (!self.toInsert.isEmpty) {
                            let sorted = self.toInsert.sorted(by: < ).map( { IndexPath(item: $0, section: self.section) } )
                            collection.insertItems(at: sorted)
                        }
                        if (!self.toUpdate.isEmpty) {
                            let array = self.toUpdate.map( { IndexPath(item: $0, section: self.section) } )
                                collection.reloadItems(at: array)
                        }
                    }, completion: { (_) in
                        self.isEmptyState = self.internalItems.count == 0
                        if let block = self.onItemsUpdated {
                            block()
                        }
                    })
                }
                
                if collection.numberOfItems(inSection: self.section) == 0 && !toInsert.isEmpty {
                    collection.reloadData()
                    self.isEmptyState = self.internalItems.count == 0
                    if let block = self.onItemsUpdated {
                        block()
                    }
                } else {
                    if supressAnimation {
                        UIView.performWithoutAnimation {
                            updateAction()
                        }
                    } else {
                        updateAction()
                    }
                }
            }
        }
    }
    
    // MARK: collection support -
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    open var cellHandler: ((_ collection: UICollectionView, _ index: IndexPath, _ data: DataSourceItem) -> UICollectionViewCell?)?
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = items[indexPath.item]
        
        if let block = cellHandler, let cell = block(collectionView, indexPath, data) {
            return cell
        }
        
        let cellId = cellIdFor(data.itemType)
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? DataAwareCell {
            cell.fillWithData(data)            
            return cell as! UICollectionViewCell
        }
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }
    
}
