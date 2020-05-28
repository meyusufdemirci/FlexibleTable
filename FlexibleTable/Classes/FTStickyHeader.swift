//
//  FTStickyHeader.swift
//  FBSnapshotTestCase
//
//  Created by Yusuf Demirci on 28.05.2020.
//

public class FTStickyHeader: NSObject {
    
    // MARK: - Properties
    // The view attached to the sticky header.
    public var view: UIView? {
        set {
            guard newValue != _view else { return }
            _view = newValue
            updateConstraints()
        } get {
            return _view
        }
    }
    // The height of the header.
    public var height: CGFloat {
        set {
            guard newValue != _height else { return }
            
            if let scrollView = scrollView {
                adjustScrollViewTopInset(top: scrollView.contentInset.top - height + newValue)
            }
            
            _height = newValue
            
            updateConstraints()
            layoutContentView()
        } get { return _height }
    }
    // The minimum height of the header.
    public var minimumHeight: CGFloat {
        set {
            _minimumHeight = newValue
            layoutContentView()
        } get { return _minimumHeight }
    }
    // The view containing the provided header
    private(set) lazy var contentView: FTStickyHeaderView = {
        let view: FTStickyHeaderView = FTStickyHeaderView()
        view.parent = self
        view.clipsToBounds = true
        return view
    }()
    private weak var _scrollView: UIScrollView?
    // The `UIScrollView` attached to the sticky header
    weak var scrollView: UIScrollView? {
        set {
            if _scrollView != newValue {
                _scrollView = newValue
                
                if let scrollView = scrollView {
                    adjustScrollViewTopInset(top: scrollView.contentInset.top + self.height)
                    scrollView.addSubview(contentView)
                }
                
                layoutContentView()
            }
        } get {
            return _scrollView
        }
    }
    private var _view: UIView?
    private var _height: CGFloat = 0
    private var _minimumHeight: CGFloat = 0
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let path = keyPath, context == &FTStickyHeaderView.KVOContext && path == "contentOffset" {
            layoutContentView()
            return
        }
        
        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
    }
}

// MARK: - Private Functions
private extension FTStickyHeader {
    
    func adjustScrollViewTopInset(top: CGFloat) {
        guard let scrollView = scrollView else { return }
        
        var inset = scrollView.contentInset
        
        // Adjust content offset
        var offset = scrollView.contentOffset
        offset.y += inset.top - top
        scrollView.contentOffset = offset
        
        // Adjust content inset
        inset.top = top
        scrollView.contentInset = inset
        
        self.scrollView = scrollView
    }
    
    func updateConstraints() {
        guard let view = view else { return }
        
        view.removeFromSuperview()
        contentView.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v]|", options: [], metrics: nil, views: ["v": view]))
        
        contentView.addConstraint(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0))
        
        contentView.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height))
        
    }
    
    func layoutContentView() {
        var relativeYOffset: CGFloat = 0
        
        guard let scrollView = scrollView else { return }
        
        if scrollView.contentOffset.y < -minimumHeight {
            relativeYOffset = -height
        } else {
            let compensation: CGFloat = -minimumHeight - scrollView.contentOffset.y
            relativeYOffset = -height - compensation
        }
        
        contentView.frame = CGRect(x: 0, y: relativeYOffset, width: scrollView.frame.size.width, height: height)
    }
}
