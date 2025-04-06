//
//  EditCategoryView.swift
//  GroceryAppProject
//
//  Created by Mehmet Ali Kaba on 2025-04-05.
//
import SwiftUI
import PhotosUI

struct EditCategoryView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss

    // Observe the category so changes update the view.
    @ObservedObject var category: Category

    // Editable fields – initialized from the existing category.
    @State private var name: String
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var selectedImageData: Data?

    init(category: Category) {
        self.category = category
        _name = State(initialValue: category.name ?? "")
        _selectedImageData = State(initialValue: category.imageData)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Category Info")) {
                    TextField("Category Name", text: $name)
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
            .navigationTitle("Edit Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Cancel Button (acts as Back)
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                // Save Button ("Done")
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveChanges()
                    }
                }
                // Delete Button placed in bottom toolbar.
                ToolbarItem(placement: .bottomBar) {
                    Button("Delete Category") {
                        deleteCategory()
                    }
                    .foregroundColor(.red)
                }
            }
        }
    }
    
    private func saveChanges() {
        category.name = name
        category.imageData = selectedImageData
        do {
            try managedObjectContext.save()
            dismiss()
        } catch {
            print("Error saving category changes: \(error)")
        }
    }
    
    private func deleteCategory() {
        managedObjectContext.delete(category)
        do {
            try managedObjectContext.save()
            dismiss()
        } catch {
            print("Error deleting category: \(error)")
        }
    }
}

struct EditCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        let dummyCategory = Category(context: context)
        dummyCategory.name = "Fruits"
        return NavigationView {
            EditCategoryView(category: dummyCategory)
                .environment(\.managedObjectContext, context)
        }
    }
}
