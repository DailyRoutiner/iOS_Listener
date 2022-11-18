//
//  Book+Codable.swift
//  Listener
//
//  Created by Dongpeng Dai on 2022/8/12.
//

import Foundation
import CoreData

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}

@objc(Book)
class Book: NSManagedObject, Codable {
    private enum CodingKeys: String, CodingKey { case audio, author, detail, id, image, isLiked, name }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(audio, forKey: .audio)
        try container.encode(author, forKey: .author)
        try container.encode(detail, forKey: .detail)
        try container.encode(id, forKey: .id)
        try container.encode(image, forKey: .image)
        try container.encode(isLiked, forKey: .isLiked)
        try container.encode(name, forKey: .name)
    }
    
    required convenience public init(from decoder: Decoder) throws {
    guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
          throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.audio = try? container.decode(String.self, forKey: .audio)
        self.author = try? container.decode(String.self, forKey: .author)
        self.detail = try? container.decode(String.self, forKey: .detail)
        self.id = try? container.decode(UUID.self, forKey: .id)
        self.image = try? container.decode(String.self, forKey: .image)
        self.isLiked = try container.decode(Bool.self, forKey: .isLiked)
        self.name = try? container.decode(String.self, forKey: .name)
    }
}
