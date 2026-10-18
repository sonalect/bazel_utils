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
    },
}
