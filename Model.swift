//
//  File.swift
//  IOSAssignment
//
//  Created by Srinivasulu Arigela on 22/04/24.
//



import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    var id, title: String?
    var language: Language?
    var thumbnail: Thumbnail?
    var mediaType: Int?
    var coverageURL: String?
    var publishedAt, publishedBy: String?
    var backupDetails: BackupDetails?
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case language
        case thumbnail
        case mediaType
        case coverageURL
        case publishedAt
        case publishedBy
        case backupDetails
    }
    
    init(from decoder: any Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container?.decodeIfPresent(String.self, forKey: .id)
        self.title = try? container?.decodeIfPresent(String.self, forKey: .title)
        self.language = try? container?.decodeIfPresent(Language.self, forKey: .language)
        self.thumbnail = try? container?.decodeIfPresent(Thumbnail.self, forKey: .thumbnail)
        self.mediaType = try? container?.decodeIfPresent(Int.self, forKey: .mediaType)
        self.coverageURL = try? container?.decodeIfPresent(String.self, forKey: .coverageURL)
        self.publishedAt = try? container?.decodeIfPresent(String.self, forKey: .publishedAt)
        self.publishedBy = try? container?.decodeIfPresent(String.self, forKey: .publishedBy)
        self.backupDetails = try? container?.decodeIfPresent(BackupDetails.self, forKey: .backupDetails)
    }
        
}

// MARK: - BackupDetails
struct BackupDetails: Codable {
    
    var pdfLink: String?
    var screenshotURL: String?
    
    enum CodingKeys: CodingKey {
        case pdfLink
        case screenshotURL
    }
    
    init(from decoder: any Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.pdfLink = try? container?.decodeIfPresent(String.self, forKey: .pdfLink)
        self.screenshotURL = try? container?.decodeIfPresent(String.self, forKey: .screenshotURL)
    }
    
}

enum Language: String, Codable {
    case english = "english"
    case hindi = "hindi"
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    
    var id: String?
    var version: Int?
    var domain: String?
    var basePath: String?
    var key: String?
    var qualities: [Int]?
    var aspectRatio: Int?
    
    enum CodingKeys: CodingKey {
        case id
        case version
        case domain
        case basePath
        case key
        case qualities
        case aspectRatio
    }
    
    init(from decoder: any Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container?.decodeIfPresent(String.self, forKey: .id)
        self.version = try? container?.decodeIfPresent(Int.self, forKey: .version)
        self.domain = try? container?.decodeIfPresent(String.self, forKey: .domain)
        self.basePath = try? container?.decodeIfPresent(String.self, forKey: .basePath)
        self.key = try? container?.decodeIfPresent(String.self, forKey: .key)
        self.qualities = try? container?.decodeIfPresent([Int].self, forKey: .qualities)
        self.aspectRatio = try? container?.decodeIfPresent(Int.self, forKey: .aspectRatio)
    }
    
    func imageURL() -> String{
        return "\(domain ?? "")/\(basePath ?? "")/\(key ?? "")"
    }

}
