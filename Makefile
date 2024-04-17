.PHONY: setup-environment install-microk8s setup-kyverno all clean

all: setup-environment install-microk8s setup-kyverno

setup-environment:
	@echo "Setting up the environment..."
	@bash scripts/setup_environment.sh

install-microk8s:
	@echo "Installing MicroK8s..."
	@bash scripts/install_microk8s.sh

setup-kyverno:
	@echo "Setting up Kyverno..."
	@bash scripts/setup_kyverno.sh

clean:
	@echo "Cleaning up MicroK8s..."
	@sudo microk8s.stop
	@sudo microk8s.reset
	@sudo snap remove microk8s
	@echo "MicroK8s and components have been removed."
