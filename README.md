# ssh-ssm

  

This Bash script simplifies the process of selecting an AWS profile and connecting to an EC2 instance using AWS Systems Manager (SSM) Session Manager.

  

## Prerequisites

  

- [AWS Command Line Interface (CLI)](https://aws.amazon.com/cli/)

- [jq](https://stedolan.github.io/jq/)

  

## Usage

  

1. Clone this repository to your local machine:

  

```bash

git clone https://github.com/fsemino/ssh-ssm.git

cd ssh-ssm
```
  

 2. Make the script executable:

  

```bash

chmod  +x  ssh-ssm.sh
```

 3. Run  the  script:
  

```bash

./aws_profile_selector.sh
```

> You can set AWS_PROFILE or your Credentials using Env vars or
> Follow the on-screen instructions to select an AWS profile and EC2
> instance.

  

## Building a Binary

You can compile this script into a binary for various operating systems using tools like shc. Below are instructions for creating a binary for Linux and macOS.

  

### For Linux

Install shc:

  

```bash
sudo apt-get install shc
```
Compile the script:

  

```bash
shc  -f ssh-ssm.sh
```
The binary will be created as aws_profile_selector.sh.x. You can rename it for convenience:

  

```bash
mv ssh-ssm.sh.x ssh-ssm
```
### For macOS

Install shc using Homebrew:

  

```bash
brew install shc
```
Compile the script:

  

```bash
shc  -f ssh-ssm.sh
```
Rename the binary:

  

```bash
mv ssh-ssm.sh.x ssh-ssm
```