//
//  EditProductView.swift
//  GroceryAppProject
//
//  Created by Mehmet Ali Kaba on 2025-04-05.
//

import Foundation
import SwiftUI
import PhotosUI

struct EditProductView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var product: Product

    // Editable fields initialized from the existing product data.
    @State private var name: String
    @State private var price: String
    @State private var productDescription: String
    @State private var category: String
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var selectedImageData: Data?

    init(product: Product) {
        self.product = product
        _name = State(initialValue: product.name ?? "")
        _price = State(initialValue: product.price?.stringValue ?? "")
        _productDescription = State(initialValue: product.productDescription ?? "")
        _category = State(initialValue: product.category ?? "")
        _selectedImageData = State(initialValue: product.imageData)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Info")) {
                    TextField("Name", text: $name)
                    TextField("Price", text: $price)
                        .keyboardType(.decimalPad)
                    TextField("Category", text: $category)
                    TextField("Description", text: $productDescription)
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
                    .onChange(of: selectedPhotoItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedImageData = data
                            }
                        }
                    }
                    
                    if let data = selectedImageData, let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                }
            }
            .navigationTitle("Edit Product")
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
                        saveChanges()
                    }
                }
            }
        }
    }
    
    private func saveChanges() {
        product.name = name
        if let decimalPrice = Decimal(string: price) {
            product.price = NSDecimalNumber(decimal: decimalPrice)
        }
        product.productDescription = productDescription
        product.category = category
        product.imageData = selectedImageData
        
        do {
            try managedObjectContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Error saving changes: \(error)")
        }
    }
}

struct EditProductView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        let dummyProduct = Product(context: context)
        dummyProduct.name = "Sample Product"
        dummyProduct.price = NSDecimalNumber(string: "9.99")
        dummyProduct.productDescription = "This is a sample product."
        dummyProduct.category = "Fruits"
        return NavigationView {
            EditProductView(product: dummyProduct)
                .environment(\.managedObjectContext, context)
        }
    }
}
