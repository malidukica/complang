## Installasjon

Det enkleste er å gå til [Go Downloads](https://golang.org/dl/) og laste ned binary.


### Environment variabler

```bash
# Go development
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"
```

### Windows

* [Windows MSI](https://dl.google.com/go/go1.12.6.windows-amd64.msi)

### Linux (Ubuntu)

* [Linux tar.gz](https://dl.google.com/go/go1.12.6.linux-amd64.tar.gz)
* Ubuntu `sudo apt install golang` (versjon 1.10)

### Apple macOS

* [Apple pkg](https://dl.google.com/go/go1.12.6.darwin-amd64.pkg)
* `brew install go`
