//  ListCheckRow.swift
//  Eureka ( https://github.com/xmartlabs/Eureka )
//
//  Copyright (c) 2016 Xmartlabs SRL ( http://xmartlabs.com )
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import UIKit

open class ListCheckCell<T: Equatable> : Cell<T>, CellType {

    required public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Image for selected state
    lazy public var trueImage: UIImage = {
        if #available(iOS 13.0, *) {
            let configuration = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold, scale: .large)
            return UIImage(systemName: "checkmark.circle.fill", withConfiguration: configuration)!
        } else {
            return UIImage(named: "checkmark.circle.fill")!
        }
        
    }()
    
    open override func update() {
        super.update()
        
        checkImageView?.image = row.value != nil ? trueImage : nil
        checkImageView?.sizeToFit()
        
//        accessoryType = row.value != nil ? .checkmark : .none
//
//        editingAccessoryType = accessoryType
        selectionStyle = .default
        if row.isDisabled {
            tintAdjustmentMode = .dimmed
            selectionStyle = .none
        } else {
            tintAdjustmentMode = .automatic
        }
    }
    
    /// Image view to render images. If `accessoryType` is set to `checkmark`
    /// will create a new `UIImageView` and set it as `accessoryView`.
    /// Otherwise returns `self.imageView`.
    open var checkImageView: UIImageView? {
        guard accessoryType == .checkmark else {
            return self.imageView
        }
        
        guard let accessoryView = accessoryView else {
            let imageView = UIImageView()
            self.accessoryView = imageView
            return imageView
        }
        
        return accessoryView as? UIImageView
    }
    

    open override func setup() {
        super.setup()
        accessoryType =  .checkmark
        editingAccessoryType = accessoryType
    }

    open override func didSelect() {
        row.deselect()
        row.updateCell()
    }

}

public final class ListCheckRow<T>: Row<ListCheckCell<T>>, SelectableRowType, RowType where T: Equatable {
    public var selectableValue: T?
    required public init(tag: String?) {
        super.init(tag: tag)
        displayValueFor = nil
    }
}
