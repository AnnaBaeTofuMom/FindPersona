import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// MARK: - Project

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

let project = Project(
    name: "FindPersona",
    organizationName: "MyOrg",
    targets: [
        Target(
            name: "FindPersona",
            platform: .iOS,
            product: .app,
            bundleId: "io.JDman.FindPersona", // 경원님 번들아이디 변경 필요
            infoPlist: "Info.plist",
            sources: [
              "Manager/**",
              "Model/**",
              "Util/**",
              "App/**",
              "Builder/**",
              "View/**",
              "ViewModel/**"
            ],
            resources: ["Resources/**"]
        ),
//        Target(
//            name: "FindPersonaTests",
//            platform: .iOS,
//            product: .unitTests,
//            bundleId: "io.JDman.FindPersona",
//            infoPlist: "Info.plist",
//            sources: ["Tests/**"],
//            dependencies: [
//                .target(name: "FindPersona")
//            ]
//        )
    ]
)
