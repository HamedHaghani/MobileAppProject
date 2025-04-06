//
//  AddCategoryOrItemView.swift
//  GroceryAppProject
//
//  Created by Mehmet Ali Kaba on 2025-03-16.
//

import SwiftUI
import PhotosUI
import Photos
import CoreData

struct AddCategoryOrItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext

    // Which type are we adding?
    @State private var selectedType = "Category"
    let types = ["Category", "Product"]
    
    // Shared text field for both Category & Product
    @State private var name = ""
    
    // For Category image
    @State private var selectedCategoryPhotoItem: PhotosPickerItem?
    @State private var selectedCategoryImageData: Data?
    
    // For Product
    @State private var price = ""
    @State private var productDescription = ""
    
    // For Product category selection
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(key: "createdAt", ascending: true)],
        animation: .default)
    private var fetchedCategories: FetchedResults<Category>
    
    @State private var selectedCategory: Category?
    
    // For Product image
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    
    var body: some View {
        NavigationView {
            Form {
                // Picker: Are we adding a Category or a Product?
                Picker("Select type", selection: $selectedType) {
                    ForEach(types, id: \.self) { type in
                        Text(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                // Shared field: Name
                Section(header: Text("Name")) {
                    TextField("Enter name", text: $name)
                }
                
                if selectedType == "Category" {
                    // Category-specific
                    Section(header: Text("Image")) {
                        PhotosPicker(
                            selection: $selectedCategoryPhotoItem,
                            matching: .images,
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
                        
                        // Preview
                        if let data = selectedCategoryImageData,
                           let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                        }
                    }
                } else {
                    // Product-specific fields
                    Section(header: Text("Category")) {
                        if fetchedCategories.isEmpty {
                            Text("No categories available. Please add one first.")
                        } else {
                            Picker("Select Category", selection: $selectedCategory) {
                                ForEach(fetchedCategories, id: \.self) { category in
                                    Text(category.name ?? "")
                                        .tag(category as Category?)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .onAppear {
                                // Initialize selection to first category if nil
                                if selectedCategory == nil {
                                    selectedCategory = fetchedCategories.first
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("Price")) {
                        TextField("Enter price", text: $price)
                            .keyboardType(.decimalPad)
                    }
                    
                    Section(header: Text("Description")) {
                        TextField("Enter description", text: $productDescription)
                    }
                    
                    Section(header: Text("Image")) {
                        PhotosPicker(
                            selection: $selectedPhotoItem,
                            matching: .images,
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
                        
                        // Preview
                        if let data = selectedImageData,
                           let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                        }
                    }
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
    
    // MARK: - Handle Save
    private func handleSave() {
        if selectedType == "Category" {
            // Save new category with (optional) image data
            CoreDataManager.shared.addCategory(name: name, imageData: selectedCategoryImageData)
            print("Saving Category: \(name)")
        } else {
            // Save new product with an image
            guard let selectedCat = selectedCategory else {
                print("No category selected for the product.")
                return
            }
            let catName = selectedCat.name ?? "Unknown"
            let priceDecimal = Decimal(string: price) ?? 0
            
            CoreDataManager.shared.addProduct(
                name: name,
                price: priceDecimal,
                category: catName,
                imageData: selectedImageData,
                productDescription: productDescription
            )
            print("Saving Product: \(name), Price: \(price), Description: \(productDescription), Category: \(catName)")
        }
    }
}

struct AddCategoryOrItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryOrItemView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
