//
//  DownloadingWithEscapingBootcamp.swift
//  Intermediate
//
//  Created by AmirDiafi on 8/10/22.
//

import SwiftUI

struct PostModel: Identifiable, Codable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadingWithEscapingViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    @Published var isLoading: Bool = true
    @Published var isFailed: Bool = false
    
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
        
        donwloadData(fromURL: url) { (returnedData) in
            if let data = returnedData {
                guard let finalData = try?
                        JSONDecoder()
                        .decode([PostModel].self, from: data)
                else {
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.isFailed = true
                    }
                    print("NO DATA DECODED!")
                    return
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.isFailed = false
                    self?.posts = finalData
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {[weak self] in
                        self?.isLoading = false
                    }
                }
            } else {
                self.isLoading = false
                self.isFailed = false
                print("NO DATA RETURNED")
            }
            
        }
    }
    
    func donwloadData(fromURL: URL, completionHdandler: @escaping completionType) {
        URLSession.shared.dataTask(with: fromURL) { (data, response, error) in
            
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  // Successful responses (200–299)
                  response.statusCode >= 200 && response.statusCode < 300
            else {
                print("ERROR DOWNLODING DATA!")
                completionHdandler(nil)
                return
            }
            
            completionHdandler(data)
                
            
        }.resume()
    }
}



typealias completionType = (_ data: Data?) -> ()

struct DownloadingWithEscapingBootcamp: View {
    @StateObject var vm = DownloadingWithEscapingViewModel()
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

struct DownloadingWithEscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingWithEscapingBootcamp()
    }
}
