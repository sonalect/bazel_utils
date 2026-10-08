"""GitHub-release catalog for protoc-gen-connect-rust.

Selected by `protoc.plugin(name = "protoc-gen-connect-rust", version = …)`.
This file is the fetch catalog (URL template + sha256), not the pin.
Unknown version → fail() in plugin_platforms.
"""

NAME = "protoc-gen-connect-rust"

# kind `file`: raw GitHub release binary.
PLUGIN = {
    "kind": "file",
    "name": NAME,
    "url": "https://github.com/connectrpc/connect-rust/releases/download/{version}/protoc-gen-connect-rust-{version}-{file}",
    "versions": {
        "v0.9.0": {
            "linux_amd64": {
                "bin": "protoc-gen-connect-rust",
                "file": "linux-x86_64",
                "sha256": "41c342e7589cbf05bec0e0a98d45ef23e01f514eb30ca7b73ac6d8cd054c7a4e",
            },
            "linux_arm64": {
                "bin": "protoc-gen-connect-rust",
                "file": "linux-aarch64",
                "sha256": "d91fd99afd2406db87f4bb90e86eb7bd5814f2ee69dc40a5932d31978fd2a1f8",
            },
            "darwin_amd64": {
                "bin": "protoc-gen-connect-rust",
                "file": "darwin-x86_64",
                "sha256": "8c24ae17bf27d7bb4c1a6b7f0ac2f6f267930fe7955f7f2271e768126ae54e3a",
            },
            "darwin_arm64": {
                "bin": "protoc-gen-connect-rust",
                "file": "darwin-aarch64",
                "sha256": "269ea76c84a63677a5a42c6aeb1537edafa91267096dafce164994f097de22f9",
            },
            "windows_amd64": {
                "bin": "protoc-gen-connect-rust.exe",
                "file": "windows-x86_64.exe",
                "sha256": "cfb22284fe46063203b50d096a8829d364d0cbafce5f80dd1903da0734ec56f3",
            },
            # No aarch64 asset upstream: Windows 11 on ARM runs the x64 build
            # under emulation.
            "windows_arm64": {
                "bin": "protoc-gen-connect-rust.exe",
                "file": "windows-x86_64.exe",
                "sha256": "cfb22284fe46063203b50d096a8829d364d0cbafce5f80dd1903da0734ec56f3",
            },
        },
        "v0.9.1": {
            "linux_amd64": {
                "bin": "protoc-gen-connect-rust",
                "file": "linux-x86_64",
                "sha256": "580c2a0690b9ad48364bd455cf0b7f8f0153bcbffe85140dd2ce07bfc0b1da24",
            },
            "linux_arm64": {
                "bin": "protoc-gen-connect-rust",
                "file": "linux-aarch64",
                "sha256": "c945e5c2755d24d5fb81cc3bc9f00a2ca4778d4d687d598d9c84e6256067d685",
            },
            "darwin_amd64": {
                "bin": "protoc-gen-connect-rust",
                "file": "darwin-x86_64",
                "sha256": "29437af4528c8e1ac00e9ec2079e2ffa588f17be74dceaa9664a356ffbd82516",
            },
            "darwin_arm64": {
                "bin": "protoc-gen-connect-rust",
                "file": "darwin-aarch64",
                "sha256": "8efc5fcce492d9e9e4bc540bfefc9b7651c7b6780ba9b833d22dbd2358c7286c",
            },
            "windows_amd64": {
                "bin": "protoc-gen-connect-rust.exe",
                "file": "windows-x86_64.exe",
                "sha256": "5887b8f240a48d8009e868dbe08096b5a73e343d9140979e1bc844d7b49e3e0e",
            },
            # No aarch64 asset upstream: Windows 11 on ARM runs the x64 build
            # under emulation.
            "windows_arm64": {
                "bin": "protoc-gen-connect-rust.exe",
                "file": "windows-x86_64.exe",
                "sha256": "5887b8f240a48d8009e868dbe08096b5a73e343d9140979e1bc844d7b49e3e0e",
            },
        },
    },
}
