group "default" {
  targets = ["backend-server", "room-server", "web-server", "init-db", "openresty"]
}

variable "IMAGE_REGISTRY" {
  default = "docker.io"
}

variable "SEMVER_FULL" {
  default = "v0.0.0-alpha"
}

variable "IMAGE_TAG" {
  default = "latest"
}

target "backend-server" {
  context = "."
  dockerfile = "packaging/Dockerfile.backend-server"
  args = {
    SEMVER_FULL = SEMVER_FULL
  }
  tags = ["${IMAGE_REGISTRY}/zainchen/backend-server:latest", "${IMAGE_REGISTRY}/zainchen/backend-server:${IMAGE_TAG}"]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "room-server" {
  context = "."
  dockerfile = "packaging/Dockerfile.room-server"
  args = {
    SEMVER_FULL = SEMVER_FULL
  }
  tags = ["${IMAGE_REGISTRY}/zainchen/room-server:latest", "${IMAGE_REGISTRY}/zainchen/room-server:${IMAGE_TAG}"]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "web-server" {
  context = "."
  dockerfile = "packaging/Dockerfile.web-server"
  args = {
    SEMVER_FULL = SEMVER_FULL
  }
  tags = ["${IMAGE_REGISTRY}/zainchen/web-server:latest", "${IMAGE_REGISTRY}/zainchen/web-server:${IMAGE_TAG}"]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "init-db" {
  context = "./init-db"
  dockerfile = "Dockerfile"
  args = {
    SEMVER_FULL = SEMVER_FULL
  }
  tags = ["${IMAGE_REGISTRY}/zainchen/init-db:latest", "${IMAGE_REGISTRY}/zainchen/init-db:${IMAGE_TAG}"]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "openresty" {
  context = "./gateway"
  dockerfile = "../packaging/Dockerfile.openresty"
  args = {
    SEMVER_FULL = SEMVER_FULL
  }
  tags = ["${IMAGE_REGISTRY}/zainchen/openresty:latest", "${IMAGE_REGISTRY}/zainchen/openresty:${IMAGE_TAG}"]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "all-in-one" {
  context = "./packaging/all-in-one/all-in-one"
  dockerfile = "Dockerfile"
  args = {
    SEMVER_FULL = SEMVER_FULL
    IMAGE_TAG = IMAGE_TAG
  }
  tags = ["${IMAGE_REGISTRY}/zainchen/all-in-one:latest", "${IMAGE_REGISTRY}/zainchen/all-in-one:${IMAGE_TAG}"]
  platforms = ["linux/amd64", "linux/arm64"]
}
