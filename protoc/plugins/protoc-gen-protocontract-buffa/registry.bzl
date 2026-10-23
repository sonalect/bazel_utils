"""GitHub-release catalog for protoc-gen-protocontract-buffa.

Selected by `protoc.plugin(name = "protoc-gen-protocontract-buffa", version = …)`.
This file is the fetch catalog (URL template + sha256), not the pin.
Unknown version → fail() in plugin_platforms.

The crates on crates.io (`protocontract`, `protoc-gen-protocontract-buffa`)
are source only; the prebuilt binaries come from the project's GitHub
Releases.
"""

NAME = "protoc-gen-protocontract-buffa"

# kind `file`: raw GitHub release binary, static per platform; the sha256
# of each comes from the release's checksums-sha256.txt.
PLUGIN = {
    "kind": "file",
    "name": NAME,
    "url": "https://github.com/sonalect/protocontract-buffa.rs/releases/download/{version}/protoc-gen-protocontract-buffa-{version}-{file}",
    "versions": {
        "v0.3.1": {
            "linux_amd64": {
                "bin": "protoc-gen-protocontract-buffa",
                "file": "linux-x86_64",
                "sha256": "acda39630af9aefdc7db6714255a9779f8a2c364eddb9aed32b72dd06be161cf",
            },
            "linux_arm64": {
                "bin": "protoc-gen-protocontract-buffa",
                "file": "linux-aarch64",
                "sha256": "3ecd5bb5bc7371cd59f8f7fe1e39d5f760180b6cabb9405b0e9523fb6720b7af",
            },
            "darwin_amd64": {
                "bin": "protoc-gen-protocontract-buffa",
                "file": "darwin-x86_64",
                "sha256": "53a5588994251cd3f5e759c0753b00ccbfe80d46e0e6de850cfd0845f1ee4f04",
            },
            "darwin_arm64": {
                "bin": "protoc-gen-protocontract-buffa",
                "file": "darwin-aarch64",
                "sha256": "ebeb0f151d95743d68657e986f41fcb3a9c9f102383106bc4efbd00be272989f",
            },
            "windows_amd64": {
                "bin": "protoc-gen-protocontract-buffa.exe",
                "file": "windows-x86_64.exe",
                "sha256": "6303b6f3ff5118a77ed57c3a2c693973f5a4df5aae12ceb65df2a7aec654a4b3",
            },
            "windows_arm64": {
                "bin": "protoc-gen-protocontract-buffa.exe",
                "file": "windows-aarch64.exe",
                "sha256": "d47e5bcc89e7b561b91f5510eddb93ddd2a92b91b9ce64e3148e2acdfa63d007",
            },
        },
        "v0.4.0": {
            "linux_amd64": {
                "bin": "protoc-gen-protocontract-buffa",
                "file": "linux-x86_64",
                "sha256": "228cbfcffce97913da77258b1db42b1b318db45d48c33c5924c4cdbda1077e3c",
            },
            "linux_arm64": {
                "bin": "protoc-gen-protocontract-buffa",
                "file": "linux-aarch64",
                "sha256": "849d4d49cab7cadfce8ce895ba3182aaa2392503d2aeea48bf67ab5e8e5fff60",
            },
            "darwin_amd64": {
                "bin": "protoc-gen-protocontract-buffa",
                "file": "darwin-x86_64",
                "sha256": "afefcc076ee67b7f4b852241275b9374f050a825945a6e039a2bb6dbf7a75c7a",
            },
            "darwin_arm64": {
                "bin": "protoc-gen-protocontract-buffa",
                "file": "darwin-aarch64",
                "sha256": "abb88ef2c34062fccba66659b55112235dbd9d167cec01a0fb64cb2a0de04e51",
            },
            "windows_amd64": {
                "bin": "protoc-gen-protocontract-buffa.exe",
                "file": "windows-x86_64.exe",
                "sha256": "05f93e48277a41fbe366b0d227efe24140827d6927e4b8113da121eaa0f3a295",
            },
            "windows_arm64": {
                "bin": "protoc-gen-protocontract-buffa.exe",
                "file": "windows-aarch64.exe",
                "sha256": "e16bf224be0b63178a94845aa0d184d392ccf54f9a05af0dd0b569d8fbc85f93",
            },
        },
        "v0.4.1": {
            "linux_amd64": {
                "bin": "protoc-gen-protocontract-buffa",
                "file": "linux-x86_64",
                "sha256": "bd103e2cdb2e48441d604e46c2c5708efbac909f99ca51654c1334fe2aa3efa8",
            },
            "linux_arm64": {
                "bin": "protoc-gen-protocontract-buffa",
                "file": "linux-aarch64",
                "sha256": "e654a787838495b0e0ed6a586a02b94038674bc78ee5cca322d01e19b0eea358",
            },
            "darwin_amd64": {
                "bin": "protoc-gen-protocontract-buffa",
                "file": "darwin-x86_64",
                "sha256": "bd51dd3777b48b0e0b50d95f2b18ed5404035724876b7a4217c8c873fc8ecb58",
            },
            "darwin_arm64": {
                "bin": "protoc-gen-protocontract-buffa",
                "file": "darwin-aarch64",
                "sha256": "16ac06f5d1ef78eca45b31b0790f1beb10c259fa340b0308e278fc4b470ff543",
            },
            "windows_amd64": {
                "bin": "protoc-gen-protocontract-buffa.exe",
                "file": "windows-x86_64.exe",
                "sha256": "5bd440fabf75042bc8dbc908bfa939f19af409cb8c02e338b0b4009b8026bced",
            },
            "windows_arm64": {
                "bin": "protoc-gen-protocontract-buffa.exe",
                "file": "windows-aarch64.exe",
                "sha256": "360aba65b60d78b18b2e6eab4142604dcbae1cb6b4a5512b99f9d256fe15fc1f",
            },
        },
        "v0.4.2": {
            "linux_amd64": {
                "bin": "protoc-gen-protocontract-buffa",
                "file": "linux-x86_64",
                "sha256": "ac9241a4a082ca08cd28d536e37754da11139c8c001e50a1675f2afc6035d576",
            },
            "linux_arm64": {
                "bin": "protoc-gen-protocontract-buffa",
                "file": "linux-aarch64",
                "sha256": "e654a787838495b0e0ed6a586a02b94038674bc78ee5cca322d01e19b0eea358",
            },
            "darwin_amd64": {
                "bin": "protoc-gen-protocontract-buffa",
                "file": "darwin-x86_64",
                "sha256": "dda744dd0ac2b01d79fcb9e07e1418c4513c3250dc10cab28763733c3daba808",
            },
            "darwin_arm64": {
                "bin": "protoc-gen-protocontract-buffa",
                "file": "darwin-aarch64",
                "sha256": "15662a1e908aa0bf7c98d433da6e124e6ea107afc4a588232c866f21b7547e75",
            },
            "windows_amd64": {
                "bin": "protoc-gen-protocontract-buffa.exe",
                "file": "windows-x86_64.exe",
                "sha256": "1d036a0346ed326ff6d6ada0a8176377aa6ebc5fcf420ef3201965c4d1765f56",
            },
            "windows_arm64": {
                "bin": "protoc-gen-protocontract-buffa.exe",
                "file": "windows-aarch64.exe",
                "sha256": "77a38ee6840c193f581f9dc03d84b765372a30c6d6e1fba8342c9873f2ddf90a",
            },
        },
    },
}
