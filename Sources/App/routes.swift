import Vapor

struct UserResponse: Content {
  let id: Int
  let name: String
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
  
  app.get("time") { req -> String in
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
    return dateFormatter.string(from: Date())
  }
}
