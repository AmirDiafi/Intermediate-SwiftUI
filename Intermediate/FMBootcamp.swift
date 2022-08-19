//
//  FMBootcamp.swift
//  Intermediate
//
//  Created by AmirDiafi on 8/12/22.
//

import SwiftUI

class LocalFileManager {
    
    static let shared = LocalFileManager()
    let appDirectoryName = "MyAppImages"
    
    func creatDirectory() {
        guard let path = FileManager.default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(appDirectoryName)
            .path
        else {
            print("FOLDER DID NOT CREATED!")
            return
        }
        
        //CHECK IF DIRECTORY EXISTS
        if !FileManager.default.fileExists(atPath: path) {
            //CREATE DIRECTORY
            do {
                try FileManager.default.createDirectory(
                    atPath: path,
                    withIntermediateDirectories: true,
                    attributes: nil)
                print("DIRECTORY CREATED!")
            } catch let error {
                print("DIRECTORY DID NOT CREATED \(error.localizedDescription)")
            }
        } else {
            print("DIRECTORY ALREADY EXISTS!")
        }
    }
    
    func saveImage(image: UIImage, name: String) {
        creatDirectory()
        guard let data = image.jpegData(compressionQuality: 1.0) else {
            print("DATA NOT AVAILABLE")
            return
        }
        
        
        guard let path = FileManager
                .default
                .urls(
                    for: .cachesDirectory,
                    in: .userDomainMask)
                .first?
                .appendingPathComponent(appDirectoryName)
                .appendingPathComponent("\(name).jpeg")
        else {
            return
        }
        
        do {
            try data.write(to: path)
            print("IMAGE HAS SAVED TO \(path)")
        } catch let error {
            print("IMAGE NOT SAVED. \(error.localizedDescription)")
        }
        
    }
    
    func getImage(name: String) -> UIImage? {
        
        guard let path = getPathForImage(name: name)?.path,
              FileManager
                .default
                .fileExists(atPath: path)
        else {
            print("FILE NOT EXISTS AT")
            return nil
        }
        
        return UIImage(contentsOfFile: path)
        
    }
    
    func deleteImage(name: String) -> Bool {
        guard let path = getPathForImage(name: name)?.path,
              FileManager
                .default
                .fileExists(atPath: path)
        else {
            print("FILE NOT FOUND")
            return false
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("FILE DELETED")
        } catch let error {
            print("FILE DID NOT DELETED \(error.localizedDescription)")
        }
        
        return true
    }
    
    func deleteFolder() -> Bool {
        var isDeleted: Bool = false
        guard let path = FileManager.default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(appDirectoryName)
            .path
        else {
            print("DIRECTORY DID NOT CREATED!")
            return false
        }
        
        //CHECK IF DIRECTORY EXISTS
        if FileManager.default.fileExists(atPath: path) {
            //DELETE DIRECTORY
            do {
                try FileManager.default.removeItem(atPath: path)
                isDeleted = true
                print("DIRECTORY DELETED!")
            } catch let error {
                isDeleted = false
                print("DIRECTORY DID NOT DELETED \(error.localizedDescription)")
            }
        } else {
            isDeleted = false
            print("DIRECTORY ALREADY DID NOT EXIST!")
        }
        return isDeleted
    }
    
    func getPathForImage(name: String) -> URL? {
        guard let path = FileManager
                .default
                .urls(
                    for: .cachesDirectory,
                    in:.userDomainMask)
                .first?
                .appendingPathComponent(appDirectoryName)
                .appendingPathComponent("\(name).jpeg")
        else {
            print("no such file.")
            return nil
        }
        
        return path
    }
    
}

class FMViewModel: ObservableObject {
    let manager = LocalFileManager.shared
    
    @Published var image: UIImage? = nil
    @Published var savedImage: UIImage? = nil
    @Published var imageName: String = "prfl"
    
    init() {
        getImageFromAssetsFolder(name: imageName)
        manager.creatDirectory()
    }
    
    func getImageFromAssetsFolder(name: String) {
        image = UIImage(named: name)
    }
    
    func saveImage() {
        guard let image = image else {return}
        manager.saveImage(image: image, name: imageName)
    }
    
    func getSavedImage() {
        savedImage = manager.getImage(name: imageName)
    }
    
    func deleteFile() {
        let isDeleted = manager.deleteImage(name: imageName)
        savedImage = isDeleted ? nil : savedImage
    }
    
    func deleteDirectory() {
        let isDeleted = manager.deleteFolder()
        if isDeleted {
            getSavedImage()
        }
    }
    
}

struct FMBootcamp: View {
    @StateObject var vm = FMViewModel()
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding()
                }
                Button(action:{
                    vm.saveImage()
                }) {
                    Text("Save Image".uppercased())
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding()
                        .shadow(radius: 10)
                }

                if let image = vm.savedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding()
                }
                HStack {
                    Button(action:{
                        vm.getSavedImage()
                    }) {
                        Text("Get Image".uppercased())
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding()
                            .shadow(radius: 10)
                    }
                    
                    Button(action:{
                        vm.deleteFile()
                    }) {
                        Text("Delete Image".uppercased())
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(height: 50)
                            .background(Color.red)
                            .cornerRadius(10)
                            .padding()
                            .shadow(radius: 10)
                    }
                }
                Spacer()
                Button(action:{
                    vm.deleteDirectory()
                }) {
                    Text("Delete Folder".uppercased())
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(height: 50)
                        .background(Color.red)
                        .cornerRadius(10)
                        .padding()
                        .shadow(radius: 10)
                }
                
            }
            .navigationTitle("File Manager")
        }
    }
}

struct FMBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FMBootcamp()
    }
}
