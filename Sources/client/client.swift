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
        let myActor = MyCustomActor()
        Task {
            try await testPourpose(messageService, actor: myActor)
        }
        Task {
            while await !myActor.myTurn {
                sleep(2)
                print("Ator falso")
            }
            print("Ator verdadeiro")
        }
        while true { usleep(1000) }
    }

    func testPourpose(_ service: MyProto_MessageServiceAsyncClient, actor: MyCustomActor) async throws {
        let user = try await service.connect(MyProto_Empty())
        Task {
            for try await response in service.updateSessionStatus(user) {
                print("updateSessionStatus: ", response.gameStarted)
                await actor.setMyTurn(response.gameStarted)
            }
            for try await response in service.updateTurn(user) {

            }
        }

    }
}

actor MyCustomActor {
    var myTurn: Bool = false


    func setMyTurn(_ entry: Bool) {
        myTurn = entry
    }
}
