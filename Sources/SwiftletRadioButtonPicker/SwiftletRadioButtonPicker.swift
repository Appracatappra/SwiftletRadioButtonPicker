//
//  SwiftletRadioButtonPicker.swift
//  Stuff To Get
//
//  Created by Kevin Mullins on 6/16/21.
//

import SwiftUI

/// Creates a cross-platform Radio Button Picker that allow the user to select from a small group of options by presenting a list of `SwiftletRadioButton` objects that the user can tap on to select one items from the list.
///
/// The `SwiftletRadioButtonPicker` works best when presenting a very limited number of options to the user. For example: selecting Male or Female. Generally this should be used for six or less options. For more options, you'll be better suited using one ofthe standard, built-in SwiftUI Picker views.
///
/// ## Example:
/// ```swift
/// SwiftletRadioButtonPicker(alignment: .grid, columns: 3, selection:"2")
///    .radioButton(id: "0", name: "Option One")
///    .radioButton(id: "1", name: "Option Two")
///    .radioButton(id: "2", name: "Option Three")
///    .radioButton(id: "3", name: "Option Four")
/// ```
public struct SwiftletRadioButtonPicker: View {
    // MARK: - Properties
    /// Controls how Radio Buttons are laid out inside of the picker.
    public var alignment:SwiftletRadioButtonAlignment = .vertical
    
    /// Defines the title show over the list of Radio Buttons.
    public var title:String = "Please select one:"
    
    /// If `true`, displays a title over the collection of buttons.
    public var showTitle:Bool = true
    
    /// Defines the color the title is displayed in.
    public var titleColor:Color = .black
    
    /// Defines the color of the selector indicator.
    public var selectorColor:Color = .black
    
    /// Defines the size of the selector indicator.
    public var selectorSize:Double = 24
    
    /// Defines the name of the Symbol displayed when a Radio Button is selected.
    public var selectedSymbolName = "largecircle.fill.circle"
    
    /// Defines the name of the Symbol displayed when a Radio Button is unselected.
    public var unselectedSymbolName = "circle"
    
    /// Details the color the text of the Radio Button is displayed in.
    public var textColor:Color = .black
    
    /// If the `alignment` is `grid`, defines the number of columns displayed in the grid.
    public var columns:Int = 2
    
    /// Defines the currently selected Radio Button (by its `id`).
    public var selection:String = ""
    
    /// Completion that is called when the Radio Button selection changes.
    public var selectionChanged:((SwiftletRadioButton) -> Void)? = nil
    
    /// The group of `SwiftletRadioButton` objects displayed by this Picker.
    @ObservedObject public var buttonGroup:SwiftletRadioButtonGroup = SwiftletRadioButtonGroup()
    
    /// The definition of the columns displayed when the `alignment` is `grid`.
    var items:[GridItem] {
        Array(repeating: .init(.adaptive(minimum: 120)), count: columns)
    }
    
    // MARK: - Initializers
    public init(alignment:SwiftletRadioButtonAlignment = .vertical, title:String = "Please select one:", showTitle:Bool = true, titleColor:Color = .black, selectorColor:Color = .black, selectorSize:Double = 24, selectedSymbolName:String = "largecircle.fill.circle", unselectedSymbolName:String = "circle", textColor:Color = .black, columns:Int = 2, selection:String = "", buttonGroup:SwiftletRadioButtonGroup = SwiftletRadioButtonGroup(), selectionChanged:((SwiftletRadioButton) -> Void)? = nil) {
        // Initialize
        self.alignment = alignment
        self.title = title
        self.showTitle = showTitle
        self.titleColor = titleColor
        self.selectorColor = selectorColor
        self.selectorSize = selectorSize
        self.selectedSymbolName = selectedSymbolName
        self.unselectedSymbolName = unselectedSymbolName
        self.textColor = textColor
        self.columns = columns
        self.selection = selection
        self.buttonGroup = buttonGroup
        self.selectionChanged = selectionChanged
    }
    
