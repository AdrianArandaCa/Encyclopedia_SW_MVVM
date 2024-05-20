//
//  GoogleModel.swift
//  Encyclopedia_SW_MVVM
//
//  Created by Dev on 6/4/24.
//

import Foundation

struct GoogleResponsesDataModel: Decodable {
    let kind: String
    let url: URLClass
    let queries: Queries
    let context: Context
    let searchInformation: SearchInformation
    let spelling: Spelling
    let items: [Item]
    
    enum CodingKeys: CodingKey {
        case kind
        case url
        case queries
        case context
        case searchInformation
        case spelling
        case items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decode(String.self, forKey: .kind)
        self.url = try container.decode(URLClass.self, forKey: .url)
        self.queries = try container.decode(Queries.self, forKey: .queries)
        self.context = try container.decode(Context.self, forKey: .context)
        self.searchInformation = try container.decode(SearchInformation.self, forKey: .searchInformation)
        self.spelling = try container.decode(Spelling.self, forKey: .spelling)
        self.items = try container.decode([Item].self, forKey: .items)
    }
}

// MARK: - Context
struct Context: Decodable {
    let title: String
    
    enum CodingKeys: CodingKey {
        case title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
    }
}

// MARK: - Item
struct Item: Decodable {
    let kind: String
    let title, htmlTitle: String
    let link: String
    let displayLink, snippet, htmlSnippet: String
    let mime, fileFormat: String
    let image: ImageInfo
    
    enum CodingKeys: CodingKey {
        case kind
        case title
        case htmlTitle
        case link
        case displayLink
        case snippet
        case htmlSnippet
        case mime
        case fileFormat
        case image
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decode(String.self, forKey: .kind)
        self.title = try container.decode(String.self, forKey: .title)
        self.htmlTitle = try container.decode(String.self, forKey: .htmlTitle)
        self.link = try container.decode(String.self, forKey: .link)
        self.displayLink = try container.decode(String.self, forKey: .displayLink)
        self.snippet = try container.decode(String.self, forKey: .snippet)
        self.htmlSnippet = try container.decode(String.self, forKey: .htmlSnippet)
        self.mime = try container.decode(String.self, forKey: .mime)
        self.fileFormat = try container.decode(String.self, forKey: .fileFormat)
        self.image = try container.decode(ImageInfo.self, forKey: .image)
    }
}

//enum FileFormat: String, Decodable {
//    case image
//    case imageJPEG
//    case imagePNG
//}

// MARK: - Image
struct ImageInfo: Decodable {
    let contextLink: String
    let height, width, byteSize: Double
    let thumbnailLink: String
    let thumbnailHeight, thumbnailWidth: Double
    
    enum CodingKeys: CodingKey {
        case contextLink
        case height
        case width
        case byteSize
        case thumbnailLink
        case thumbnailHeight
        case thumbnailWidth
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.contextLink = try container.decode(String.self, forKey: .contextLink)
        self.height = try container.decode(Double.self, forKey: .height)
        self.width = try container.decode(Double.self, forKey: .width)
        self.byteSize = try container.decode(Double.self, forKey: .byteSize)
        self.thumbnailLink = try container.decode(String.self, forKey: .thumbnailLink)
        self.thumbnailHeight = try container.decode(Double.self, forKey: .thumbnailHeight)
        self.thumbnailWidth = try container.decode(Double.self, forKey: .thumbnailWidth)
    }
}

//enum Kind: String, Decodable {
//    case customsearchResult
//}

// MARK: - Queries
struct Queries: Decodable {
    let request, nextPage: [NextPage]
    
    enum CodingKeys: CodingKey {
        case request
        case nextPage
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.request = try container.decode([NextPage].self, forKey: .request)
        self.nextPage = try container.decode([NextPage].self, forKey: .nextPage)
    }
}

// MARK: - NextPage
struct NextPage: Decodable {
    let title, totalResults, searchTerms: String
    let count, startIndex: Double
    let inputEncoding, outputEncoding, safe, cx: String
    let searchType: String
    
    enum CodingKeys: CodingKey {
        case title
        case totalResults
        case searchTerms
        case count
        case startIndex
        case inputEncoding
        case outputEncoding
        case safe
        case cx
        case searchType
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.totalResults = try container.decode(String.self, forKey: .totalResults)
        self.searchTerms = try container.decode(String.self, forKey: .searchTerms)
        self.count = try container.decode(Double.self, forKey: .count)
        self.startIndex = try container.decode(Double.self, forKey: .startIndex)
        self.inputEncoding = try container.decode(String.self, forKey: .inputEncoding)
        self.outputEncoding = try container.decode(String.self, forKey: .outputEncoding)
        self.safe = try container.decode(String.self, forKey: .safe)
        self.cx = try container.decode(String.self, forKey: .cx)
        self.searchType = try container.decode(String.self, forKey: .searchType)
    }
}

// MARK: - SearchInformation
struct SearchInformation: Decodable {
    let searchTime: Double
    let formattedSearchTime, totalResults, formattedTotalResults: String
    
    enum CodingKeys: CodingKey {
        case searchTime
        case formattedSearchTime
        case totalResults
        case formattedTotalResults
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.searchTime = try container.decode(Double.self, forKey: .searchTime)
        self.formattedSearchTime = try container.decode(String.self, forKey: .formattedSearchTime)
        self.totalResults = try container.decode(String.self, forKey: .totalResults)
        self.formattedTotalResults = try container.decode(String.self, forKey: .formattedTotalResults)
    }
}

// MARK: - Spelling
struct Spelling : Decodable{
    let correctedQuery, htmlCorrectedQuery: String
    
    enum CodingKeys: CodingKey {
        case correctedQuery
        case htmlCorrectedQuery
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.correctedQuery = try container.decode(String.self, forKey: .correctedQuery)
        self.htmlCorrectedQuery = try container.decode(String.self, forKey: .htmlCorrectedQuery)
    }
}

// MARK: - URLClass
struct URLClass: Decodable {
    let type, template: String
    
    enum CodingKeys: CodingKey {
        case type
        case template
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.template = try container.decode(String.self, forKey: .template)
    }
}
