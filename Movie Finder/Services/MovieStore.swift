//
//  MovieStore.swift
//  Movie Finder
//
//  Created by P Vamshi Prasad on 19/01/23.
//

import Foundation

class MovieStore: MovieService{
    
    static let shared = MovieStore()
    private init(){}
    
    private let apiKey = ""
    private let baseURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchMovies(from endpoint: MovieListEndpoints, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseURL)/trending/movie/week/\(endpoint.rawValue)")else{
            completion(.failure(.invalidEndPointError))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
        
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseURL)/movie/\(id)")else{
            completion(.failure(.invalidEndPointError))
            return
        }
        self.loadURLAndDecode(url: url, params: ["append_to_response" : "videos, credits"], completion: completion)
    }
    
    func searchMovies(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseURL)/search/movie/")else{
            completion(.failure(.invalidEndPointError))
            return
        }
        self.loadURLAndDecode(url: url, params: ["query" : query], completion: completion)
    }
    
    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, MovieError>)->()){
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndPointError))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params{
            queryItems.append(contentsOf: params.map {URLQueryItem(name: $0.key, value: $0.value)})
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndPointError))
            return
        }
        
        urlSession.dataTask(with: finalURL) { [weak self] data, response, error in
            guard let self = self else { return }
            if error != nil{
                self.excecuteCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.excecuteCompletionHandlerInMainThread(with: .failure(.invalidResponseError), completion: completion)
                return
            }
            
            guard let data = data else{
                self.excecuteCompletionHandlerInMainThread(with: .failure(.noDataError), completion: completion)
                return
            }
            
            do{
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.excecuteCompletionHandlerInMainThread(with: .success(decodedResponse), completion: completion)
            }catch{
                self.excecuteCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    
    private func excecuteCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, MovieError> , completion: @escaping (Result<D, MovieError>)->()){
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
}
