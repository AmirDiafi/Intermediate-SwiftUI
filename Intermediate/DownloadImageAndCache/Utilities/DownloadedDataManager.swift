//
//  DataManager.swift
//  Intermediate
//
//  Created by AmirDiafi on 8/14/22.
//

import Foundation
import Combine

class DataManager: ObservableObject {
    static let shared = DataManager()
    @Published var photos: [PhotoModel]? = nil
    @Published var isLoading: Bool = true
    var cancellables = Set<AnyCancellable>()
    
    private init() {
        downloadData()
    }
    
    func downloadData() {
        guard let url: URL = URL(string: "https://jsonplaceholder.typicode.com/photos") else {return}
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleData)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink {[weak self] (completion) in
                switch completion {
                case .finished:
                    print("Completion finished".uppercased())
                case .failure(let error):
                    print("completion error".uppercased(), error.localizedDescription)
                }
                self?.isLoading = false
            } receiveValue: { [weak self] (dataArray) in
                self?.photos = dataArray
            }
            .store(in: &cancellables)

        
    }
    
    func handleData(output: URLSession.DataTaskPublisher.Output) throws ->  Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}
