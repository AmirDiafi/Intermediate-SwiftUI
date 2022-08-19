//
//  DownloadWithCombineBootcamp.swift
//  Intermediate
//
//  Created by AmirDiafi on 8/10/22.
//

import SwiftUI
import Combine

struct PostModel_Combined: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombinedViewModel: ObservableObject{
    
    @Published var posts: [PostModel_Combined] = []
    @Published var isLoading: Bool = true
    @Published var isFailed: Bool = false
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        else {
            self.isLoading = false
            print("URL FAILED!")
            return
        }
        
        downloadData(fromURL: url)
    }
    
    func downloadData(fromURL: URL) {
        URLSession.shared.dataTaskPublisher(for: fromURL)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel_Combined].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("COMPLETION FINISHED: \(completion)")
                    self.isFailed = false
                    break
                case .failure(let error):
                    print("COMPLETION ERROR: \(error.localizedDescription)")
                    self.isFailed = true
                }
            } receiveValue: {[weak self] (posts) in
                self?.posts = posts
                self?.isFailed = false
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func handleOutput(output: Publishers.SubscribeOn<URLSession.DataTaskPublisher, DispatchQueue>.Output) throws -> Data {
        guard let res = output.response as? HTTPURLResponse,
              res.statusCode >= 200 && res.statusCode < 300
        else {
            self.isFailed = true
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct DownloadWithCombinedBootcamp: View {
    @StateObject var vm = DownloadWithCombinedViewModel()
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading){
                    if vm.isLoading {
                        VStack{
                            ProgressView()
                                .padding(.bottom)
                            Text("Loading Data...")
                        }
                    } else if vm.isFailed {
                        Text("Oops! Data Failed to downloding!")
                    } else {
                        ForEach(vm.posts) { (post) in
                            VStack(alignment: .leading){
                                Text("Title: \(post.title)")
                                    .font(.headline)
                                    .padding(.bottom, 10)
                                Text("Body: \(post.body)")
                                    .font(.system(size: 14))
                                    
                            }
                            .padding()
                            Divider()
                        }

                    }
                }
            }
            .navigationTitle("Posts")
        }
    }
}

struct DownloadWithCombinedBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombinedBootcamp()
    }
}
