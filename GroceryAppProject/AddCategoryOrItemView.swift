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

    // Picker to choose between Category and Product
    @State private var selectedType = "Category"
    
    // Shared field for both Category and Product
    @State private var name = ""
    
    // For Category: Use PhotosPicker to select an image.
    @State private var selectedCategoryPhotoItem: PhotosPickerItem?
    @State private var selectedCategoryImageData: Data?
    
    // For Product: additional fields
    @State private var price = ""
    @State private var productDescription = ""
    
    // For Product: use dynamic categories from Core Data.
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(key: "createdAt", ascending: true)],
        animation: .default)
    private var fetchedCategories: FetchedResults<Category>
    
    @State private var selectedCategory: Category?
    
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
                Section(header: Text("Name")) {
                    TextField("Enter name", text: $name)
                }
                
                if selectedType == "Category" {
                    // Category-specific: Select an image using PhotosPicker.
                    Section(header: Text("Image")) {
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
                            // Ensure the selectedCategory is set when the view appears.
                            Picker("Select Category", selection: $selectedCategory) {
                                ForEach(fetchedCategories, id: \.self) { category in
                                    Text(category.name ?? "")
                                        .tag(category as Category?)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .onAppear {
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
    
    private func handleSave() {
        if selectedType == "Category" {
            // Save the new category using name and selectedCategoryImageData.
            CoreDataManager.shared.addCategory(name: name, imageData: selectedCategoryImageData)
            print("Saving Category: \(name)")
        } else {
            guard let selectedCat = selectedCategory else {
                print("No category selected for product")
                return
            }
            // Save the new product using name, price, description, selectedCategory, and selectedImageData.
            let categoryName = selectedCat.name ?? ""
            let priceDecimal = Decimal(string: price) ?? 0
            // Use a valid SF Symbol name ("photo") as a fallback placeholder.
            let imageNamePlaceholder = "photo"
            CoreDataManager.shared.addProduct(name: name, price: priceDecimal, imageName: imageNamePlaceholder, category: categoryName)
            print("Saving Product: \(name), Price: \(price), Description: \(productDescription), Category: \(categoryName)")
        }
    }
}

struct AddCategoryOrItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryOrItemView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
