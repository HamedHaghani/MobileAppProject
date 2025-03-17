//
//  AddCategoryOrItemView.swift
//  GroceryAppProject
//
//  Created by Mehmet Ali Kaba on 2025-03-16.
//

import SwiftUI
import PhotosUI  // For PhotosPicker (iOS 16+)
import Photos   // For PHPhotoLibrary

struct AddCategoryOrItemView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var selectedType = "Category"
    
    // Shared field for both Category and Product
    @State private var name = ""
    
    // For Category: Instead of a text field, we'll use a PhotosPicker to select an image.
    @State private var selectedCategoryPhotoItem: PhotosPickerItem?
    @State private var selectedCategoryImageData: Data?
    
    // For Product: additional fields
    @State private var price = ""
    @State private var productDescription = ""
    
    // New: For selecting an existing category for the product
    @State private var selectedCategory: String = "Fruits"
    let existingCategories = ["Fruits", "Vegetables", "Dairy", "Bakery", "Meat", "Frozen", "Beverages", "Snacks"]
    
    // For product image selection using PhotosPicker
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    
    let types = ["Category", "Product"]
    
    var body: some View {
        NavigationView {
            Form {
                // Picker to choose between Category and Product
                Picker("Select type", selection: $selectedType) {
                    ForEach(types, id: \.self) { type in
                        Text(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                // Shared field: Name
                Section(header: Text("Name"), content: {
                    TextField("Enter name", text: $name)
                })
                
                if selectedType == "Category" {
                    // Category-specific: Select an image using PhotosPicker.
                    Section(header: Text("Image"), content: {
                        PhotosPicker(
                            selection: $selectedCategoryPhotoItem,
                            matching: .images,
                            preferredItemEncoding: .automatic,
                            photoLibrary: PHPhotoLibrary.shared(),
                            label: {
                                Label("Select an Image", systemImage: "photo.on.rectangle")
                            }
                        )
                        .onChange(of: selectedCategoryPhotoItem) { newPhotoItem in
                            Task {
                                if let data = try? await newPhotoItem?.loadTransferable(type: Data.self) {
                                    self.selectedCategoryImageData = data
                                }
                            }
                        }
                        
                        if let selectedCategoryImageData,
                           let uiImage = UIImage(data: selectedCategoryImageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                        }
                    })
                } else {
                    // Product-specific fields
                    Section(header: Text("Category"), content: {
                        Picker("Select Category", selection: $selectedCategory) {
                            ForEach(existingCategories, id: \.self) { category in
                                Text(category)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    })
                    
                    Section(header: Text("Price"), content: {
                        TextField("Enter price", text: $price)
                            .keyboardType(.decimalPad)
                    })
                    
                    Section(header: Text("Description"), content: {
                        TextField("Enter description", text: $productDescription)
                    })
                    
                    Section(header: Text("Image"), content: {
                        PhotosPicker(
                            selection: $selectedPhotoItem,
                            matching: .images,
                            preferredItemEncoding: .automatic,
                            photoLibrary: PHPhotoLibrary.shared(),
                            label: {
                                Label("Select an Image", systemImage: "photo.on.rectangle")
                            }
                        )
                        .onChange(of: selectedPhotoItem) { newPhotoItem in
                            Task {
                                if let data = try? await newPhotoItem?.loadTransferable(type: Data.self) {
                                    self.selectedImageData = data
                                }
                            }
                        }
                        
                        if let selectedImageData,
                           let uiImage = UIImage(data: selectedImageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                        }
                    })
                }
            }
            .navigationTitle("Add \(selectedType)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Cancel Button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                // Save Button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        handleSave()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
    private func handleSave() {
        if selectedType == "Category" {
            // Save the new category using name and selectedCategoryImageData.
            print("Saving Category: \(name), Image Data: \(selectedCategoryImageData != nil)")
        } else {
            // Save the new product using name, price, description, selectedCategory, and selectedImageData.
            print("Saving Product: \(name), Price: \(price), Description: \(productDescription), Category: \(selectedCategory), Image Data: \(selectedImageData != nil)")
        }
    }
}

struct AddCategoryOrItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryOrItemView()
    }
}
