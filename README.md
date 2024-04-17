# MicroK8s Automation Project

This project automates the setup of MicroK8s on an Ubuntu VM, including the installation of MicroK8s via Snap, configuration of essential Kubernetes services, and deployment of Kyverno policies in audit mode using Helm.

## Project Structure

```bash
microk8s-automation/
│
├── scripts/ # Directory for scripts
│ ├── setup_environment.sh 		# Prepares the Ubuntu environment
│ ├── install_microk8s.sh 		# Installs MicroK8s and enables basic services
│ └── setup_kyverno.sh 			# Installs Kyverno and applies initial policies
│
├── Makefile 				# Orchestrates the setup and cleanup processes
│
└── README.md 				# Documentation for the project
```

## Prerequisites

Before running this project, ensure the following prerequisites are met:

- Ubuntu 20.04 or later
- `make` installed (the scripts will handle this as well)
- Root or sudo privileges are required for running the scripts

## Getting Started

To get started with this project, follow these steps:

1. **Clone the repository:**

```bash
git clone https://github.com/Lillevang/microk8s-automation.git
cd microk8s-automation
```

2. **Run the Makefile:**
This will execute all steps from setting up the environment to installing MicroK8s and Kyverno: `make all`
To run individual parts, you can use the specific targets:
```bash
make setup-environment
make install-microk8s
make setup-kyverno
```


## Scripts Explained

- **setup_environment.sh**: Updates the system and installs necessary packages like `snapd` and `make`.
- **install_microk8s.sh**: Installs MicroK8s, enables services like DNS and dashboard, and sets up `kubectl` alias.
- **setup_kyverno.sh**: Adds the Kyverno Helm chart repository, installs Kyverno into the `kyverno` namespace, and applies a basic policy in audit mode.

## Cleanup

To clean up and remove MicroK8s from your system, use the following command: `make clean`

This will stop MicroK8s, reset the installation, and remove the snap.

## Contributing

Contributions to this project are welcome! Please consider the following steps:

1. Fork the repository.
2. Create a new branch for your feature or fix.
3. Submit a pull request with a clear description of your changes or improvements.

Extend this repo by adding an application for fast demos of containerized applications or workloads on a Ubuntu environment.

## License

MIT standard license. This is a project for PoCs or demos, spin up a cluster quick, then add in an application...



