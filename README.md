# Nomad Job Deployment Project

## Overview

This project demonstrates deploying and running a batch job using HashiCorp Nomad on an Ubuntu 22.04 server in dev mode. The example job runs a simple script that outputs "Hello, Nomad!".

---

## Project Workflow

### 1. File Transfer

- The Nomad job file `example.nomad` was securely copied to the remote server using SCP and an SSH key.

### 2. Nomad Installation & Setup

- Installed Nomad CLI version 1.6.6 on an Ubuntu server.
- Resolved service startup issues caused by configuration permissions.

### 3. Running Nomad Agent

- Started Nomad agent in development mode (`nomad agent -dev`) to enable quick, local scheduling and testing.
- Confirmed agent readiness with debug logs and status commands.

### 4. Job Submission and Execution

- Submitted the Nomad job using `nomad job run /home/ubuntu/example.nomad`.
- Monitored job evaluation and allocation status until completion.
- Verified task output by viewing allocation logs (`nomad alloc logs <allocation_id>`), displaying expected output:  
  `Hello, Nomad!`

---

## Current Status

- The job runs successfully in a single-node dev environment.
- Job status shows `dead` after completion, typical for batch jobs.
- Allocation logs confirm correct execution output.
- The environment is ideal for testing Nomad workflows before deploying to production clusters.

---

## Next Steps

- Optionally configure Nomad for multi-node and persistent mode.
- Push project files including `example.nomad` and setup scripts to a version control repository.
- Expand job specs for advanced workflows or service jobs.

---


## References

Nomad Official Documentation : https://developer.hashicorp.com/nomad/docs