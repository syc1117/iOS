//: [Previous](@previous)
/*
 싱글톤 방식으로 해보기 전에
 아래에 주어진 코드를 이용해 User에 친구 추가하기
 싱글턴 사용하지 말고 풀것
 스트럭트 안에 init을 추가
 */

class User {
static let shared = User()
  var friends: [Friends] = []
  var blocks: [Friends] = []
}



struct Friends: Equatable {
  let name: String
    
    init (name: String) {
        self.name = name
    }
}

/*
 ↑ User와 Friends 타입은 수정 금지
 ↓ FriendList 타입은 수정 허용
 */

class FriendList {
  func addFriend(name: String) {
    user.friends.append(Friends(name: name))
  }
  
  func blockFriend(name: String) {
    if let index = user.friends.firstIndex(of: Friends(name: name)) {
    user.friends.remove(at: index)
    } else { return }
    user.blocks.append(Friends(name: name))
    
    // 호출 시 해당 이름의 친구를 blocks 배열에 추가
    // 만약 friends 배열에 포함된 친구라면 friends 배열에서 제거
  }
}
let user = User.shared

//


var friendList = FriendList()
friendList.addFriend(name: "원빈")
friendList.addFriend(name: "장동건")
friendList.addFriend(name: "정우성")
user.friends   // 원빈, 장동건, 정우성

friendList.blockFriend(name: "정우성")
user.friends   // 원빈, 장동건
user.blocks    // 정우성


//: [Next](@next)
