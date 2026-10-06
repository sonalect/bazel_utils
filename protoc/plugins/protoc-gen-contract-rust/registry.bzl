"""GitHub-release catalog for protoc-gen-contract-rust.

Selected by `protoc.plugin(name = "protoc-gen-contract-rust", version = …)`.
This file is the fetch catalog (URL template + sha256), not the pin.
Unknown version → fail() in plugin_platforms.
"""

NAME = "protoc-gen-contract-rust"

# kind `file`: raw GitHub release binary, static per platform; the sha256
# of each comes from the release's checksums-sha256.txt.
PLUGIN = {
    "kind": "file",
    "name": NAME,
    "url": "https://github.com/sonalect/protoc-gen-contract-rust/releases/download/{version}/protoc-gen-contract-rust-{version}-{file}",
    "versions": {
        "v0.1.0": {
            "linux_amd64": {
                "bin": "protoc-gen-contract-rust",
                "file": "linux-x86_64",
                "sha256": "baa9229690db2b883de40509156e75138c4b638433e560d3284258d242ce88b9",
            },
            "linux_arm64": {
                "bin": "protoc-gen-contract-rust",
                "file": "linux-aarch64",
                "sha256": "e6f318ca610eba2102adce3c74b36cd61117721769096cbd67f3e8292a482f94",
            },
            "darwin_amd64": {
                "bin": "protoc-gen-contract-rust",
                "file": "darwin-x86_64",
                "sha256": "23ec7a3d2d640513702eec45e09983c0ee7ddd0ce5e8b527adad6da2b24be589",
            },
            "darwin_arm64": {
                "bin": "protoc-gen-contract-rust",
                "file": "darwin-aarch64",
                "sha256": "3feecd1457ebb086daa2660a5a68fa648764f0c07ccd4cf63c43897203d69186",
            },
            "windows_amd64": {
                "bin": "protoc-gen-contract-rust.exe",
                "file": "windows-x86_64.exe",
                "sha256": "5e86f9e1c99919b991391d942502da066273049b7b36b9340a375b1cdd23e133",
            },
            "windows_arm64": {
                "bin": "protoc-gen-contract-rust.exe",
                "file": "windows-aarch64.exe",
                "sha256": "f667db5d6d84c724831e7cacbc0df04b1392e287f681c784f169dd7b0d21c40d",
            },
        },
    },
}
