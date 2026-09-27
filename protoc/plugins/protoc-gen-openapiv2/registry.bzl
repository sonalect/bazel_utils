"""GitHub-release catalog for protoc-gen-openapiv2.

Selected by `protoc.plugin(name = "protoc-gen-openapiv2", version = …)`.
This file is the fetch catalog (URL template + sha256), not the pin.
Unknown version → fail() in plugin_platforms.
"""

NAME = "protoc-gen-openapiv2"

# kind `file`: raw GitHub release binary.
PLUGIN = {
    "kind": "file",
    "name": NAME,
    "url": "https://github.com/grpc-ecosystem/grpc-gateway/releases/download/{version}/protoc-gen-openapiv2-{version}-{file}",
    "versions": {
        "v2.30.0": {
            "linux_amd64": {
                "bin": "protoc-gen-openapiv2",
                "file": "linux-x86_64",
                "sha256": "79fc245bcaf02d75a85934cf11035688de11191110e3b30b7a1859cc9492ca13",
            },
            "linux_arm64": {
                "bin": "protoc-gen-openapiv2",
                "file": "linux-arm64",
                "sha256": "9e96450bed8db2d1c98e93eb745e5d31b4fe9474549e4ab8cb598b239f2e18b1",
            },
            "darwin_amd64": {
                "bin": "protoc-gen-openapiv2",
                "file": "darwin-x86_64",
                "sha256": "2e769cd25a3a245dc3316035034561dce4f18500452c33ee2da364295777fab3",
            },
            "darwin_arm64": {
                "bin": "protoc-gen-openapiv2",
                "file": "darwin-arm64",
                "sha256": "72ad8630aa700d05362dcf0f078f0d8b6b0a366d449fd183b49a8d56555340f2",
            },
            "windows_amd64": {
                "bin": "protoc-gen-openapiv2.exe",
                "file": "windows-x86_64.exe",
                "sha256": "1fc47475877f898a82ccaffad448d4ce09bf215a5584dadf40fa0dcd200e7dbd",
            },
            "windows_arm64": {
                "bin": "protoc-gen-openapiv2.exe",
                "file": "windows-arm64.exe",
                "sha256": "94cd2b115ad4ebdd37442c0685df5901c8b217dfc0746c19865ff03687376bc7",
            },
        },
        "v2.31.0": {
            "linux_amd64": {
                "bin": "protoc-gen-openapiv2",
                "file": "linux-x86_64",
                "sha256": "a05f17a2a934692cc9d0b46a5a597f23cf2f1e34c76e0a457943aa5afffa33ba",
            },
            "linux_arm64": {
                "bin": "protoc-gen-openapiv2",
                "file": "linux-arm64",
                "sha256": "6240a03543695ed7dfad404765cc681c7bcc7760773c479d37cdd80f7840e000",
            },
            "darwin_amd64": {
                "bin": "protoc-gen-openapiv2",
                "file": "darwin-x86_64",
                "sha256": "17789024c0aad0aafe0a2acb129e662480158ec6c0c69f54469789ab4395030b",
            },
            "darwin_arm64": {
                "bin": "protoc-gen-openapiv2",
                "file": "darwin-arm64",
                "sha256": "3a614829c9266717c0018b736f8f113c43880e579a5e1530081a9ca126071db9",
            },
            "windows_amd64": {
                "bin": "protoc-gen-openapiv2.exe",
                "file": "windows-x86_64.exe",
                "sha256": "214ecb46f982f3c8f1ac07ded35ea01ef87ca4a53e018ea9832f9e67b999ceac",
            },
            "windows_arm64": {
                "bin": "protoc-gen-openapiv2.exe",
                "file": "windows-arm64.exe",
                "sha256": "41d56ea81d2f3abd6f02075fbab3a0020389d6d289925745ebf45f8a0841265b",
            },
        },
    },
}
