//
//  FTStickyHeaderView.swift
//  FBSnapshotTestCase
//
//  Created by Yusuf Demirci on 28.05.2020.
//

public class FTStickyHeaderView: UIView {
    
    // MARK: - Properties
    weak var parent: FTStickyHeader?
    internal static var KVOContext = 0
    
    public override func willMove(toSuperview view: UIView?) {
        if let view = superview, view.isKind(of: UIScrollView.self), let parent = parent {
            view.removeObserver(parent, forKeyPath: "contentOffset", context: &FTStickyHeaderView.KVOContext)
        }
    }
    
    public override func didMoveToSuperview() {
        if let view = superview, view.isKind(of:UIScrollView.self), let parent = parent {
            view.addObserver(parent, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.new, context: &FTStickyHeaderView.KVOContext)
        }
    }
}
