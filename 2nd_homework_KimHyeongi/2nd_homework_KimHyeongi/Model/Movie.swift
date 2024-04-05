//
//  Movie.swift
//  2nd_homework_KimHyeongi
//
//  Created by 김현기 on 4/2/24.
//

import Foundation

struct TrendingMoviesResponse: Codable {
    let results: [Movie]
}

struct PopularMoviesResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String?
    let poster_path: String?
}

/*
 {
     adult = 0;
     "backdrop_path" = "/sR0SpCrXamlIkYMdfz83sFn5JS6.jpg";
     "genre_ids" =             (
      28,
      878,
      12
     );
     id = 823464;
     "media_type" = movie;
     "original_language" = en;
     "original_title" = "Godzilla x Kong: The New Empire";
     overview = "Following their explosive showdown, Godzilla and Kong must reunite against a colossal undiscovered threat hidden within our world, challenging their very existence \U2013 and our own.";
     popularity = "5072.084";
     "poster_path" = "/gmGK5Gw5CIGMPhOmTO0bNA9Q66c.jpg";
     "release_date" = "2024-03-27";
     title = "Godzilla x Kong: The New Empire";
     video = 0;
     "vote_average" = "7.091";
     "vote_count" = 231;
 },
  */
