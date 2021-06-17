//
//  SwiftletRadioButtonGroup.swift
//  Stuff To Get
//
//  Created by Kevin Mullins on 6/16/21.
//

import Foundation
import SwiftUI

/// Contains a collection of `SwiftletRadioButton` objects that will be displayed in a `SwiftletRadioButtonPicker`. The `SwiftletRadioButtonGroup` also includes functins to add and remove button and to ensure that only one button in select at once.
public class SwiftletRadioButtonGroup:ObservableObject {
    // MARK: - Properties
    /// The collection of `SwiftletRadioButton` objects maintained by this group.
    @Published public var buttons:[SwiftletRadioButton] = []
    
    // MARK: - Initializers
    /// Creates a new instance of the object.
    public init() {
        
    }
    
    // MARK: - Functions
    /// Adds the given `SwiftletRadioButton` to the group.
    /// - Parameter button: The `SwiftletRadioButton` to add.
    public func add(_ button:SwiftletRadioButton) {
        
        if button.isSelected {
            selectNone()
        }
        
        buttons.append(button)
        
        ensureSelection()
    }
    
    /// Removes the given `SwiftletRadioButton` from the group.
    /// - Parameter item: The `SwiftletRadioButton` to remove.
    public func remove(_ item:SwiftletRadioButton) {
        var n = 0
        
        for button in buttons {
            if button == item {
                buttons.remove(at: n)
                break
            }
            n += 1
        }
        
        ensureSelection()
    }
    
    /// Deselects all of the `SwiftletRadioButton` objects in the group.
    public func selectNone() {
        for button in buttons {
            button.isSelected = false
        }
    }
    
    /// Ensures that only one `SwiftletRadioButton` is selected in the group.
    public func ensureSelection() {
        
        guard buttons.count > 0 else {
            return
        }
        
        for button in buttons {
            if button.isSelected {
                return
            }
        }
        
        buttons[0].isSelected = true
    }
    
    /// Selects the given `SwiftletRadioButton` and deselects all other buttons in the group
    /// - Parameter item: The `SwiftletRadioButton` to select.
    public func selectButton(_ item:SwiftletRadioButton) {
        guard buttons.count > 0 else {
            return
        }
        
        selectNone()
        
        for button in buttons {
            if button == item {
                button.isSelected = true
                refreshUI()
                return
            }
        }
        
        ensureSelection()
        refreshUI()
    }
    
    /// Forces any SwiftUI View this group is attached to to refresh.
    func refreshUI()  {
        objectWillChange.send()
    }
}