    // MARK: - View Body
    /// The body of the picker.
    public var body: some View {
        VStack {
            if showTitle {
                HStack {
                    Text(title)
                        .font(.headline)
                    
                    Spacer()
                }
            }
            
            switch(alignment) {
            case .horizontal:
                HStack {
                    ForEach(buttonGroup.buttons) { button in
                        radioButton(button)
                            .onTapGesture {
                                buttonGroup.selectButton(button)
                                if let selectionChanged = selectionChanged {
                                    selectionChanged(button)
                                }
                            }
                    }
                }
                .padding([.leading, .bottom, .trailing])
            case .vertical:
                VStack(alignment: .leading) {
                    ForEach(buttonGroup.buttons) { button in
                        radioButton(button)
                            .onTapGesture {
                                buttonGroup.selectButton(button)
                                if let selectionChanged = selectionChanged {
                                    selectionChanged(button)
                                }
                            }
                    }
                }
                .padding([.leading, .bottom, .trailing])
            case .grid:
                VStack(alignment: .leading) {
                    LazyVGrid(columns: items) {
                        ForEach(buttonGroup.buttons) { button in
                            radioButton(button)
                                .onTapGesture {
                                    buttonGroup.selectButton(button)
                                    if let selectionChanged = selectionChanged {
                                        selectionChanged(button)
                                    }
                                }
                        }
                    }
                }
                .padding([.leading, .bottom, .trailing])
            }
        }
    }
    
    // MARK: - Functions
    @ViewBuilder
    /// Generates the individual Radio Button views.
    /// - Parameter button: The Radio Button to display
    /// - Returns: The View for the `SwiftletRadioButton`.
    private func radioButton(_ button:SwiftletRadioButton) -> some View {
        HStack {
            #if swift(>=5.5)
            Image(systemName: (button.isSelected) ? selectedSymbolName : unselectedSymbolName)
                .resizable()
                .frame(width: selectorSize, height: selectorSize)
            #else
            Image(systemName: (button.isSelected) ? selectedSymbolName : unselectedSymbolName)
                .resizable()
                .frame(width: CGFloat(selectorSize), height: CGFloat(selectorSize))
            #endif
            
            Text(button.name)
            
            Spacer()
        }
    }
    
    /// Adds a Radio Button to the Picker with the given properties
    /// - Parameters:
    ///   - id: The unique id of the button.
    ///   - name: The display name for the Radio Button.
    ///   - isSelected: If `true`, this button will be selected.
    ///   - tag: An optional tag to attach to the button.
    /// - Returns: This `SwiftletRadioButtonPicker` so multiple command can be chained.
    @discardableResult public func radioButton(id:String, name:String, isSelected:Bool = false, tag:Any? = nil) -> SwiftletRadioButtonPicker {
        
        // Add new button to collection
        let button = SwiftletRadioButton(id: id, name: name, isSelected: isSelected, tag: tag)
        buttonGroup.add(button)
        
        // Return self
        return self
    }
    
    /// Adds a new radio button group to this control.
    /// - Parameter buttonGroup: The radio button group to add.
    /// - Returns: This `SwiftletRadioButtonPicker` so multiple command can be chained.
    @discardableResult public mutating func radioButtonGroup(buttonGroup:SwiftletRadioButtonGroup) -> SwiftletRadioButtonPicker {
        
        // Add new radio button group.
        self.buttonGroup = buttonGroup
        
        return self
    }
    
    /// Adds all of the cases from the given Enum to the Picker and Radio Button options.
    /// - Parameter from: The enum type to create the list of options from (in the form `myEnum.self`).
    /// - Returns: This `SwiftletRadioButtonPicker` so multiple command can be chained.
    @discardableResult public func radioButtons<T: CaseIterable>(from enumeration: T.Type) -> SwiftletRadioButtonPicker {
        
        for value in enumeration.allCases {
            let button = SwiftletRadioButton(id: "\(value)", name: "\(value)")
            button.isSelected = (button.id == selection)
            buttonGroup.add(button)
        }
        
        // Return self
        return self
    }
}


/// Defines a sample version of the `SwiftletRadioButtonPicker` used during design.
struct SwiftletRadioButtonPicker_Previews: PreviewProvider {
    /// Returns the sample previews for design.
    static var previews: some View {
        SwiftletRadioButtonPicker(alignment: .grid, columns: 3, selection:"2")
            .radioButton(id: "0", name: "Option One")
            .radioButton(id: "1", name: "Option Two")
            .radioButton(id: "2", name: "Option Three")
            .radioButton(id: "3", name: "Option Four")
    }
}
