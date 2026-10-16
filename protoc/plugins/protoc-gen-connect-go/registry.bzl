"""GitHub-release catalog for protoc-gen-connect-go.

Selected by `protoc.plugin(name = "protoc-gen-connect-go", version = …)`.
This file is the fetch catalog (URL template + sha256), not the pin.
Unknown version → fail() in plugin_platforms.
"""

NAME = "protoc-gen-connect-go"

# kind `archive`: GitHub-release tar.gz / zip with the binary at the archive root.
PLUGIN = {
    "kind": "archive",
    "name": NAME,
    "url": "https://github.com/connectrpc/connect-go/releases/download/{version}/protoc-gen-connect-go-{version}-{file}",
    "versions": {
        "v1.21.0": {
            "linux_amd64": {
                "bin": "protoc-gen-connect-go",
                "file": "Linux-x86_64.tar.gz",
                "sha256": "26c542ab11b20a04edbbd12b03f770efdf1fcb321f41beaeed143eee27d1c185",
            },
            "linux_arm64": {
                "bin": "protoc-gen-connect-go",
                "file": "Linux-aarch64.tar.gz",
                "sha256": "6d431d50755512ea32f118213ada2b363e284e83209f55136b54927742bd45aa",
            },
            "darwin_amd64": {
                "bin": "protoc-gen-connect-go",
                "file": "Darwin-x86_64.tar.gz",
                "sha256": "e11d8f92bcfeeae00a2601a5d09cbf5cc4db18a8147dda7277d320f27a524dc2",
            },
            "darwin_arm64": {
                "bin": "protoc-gen-connect-go",
                "file": "Darwin-arm64.tar.gz",
                "sha256": "94e6b10f1911b5a8f103c5fef3664f8b398f2dd16168aa647a478728e2abbcaa",
            },
            "windows_amd64": {
                "bin": "protoc-gen-connect-go.exe",
                "file": "Windows-x86_64.zip",
                "sha256": "4a2b125fd5abb8350f2f36f713bc86d84bb7bcfab631f4c16a8718a477d67723",
            },
            "windows_arm64": {
                "bin": "protoc-gen-connect-go.exe",
                "file": "Windows-arm64.zip",
                "sha256": "ddebd2ab81fbfd039d3643e5dabe39d16b67c8fc38e8ae16542b37b09842ef84",
            },
        },
        "v1.21.1": {
            "linux_amd64": {
                "bin": "protoc-gen-connect-go",
                "file": "Linux-x86_64.tar.gz",
                "sha256": "5c34eedc4ee9970a6349c69d494fbeff650a4b3e411a63cc52304eec3f16aef8",
            },
            "linux_arm64": {
                "bin": "protoc-gen-connect-go",
                "file": "Linux-aarch64.tar.gz",
                "sha256": "11fda185a7dcebc5ac5b0838ec96ff143cc2a67b76c7d0f74479c98bb69cff4b",
            },
            "darwin_amd64": {
                "bin": "protoc-gen-connect-go",
                "file": "Darwin-x86_64.tar.gz",
                "sha256": "fb205d8c9f661b0b4d4c1062402b67c115beedc544ac489e526a5971b93801bc",
            },
            "darwin_arm64": {
                "bin": "protoc-gen-connect-go",
                "file": "Darwin-arm64.tar.gz",
                "sha256": "ea7d230e13d9b48e0c5b9903fdf1dad04a2940e07fdf15821b0daf23d8740cbb",
            },
            "windows_amd64": {
                "bin": "protoc-gen-connect-go.exe",
                "file": "Windows-x86_64.zip",
                "sha256": "668771bbfd04859a62773d9926c8defa4939b8cf8bb475d8d0a431af091beb02",
            },
            "windows_arm64": {
                "bin": "protoc-gen-connect-go.exe",
                "file": "Windows-arm64.zip",
                "sha256": "c195dc645d21d4b69243596d1e6b22655fd55296326621217bdba3a2c267b69a",
            },
        },
        "v2.0.0": {
            "linux_amd64": {
                "bin": "protoc-gen-connect-go",
                "file": "Linux-x86_64.tar.gz",
                "sha256": "04a991c25c0943a65365e16fc409b2e6e8f1a89c469114939dfd2a113c0f9630",
            },
            "linux_arm64": {
                "bin": "protoc-gen-connect-go",
                "file": "Linux-aarch64.tar.gz",
                "sha256": "1e0c80392e8a92925970186936c41285fb387a6d635238243931c5a9b23d5861",
            },
            "darwin_amd64": {
                "bin": "protoc-gen-connect-go",
                "file": "Darwin-x86_64.tar.gz",
                "sha256": "349efe4603f08a812ebffb4b24755562eb4e2c3019bc509c4a020302a8ac3223",
            },
            "darwin_arm64": {
                "bin": "protoc-gen-connect-go",
                "file": "Darwin-arm64.tar.gz",
                "sha256": "3f7202b6994fafc87b29ce3ddd8c2d133f0e9a284baa90235cb6f692ece53d8e",
            },
            "windows_amd64": {
                "bin": "protoc-gen-connect-go.exe",
                "file": "Windows-x86_64.zip",
                "sha256": "fd126e7ff8f0875cf2bfc6f61ce510fa7dadb35a59796504f07b98c8aa970abe",
            },
            "windows_arm64": {
                "bin": "protoc-gen-connect-go.exe",
                "file": "Windows-arm64.zip",
                "sha256": "089f592bbce29e932d65b2d951d340a8798a5b0fca0c81eb857bfc16c41213d0",
            },
        },
        "v2.0.1": {
            "linux_amd64": {
                "bin": "protoc-gen-connect-go",
                "file": "Linux-x86_64.tar.gz",
                "sha256": "35bcf3feb82d29aaef8a40aae87e6a5738fbfc684e727e13e481428726c6b6b7",
            },
            "linux_arm64": {
                "bin": "protoc-gen-connect-go",
                "file": "Linux-aarch64.tar.gz",
                "sha256": "d4807adcd979bc6b41cc929de3de4b5a808001805937bd94c3713251b0a40cf7",
            },
            "darwin_amd64": {
                "bin": "protoc-gen-connect-go",
                "file": "Darwin-x86_64.tar.gz",
                "sha256": "283f0a8dfc07021c88a3511536fe0e92ff10ca328e40fafacbd911230c70fd5e",
            },
            "darwin_arm64": {
                "bin": "protoc-gen-connect-go",
                "file": "Darwin-arm64.tar.gz",
                "sha256": "0ad1d58b1c8097cc6d38e91dee8a724f356f014dce96107d52bc75ed7234755e",
            },
            "windows_amd64": {
                "bin": "protoc-gen-connect-go.exe",
                "file": "Windows-x86_64.zip",
                "sha256": "506f76f531b0293882f302213e8bc7164aa7bf606d1712974d6c6b33cba0c38b",
            },
            "windows_arm64": {
                "bin": "protoc-gen-connect-go.exe",
                "file": "Windows-arm64.zip",
                "sha256": "a634b0dc8aa9f6210c3cecd5f4ef034546d9a76961204d75c13fe9158092e3da",
            },
        },
    },
}
