//
//  DownloadImagesVM.swift
//  Intermediate
//
//  Created by AmirDiafi on 8/14/22.
//

import Foundation
import Combine

class DownloadImagesViewModel: ObservableObject {
    @Published var data: [PhotoModel]? = nil
    @Published var isLoading: Bool = true
    static var instance = DownloadImagesViewModel()
    var cancellables = Set<AnyCancellable>()
    let manager = DataManager.shared
    
    private init() {
        subscribeToDataManager()
    }
    
    func subscribeToDataManager() {
        manager.$photos.sink {[weak self] (data) in
            self?.data = data
            self?.isLoading = false
        }
        .store(in: &cancellables)
        
        manager.$isLoading.sink {[weak self] (isLoading) in
            self?.isLoading = isLoading
        }
        .store(in: &cancellables)
    }
    
}
