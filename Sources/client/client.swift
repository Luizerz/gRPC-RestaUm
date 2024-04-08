//
//  File.swift
//
//
//  Created by Luiz Sena on 04/04/24.
//

import ArgumentParser
import Foundation
import GRPC
import NIOCore
import NIOPosix

@main
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
struct RouteGuide: AsyncParsableCommand {
    @Option(help: "The port to connect to")
    var port: Int = 1234

    func run() async throws {
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        defer {
            try? group.syncShutdownGracefully()
        }

        let channel = try GRPCChannelPool.with(
            target: .host("localhost", port: port),
            transportSecurity: .plaintext,
            eventLoopGroup: group
        )

        let messageService = MyProto_MessageServiceAsyncClient(channel: channel)
        Task {
            for try await message in messageService.updateMessages(MyProto_User()) {

            }
        }

        while true {sleep(1)}

    }
}
