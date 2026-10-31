.PHONY: check setup test clean

check:
	./scripts/check-dependencies.sh
	./scripts/check-dynamorio.sh

setup:
	./setup.sh

test:
	./test.sh

clean:
	find . -type d \( -name build -o -name cmake-build-* \) -prune -exec rm -rf {} +
