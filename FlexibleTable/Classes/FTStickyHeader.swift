//
//  FTStickyHeader.swift
//  FBSnapshotTestCase
//
//  Created by Yusuf Demirci on 28.05.2020.
//

public class FTStickyHeader: NSObject {
    
    // MARK: - Public Properties
    /// The view attached to the sticky header
    public var view: UIView? {
        set {
            guard newValue != _view else { return }
            _view = newValue
            updateConstraints()
        } get {
            return _view
        }
    }
    /// The height of the header
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
    /// The minimum height of the header
    public var minimumHeight: CGFloat {
        set {
            _minimumHeight = newValue
            layoutContentView()
        } get { return _minimumHeight }
    }
    /// The mask color will show when header reaches the minimum height
    public var maskColor: UIColor? {
        didSet {
            setDefaultMaskView()
        }
    }
    /// The custom mask
    public var maskView: UIView? {
        didSet {
            setCustomMaskView()
        }
    }
    /// The change speed of mask appearance&disappearance
    /// - Attention: _maskChangeSpeed
    /// - Note: Higher value provides soft transition
    /// - Requires: maskChangeSpeed > 0
    public var maskChangeSpeed: CGFloat {
        set {
            _maskChangeSpeed = newValue
        } get { return _maskChangeSpeed }
    }
    /// The start offset of mask
    /// - Attention: _maskChangeStartOffset
    /// - Note: Higher value provides to start the change earlier
    /// - Requires: height > maskChangeStartOffset > minimumHeight
    public var maskChangeStartOffset: CGFloat?
    public var delegate: FTDelegate?
    public var didMaskViewAlphaChange: ((CGFloat) -> Void)?
    
    // MARK: - Private Properties
    private(set) lazy var contentView: FTStickyHeaderView = {
        let view: FTStickyHeaderView = FTStickyHeaderView()
        view.parent = self
        view.clipsToBounds = true
        return view
    }()
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
    private weak var _scrollView: UIScrollView?
    private var _view: UIView?
    private var _height: CGFloat = 0
    private var _minimumHeight: CGFloat = 0
    private var _maskView: UIView = {
        let view: UIView = UIView()
        view.alpha = 0
        return view
    }()
    private var _maskChangeSpeed: CGFloat = 100
    
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
        
        contentView.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0))
        
        contentView.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height))
        
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
        
        let _maskChangeStartOffset: CGFloat = maskChangeStartOffset ?? height / 1.5
        
        var maskViewAlpha: CGFloat = min(1.0, (scrollView.contentOffset.y + _maskChangeStartOffset) / _maskChangeSpeed)
        if maskViewAlpha < 0 {
            maskViewAlpha = 0
        }
        
        if maskView != nil {
            maskView?.alpha = maskViewAlpha
            
            delegate?.didMaskViewAlphaChange(alpha: maskViewAlpha)
            didMaskViewAlphaChange?(maskViewAlpha)
        } else if maskColor != nil {
            _maskView.alpha = maskViewAlpha
            
            delegate?.didMaskViewAlphaChange(alpha: maskViewAlpha)
            didMaskViewAlphaChange?(maskViewAlpha)
        }
        
        contentView.frame = CGRect(x: 0, y: relativeYOffset, width: scrollView.frame.size.width, height: height)
    }
    
    func setDefaultMaskView() {
        guard let maskColor = maskColor else { return }
        
        _maskView.backgroundColor = maskColor
        
        contentView.addSubview(_maskView)
        
        _maskView.anchor(left: contentView.leftAnchor, paddingLeft: 0, top: contentView.topAnchor, paddingTop: 0, right: contentView.rightAnchor, paddingRight: 0, bottom: contentView.bottomAnchor, paddingBottom: 0)
    }
    
    func setCustomMaskView() {
        guard let maskView = maskView else { return }
        maskView.alpha = 0
        
        contentView.addSubview(maskView)
        
        maskView.anchor(left: contentView.leftAnchor, paddingLeft: 0, top: contentView.topAnchor, paddingTop: 0, right: contentView.rightAnchor, paddingRight: 0, bottom: contentView.bottomAnchor, paddingBottom: 0)
    }
}
