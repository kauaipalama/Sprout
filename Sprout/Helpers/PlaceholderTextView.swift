//
//  PlaceholderTextView.swift
//  Re:feynment
//
//  Created by Isidore Baldado on 3/12/18.
//  Copyright © 2018 Isidore Baldado. All rights reserved.
//

import UIKit

/// A textview that has a functioning placeholder like textField
@IBDesignable
class PlaceholderTextView: UITextView {
    
    //************************************
    // MARK: - Properties
    //************************************
    
    let placeholderLabel = UILabel()
    
    @IBInspectable
    var placeholder: String = ""{
        didSet{
            placeholderLabel.text = placeholder
            updateView()
        }
    }
    
    @IBInspectable
    var placeHolderColor: UIColor =  UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0){
        didSet{
            placeHolderColor = SproutTheme.current.accentColor
            updateView()
        }
    }
    
    
    
    @IBInspectable
    var placeholderFont: UIFont = UIFont(name: "HelveticaNeue", size: 22)!{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var doesAddQuotations: Bool = false
    
    //************************************
    // MARK: - Life Cycle Methods
    //************************************
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    internal func commonInit(){
        observeTextViewChanges()
        placeholderLabel.numberOfLines = 0
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)
        updateConstraintsForPlaceholderLabel()
    }
    
    override func awakeFromNib() {
        textDidChange()
        updateView()
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self,
                                                  name: UITextView.textDidBeginEditingNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UITextView.textDidChangeNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UITextView.textDidEndEditingNotification,
                                                  object: nil)
    }
    
    //************************************
    // MARK: - Helper Methods
    //************************************
    
    fileprivate func hidePlaceholderIfTextIsEmpty() {
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    func updateView(){
        placeholderLabel.font = placeholderFont
        placeholderLabel.textColor = placeHolderColor
        hidePlaceholderIfTextIsEmpty()
        
        if doesAddQuotations{
            removeQuotationsFromText()
            addQuotationsToText()
        }
    }
    
   

    fileprivate func observeTextViewChanges() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidBeginEditing),
                                               name: UITextView.textDidBeginEditingNotification,
                                               object: self)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange),
                                               name: UITextView.textDidChangeNotification,
                                               object: self)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidEndEditing),
                                               name: UITextView.textDidEndEditingNotification,
                                               object: self)
    }
    
    //************************************
    // MARK: - Text View Changes
    //************************************
    
    @objc internal func textDidBeginEditing(){
        if doesAddQuotations{removeQuotationsFromText()}
    }
    
    @objc internal func textDidChange(){
        hidePlaceholderIfTextIsEmpty()
    }
    
    @objc internal func textDidEndEditing(){
        if text.isEmpty {return}
        if doesAddQuotations{addQuotationsToText()}
    }
    
    //************************************
    // MARK: - Constraints
    //************************************
    
    private var placeholderLabelConstraints = [NSLayoutConstraint]()
    
    /// Sets up constraints for placeholder label
    private func updateConstraintsForPlaceholderLabel() {
        var newConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(\(textContainerInset.left + textContainer.lineFragmentPadding))-[placeholder]",
            options: [],
            metrics: nil,
            views: ["placeholder": placeholderLabel])
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(\(textContainerInset.top))-[placeholder]",
            options: [],
            metrics: nil,
            views: ["placeholder": placeholderLabel])
        newConstraints.append(NSLayoutConstraint(
            item: placeholderLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
            multiplier: 1.0,
            constant: -(textContainerInset.left + textContainerInset.right + textContainer.lineFragmentPadding * 2.0)
        ))
        removeConstraints(placeholderLabelConstraints)
        addConstraints(newConstraints)
        placeholderLabelConstraints = newConstraints
    }
    
}

extension PlaceholderTextView{
    func addQuotationsToText(){
        guard !text.isEmpty else {return}
        text = text.trimmingCharacters(in: ["\""])
        text.insert("\"", at: text.startIndex)
        text.append("\"")
    }
    
    func removeQuotationsFromText(){
        text = text.trimmingCharacters(in: ["\""])
    }
}
