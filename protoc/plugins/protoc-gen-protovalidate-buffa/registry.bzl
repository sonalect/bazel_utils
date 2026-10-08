"""GitHub-release catalog for protoc-gen-protovalidate-buffa.

Selected by `protoc.plugin(name = "protoc-gen-protovalidate-buffa", version = …)`.
This file is the fetch catalog (URL template + sha256), not the pin.
Unknown version → fail() in plugin_platforms.
"""

NAME = "protoc-gen-protovalidate-buffa"

# kind `archive`: cargo-dist tar.gz / zip with the binary at the archive root.
PLUGIN = {
    "kind": "archive",
    "name": NAME,
    "url": "https://github.com/mathematic-inc/protovalidate-buffa/releases/download/protoc-gen-protovalidate-buffa-{version}/protoc-gen-protovalidate-buffa-{version_bare}-{file}",
    "versions": {
        "v0.10.0": {
            "linux_amd64": {
                "bin": "protoc-gen-protovalidate-buffa",
                "file": "x86_64-unknown-linux-gnu.tar.gz",
                "sha256": "81023bfde8c991023c163839f6ef713068cd49f651c2bf8e82d746be7ee806c1",
            },
            "linux_arm64": {
                "bin": "protoc-gen-protovalidate-buffa",
                "file": "aarch64-unknown-linux-gnu.tar.gz",
                "sha256": "f16ee891c298461e87844dd575f9f95506a4008d9ab6f01dc3737eb8e858e22d",
            },
            "darwin_amd64": {
                "bin": "protoc-gen-protovalidate-buffa",
                "file": "x86_64-apple-darwin.tar.gz",
                "sha256": "9bab6e5aa85b012e69eb30fdbec62cf1f637e309458cab2e2aad6bc03c8e5792",
            },
            "darwin_arm64": {
                "bin": "protoc-gen-protovalidate-buffa",
                "file": "aarch64-apple-darwin.tar.gz",
                "sha256": "2bbd6158c2de84b3eb46cb11a0b0600b00ff47957b95554127c18cb5b42361ed",
            },
            "windows_amd64": {
                "bin": "protoc-gen-protovalidate-buffa.exe",
                "file": "x86_64-pc-windows-msvc.zip",
                "sha256": "ead34f6f275ab1a488042bda2d41cbe7150254bcddd76f905cc1aece189d135b",
            },
            "windows_arm64": {
                "bin": "protoc-gen-protovalidate-buffa.exe",
                "file": "aarch64-pc-windows-msvc.zip",
                "sha256": "a0f4057b44aa2588b534e26bd770124c9109c705e2f931d7675af1560bc14827",
            },
        },
        "v0.10.1": {
            "linux_amd64": {
                "bin": "protoc-gen-protovalidate-buffa",
                "file": "x86_64-unknown-linux-gnu.tar.gz",
                "sha256": "12393c525bd6e53b99ef45c7e3ba269e41eefb9bfb0691a1b248eb8af6adcf6d",
            },
            "linux_arm64": {
                "bin": "protoc-gen-protovalidate-buffa",
                "file": "aarch64-unknown-linux-gnu.tar.gz",
                "sha256": "97db7eda61dd8680ff2070d5a88e4838c6878076ca73a27e344477bc8026fe12",
            },
            "darwin_amd64": {
                "bin": "protoc-gen-protovalidate-buffa",
                "file": "x86_64-apple-darwin.tar.gz",
                "sha256": "af4d2a3829855faf0a394b13fa935576416f854bda2cf1393ae7f15c288681d4",
            },
            "darwin_arm64": {
                "bin": "protoc-gen-protovalidate-buffa",
                "file": "aarch64-apple-darwin.tar.gz",
                "sha256": "ed8b600d893aa41cf8ce1f912a5aa29ba4576de7a763f1eca974fd4b3fb9dc22",
            },
            "windows_amd64": {
                "bin": "protoc-gen-protovalidate-buffa.exe",
                "file": "x86_64-pc-windows-msvc.zip",
                "sha256": "073fa121fb6704b34338da8939002fa518b24fc0ee7917e8e5780c25815fb3f8",
            },
            "windows_arm64": {
                "bin": "protoc-gen-protovalidate-buffa.exe",
                "file": "aarch64-pc-windows-msvc.zip",
                "sha256": "a6f2b8109cfa9b9cd33cb7143213c649c7b73175153c2e17995e04b74cb28e03",
            },
        },
        "v0.10.2": {
            "linux_amd64": {
                "bin": "protoc-gen-protovalidate-buffa",
                "file": "x86_64-unknown-linux-gnu.tar.gz",
                "sha256": "e709fe8c52c6e5fb32c6d2c14f4ed784c1c209b80ea9f90bdcdc318f303ac0ce",
            },
            "linux_arm64": {
                "bin": "protoc-gen-protovalidate-buffa",
                "file": "aarch64-unknown-linux-gnu.tar.gz",
                "sha256": "3db5ca1c7977a123a29f52016e00e1632fea54d37ad681ebb51905daa4a3fe37",
            },
            "darwin_amd64": {
                "bin": "protoc-gen-protovalidate-buffa",
                "file": "x86_64-apple-darwin.tar.gz",
                "sha256": "efd2f63f440e32c23bc28b053e0f272e55b5bf5be9e909c3610c9729bf6241ab",
            },
            "darwin_arm64": {
                "bin": "protoc-gen-protovalidate-buffa",
                "file": "aarch64-apple-darwin.tar.gz",
                "sha256": "a005b34525749236ea3030806c0083430eca9b9faf414406db6aee98121b7864",
            },
            "windows_amd64": {
                "bin": "protoc-gen-protovalidate-buffa.exe",
                "file": "x86_64-pc-windows-msvc.zip",
                "sha256": "a8d71929ed8e2c8a0e5a272ac3dd3618edb2c049fc7bdf63849f566be0587fa2",
            },
            "windows_arm64": {
                "bin": "protoc-gen-protovalidate-buffa.exe",
                "file": "aarch64-pc-windows-msvc.zip",
                "sha256": "3efdd9fc97e0dcfef80a8f31563b5e4813675b85dcfc662b37d1d0cd6d0d156b",
            },
        },
    },
}
