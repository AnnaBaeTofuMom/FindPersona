import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// MARK: - Project

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

let RswiftPreTargetScript = TargetScript.pre(path: "ShellScript/RswiftScript.sh",
                                             arguments: [],
                                             name: "Rswift Generate",
                                             inputPaths: [
                                              Path(stringLiteral: "$TEMP_DIR/rswift-lastrun")
                                             ],
                                             outputPaths: [
                                              Path(stringLiteral: "$SRCROOT/Resources/R.generated.swift")
                                             ],
                                             basedOnDependencyAnalysis: false,
                                             runForInstallBuildsOnly: false)

// 기본제공 plist 생성후 기존 가지고 있던 plist에 없는 부분 복붙필요
let infoPlist = InfoPlist.file(path: "plist/Info.plist")

let appTarget = Target(name: "FindPersona",
                       platform: .iOS,
                       product: .app,
                       productName: nil,
                       bundleId: "com.JDman.FindPersona",
                       deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
                       infoPlist: infoPlist,
                       sources:  [
                        "Manager/**",
                        "Model/**",
                        "Util/**",
                        "App/**",
                        "Builder/**",
                        "View/**",
                        "ViewModel/**",
                        "Generated/**"
                       ],
                       resources: ["Resources/**"],
                       copyFiles: nil,
                       headers: nil,
                       entitlements: nil,
                       scripts: [
                        RswiftPreTargetScript
                       ],
                       dependencies: [],
                       settings: nil,
                       coreDataModels: [],
                       environment: [:],
                       launchArguments: [],
                       additionalFiles: [])

let project = Project(name: "FindPersona",
                      settings: nil, // xcconfig 설정부분
                      targets: [
                        appTarget
                      ],
                      schemes: [])
