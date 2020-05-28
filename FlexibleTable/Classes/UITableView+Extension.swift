//
//  UITableView+Extension.swift
//  FBSnapshotTestCase
//
//  Created by Yusuf Demirci on 28.05.2020.
//

private var xoStickyHeaderKey: UInt8 = 0

public extension UITableView {
    
    var stickyHeader: FTStickyHeader! {
        get {
            var header = objc_getAssociatedObject(self, &xoStickyHeaderKey) as? FTStickyHeader
            
            if header == nil {
                header = FTStickyHeader()
                header!.scrollView = self
                objc_setAssociatedObject(self, &xoStickyHeaderKey, header, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            
            return header!
        }
    }
}
