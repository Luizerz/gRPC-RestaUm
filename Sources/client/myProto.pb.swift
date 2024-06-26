// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: myProto.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

enum MyProto_PlayDirection: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case right // = 0
  case left // = 1
  case top // = 2
  case bottom // = 3
  case UNRECOGNIZED(Int)

  init() {
    self = .right
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .right
    case 1: self = .left
    case 2: self = .top
    case 3: self = .bottom
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .right: return 0
    case .left: return 1
    case .top: return 2
    case .bottom: return 3
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension MyProto_PlayDirection: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static let allCases: [MyProto_PlayDirection] = [
    .right,
    .left,
    .top,
    .bottom,
  ]
}

#endif  // swift(>=4.2)

enum MyProto_BoardValue: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case on // = 0
  case off // = 1
  case null // = 2
  case UNRECOGNIZED(Int)

  init() {
    self = .on
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .on
    case 1: self = .off
    case 2: self = .null
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .on: return 0
    case .off: return 1
    case .null: return 2
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension MyProto_BoardValue: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static let allCases: [MyProto_BoardValue] = [
    .on,
    .off,
    .null,
  ]
}

#endif  // swift(>=4.2)

struct MyProto_Empty {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct MyProto_User {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var id: String = String()

  var name: String = String()

  var isYourTurn: Bool = false

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct MyProto_Message {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var user: MyProto_User {
    get {return _user ?? MyProto_User()}
    set {_user = newValue}
  }
  /// Returns true if `user` has been explicitly set.
  var hasUser: Bool {return self._user != nil}
  /// Clears the value of `user`. Subsequent reads from it will return its default value.
  mutating func clearUser() {self._user = nil}

  var text: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _user: MyProto_User? = nil
}

struct MyProto_SessionStatus {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var gameStarted: Bool = false

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct MyProto_Play {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var row: Int32 = 0

  var column: Int32 = 0

  var direction: MyProto_PlayDirection = .right

  var user: MyProto_User {
    get {return _user ?? MyProto_User()}
    set {_user = newValue}
  }
  /// Returns true if `user` has been explicitly set.
  var hasUser: Bool {return self._user != nil}
  /// Clears the value of `user`. Subsequent reads from it will return its default value.
  mutating func clearUser() {self._user = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _user: MyProto_User? = nil
}

struct MyProto_Board {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var rows: [MyProto_BoardColumn] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct MyProto_BoardColumn {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var columns: [MyProto_BoardValue] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

#if swift(>=5.5) && canImport(_Concurrency)
extension MyProto_PlayDirection: @unchecked Sendable {}
extension MyProto_BoardValue: @unchecked Sendable {}
extension MyProto_Empty: @unchecked Sendable {}
extension MyProto_User: @unchecked Sendable {}
extension MyProto_Message: @unchecked Sendable {}
extension MyProto_SessionStatus: @unchecked Sendable {}
extension MyProto_Play: @unchecked Sendable {}
extension MyProto_Board: @unchecked Sendable {}
extension MyProto_BoardColumn: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "myProto"

extension MyProto_PlayDirection: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "right"),
    1: .same(proto: "left"),
    2: .same(proto: "top"),
    3: .same(proto: "bottom"),
  ]
}

extension MyProto_BoardValue: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "on"),
    1: .same(proto: "off"),
    2: .same(proto: "null"),
  ]
}

extension MyProto_Empty: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Empty"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: MyProto_Empty, rhs: MyProto_Empty) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension MyProto_User: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".User"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "name"),
    3: .same(proto: "isYourTurn"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.id) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.name) }()
      case 3: try { try decoder.decodeSingularBoolField(value: &self.isYourTurn) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.id.isEmpty {
      try visitor.visitSingularStringField(value: self.id, fieldNumber: 1)
    }
    if !self.name.isEmpty {
      try visitor.visitSingularStringField(value: self.name, fieldNumber: 2)
    }
    if self.isYourTurn != false {
      try visitor.visitSingularBoolField(value: self.isYourTurn, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: MyProto_User, rhs: MyProto_User) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.name != rhs.name {return false}
    if lhs.isYourTurn != rhs.isYourTurn {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension MyProto_Message: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Message"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "user"),
    2: .same(proto: "text"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._user) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.text) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._user {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    if !self.text.isEmpty {
      try visitor.visitSingularStringField(value: self.text, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: MyProto_Message, rhs: MyProto_Message) -> Bool {
    if lhs._user != rhs._user {return false}
    if lhs.text != rhs.text {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension MyProto_SessionStatus: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".SessionStatus"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "gameStarted"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBoolField(value: &self.gameStarted) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.gameStarted != false {
      try visitor.visitSingularBoolField(value: self.gameStarted, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: MyProto_SessionStatus, rhs: MyProto_SessionStatus) -> Bool {
    if lhs.gameStarted != rhs.gameStarted {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension MyProto_Play: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Play"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "row"),
    2: .same(proto: "column"),
    3: .same(proto: "direction"),
    4: .same(proto: "user"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt32Field(value: &self.row) }()
      case 2: try { try decoder.decodeSingularInt32Field(value: &self.column) }()
      case 3: try { try decoder.decodeSingularEnumField(value: &self.direction) }()
      case 4: try { try decoder.decodeSingularMessageField(value: &self._user) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if self.row != 0 {
      try visitor.visitSingularInt32Field(value: self.row, fieldNumber: 1)
    }
    if self.column != 0 {
      try visitor.visitSingularInt32Field(value: self.column, fieldNumber: 2)
    }
    if self.direction != .right {
      try visitor.visitSingularEnumField(value: self.direction, fieldNumber: 3)
    }
    try { if let v = self._user {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: MyProto_Play, rhs: MyProto_Play) -> Bool {
    if lhs.row != rhs.row {return false}
    if lhs.column != rhs.column {return false}
    if lhs.direction != rhs.direction {return false}
    if lhs._user != rhs._user {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension MyProto_Board: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Board"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "rows"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedMessageField(value: &self.rows) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.rows.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.rows, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: MyProto_Board, rhs: MyProto_Board) -> Bool {
    if lhs.rows != rhs.rows {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension MyProto_BoardColumn: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".BoardColumn"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "columns"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedEnumField(value: &self.columns) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.columns.isEmpty {
      try visitor.visitPackedEnumField(value: self.columns, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: MyProto_BoardColumn, rhs: MyProto_BoardColumn) -> Bool {
    if lhs.columns != rhs.columns {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
