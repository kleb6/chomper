# allows running lua modules directly
export PATH := lua_modules/bin:$(PATH)

CARGO     := env CARGO_MSG_LIMIT=15 \
			 CARGO_BUILD_JOBS=12 \
			 NUM_JOBS=12 \
			 cargo 

RUSTFLAGS := -Awarnings

BUILD     := build --verbose

ACTIVE    := chomper2

default: build

build_all:
	RUSTFLAGS=$(RUSTFLAGS) $(CARGO) $(BUILD)

build:
	RUSTFLAGS=$(RUSTFLAGS) $(CARGO) $(BUILD) -p $(ACTIVE)

init: hooks install

hooks:
	git config core.hooksPath .githooks

install:
	luarocks --tree=lua_modules install --only-deps nvim_startup-dev-1.rockspec

lint:
	luacheck --config .luacheckrc ./lua/**/*.lua
