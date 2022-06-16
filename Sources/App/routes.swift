import Vapor

struct UserResponse: Content {
  let id: Int
  let name: String
}

struct BookResponse: Content {
  let id: UUID
  let userId: Int
  let title: String
}

func routes(_ app: Application) throws {
  
  // /users/:userId
  app.get("users", ":userId") { req -> UserResponse in
    guard
      let userId = req.parameters.get("userId", as: Int.self)
    else {
      struct BadRequest: Error {}
      throw BadRequest()
    }
    return UserResponse(id: userId, name: "minan \(userId)")
  }
  
  app.get("users", ":userId", "books", ":bookId") { req -> BookResponse in
    guard
      let userId = req.parameters.get("userId", as: Int.self),
      let bookId = req.parameters.get("bookId", as: UUID.self)
    else {
      struct BadRequest: Error {}
      throw BadRequest()
    }
    return BookResponse(
      id: bookId,
      userId: userId,
      title: "minan"
    )    
  }
  
  app.get("time") { req -> String in
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
    return dateFormatter.string(from: Date())
  }
}
