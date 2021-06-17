//
//  SwiftletRadioButton.swift
//  Stuff To Get
//
//  Created by Kevin Mullins on 6/16/21.
//

import Foundation
import SwiftUI

/// Defines a radio button that can be added to a `SwiftletRadioButtonGroup` for display in a `SwiftletRadioButtonPicker`.
public class SwiftletRadioButton: Identifiable, Equatable, ObservableObject {
    // MARK: - Static functions
    
    /// Defines a function to test and see if two `SwiftletRadioButton` are equal to eachother.
    /// - Returns: `true` if equal, else returns false.
    public static func == (lhs: SwiftletRadioButton, rhs: SwiftletRadioButton) -> Bool {
        return lhs.id == rhs.id
    }
    
    // MARK: - Properties
    /// Defines a unique id for the Radio Button.
    @Published public var id:String
    
    /// Defines the display name of the Radio Button.
    @Published public var name:String
    
    /// If `true`, the Radio Button is selected.
    @Published public var isSelected:Bool = false
    
    /// An option tag that can be attached to the Radio Button.
    public var tag:Any? = nil
    
    // MARK: - Initializers
    /// Creates a new instance of the Radio Button with the given properties.
    /// - Parameters:
    ///   - id: The button's unique id.
    ///   - name: The display name of the button.
    ///   - isSelected: If `true`, the button will be selected.
    ///   - tag: An optional tag that can be attached to the button.
    public init(id:String, name:String, isSelected:Bool = false, tag:Any? = nil) {
        // Initialize
        self.id = id
        self.name = name
        self.isSelected = isSelected
        self.tag = tag
    }
}
