//
//  MovieModel.swift
//  Movie Finder
//
//  Created by P Vamshi Prasad on 19/01/23.
//

import Foundation

// MARK: - MovieResponse
struct MovieResponse: Decodable {
    let results: [Movie]
}

// MARK: - Result
struct Movie: Decodable, Identifiable {
    let id: Int
    let backdropPath: String?
    let title: String
    let originalTitle, overview: String
    let posterPath: String?
    let popularity: Double?
    let releaseDate: String?
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int?
    
    let genres: [MovieGenre]?
    
    let credits: MovieCredit?
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter ()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter ()
        formatter.unitsStyle = . full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    var genreText: String{
        genres?.first?.name ?? "n/a"
    }
    var ratingText: String{
        let rating = Int(voteAverage)
        let ratingText = (0..<rating).reduce(""){ (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }
    var scoreText: String {
        guard ratingText.count>0 else{
            return "n/a"
        }
        return "\(ratingText.count)/10"
    }
    var yearText: String{
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return Movie.yearFormatter.string(from: date)
    }
    var durationText: String{
        guard let runtime = self.runtime, runtime > 0 else {
            return "n/a"
        }
        return Movie.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }
    
    var cast: [MovieCast]? {
        credits?.cast
    }
    var crew: [MovieCrew]? {
        credits?.crew
    }
    var directors: [MovieCrew]? {
        crew?.filter { $0.job.lowercased () == "director"}
    }
    var producers: [MovieCrew]? {
        crew?.filter { $0.job.lowercased () == "producer"}
    }
    var screenWriters: [MovieCrew]? {
        crew?.filter { $0.job.lowercased () == "story"}
    }
}

struct MovieGenre: Decodable{
    let name: String
    let id: Int
}

struct MovieCredit: Decodable{
    let cast: [MovieCast]
    let crew: [MovieCrew]
}

struct MovieCast: Decodable, Identifiable{
    let id: Int
    let character: String?
    let name: String
}

struct MovieCrew: Decodable, Identifiable{
    let id: Int
    let job: String
    let name: String
}
