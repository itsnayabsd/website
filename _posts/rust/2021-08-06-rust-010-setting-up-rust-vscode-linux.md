---
date: 2021-08-06 15:23:17 +5:30
title: Setting up Rust in VS Code for Linux
layout : rust-post
category : rust
comments : true
google_adsense: true
excerpt : Setup VS Code IDE in Ubuntu based Linux distributions along with the VS code extensions useful for Rust code development. Create, build, run and debug the rust project using VS Code.
keywords : Install rust compiler in Ubuntu Linux, Install Visual Studio Code in Ubuntu Linux, Install rust extension in VS code, install rust development environment in Ubuntu Linux, rustc, rust-analyzer, cargo, rustup, rust hello world program, rust lldb debugging, codelldb, create rust project in vs code, build or compile rust project in vs code, rust debugging in vs code, vs code rust pluging install
image : /assets/img/rust_extension_pack.png
toc : true
---
## Introduction
VS Code is by far the most suitable IDE for Rust code development. It supports rust extensions for syntax hightlighting, snippets, code compeltion, linting, code formatiing, code navigation, debugging and document generation.

{% include image.html url="rust_extension_pack.png" description="Setting up Rust in VS Code for Linux" %}

So, we are going to setup and use VS code for this and subsequent rust related articles. Let's proceed with the complete Rust setup for VS code.

The following procedure works straight for any Debian/Ubuntu based Linux systems
## Download and Install Rust tools
Run the following command in the Linux terminal. This downloads the script and installs necessary Rust tools.
```basha
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
When the installation promts for the *Current installation options:*, either press `Enter` or select the default option by entering `1`.

Above command installs the following Rust tools
 * *rustup* - The Rust installer and the version management tool
 * *rustc* - Rust compiler
 * *cargo* - Used to build, test and manage packages. Also used to build documentation and check formatting.

Now, run the following command in the current terminal session or re-open the new terminal to bring above installation in effect.
```bash
source $HOME/.cargo/env
``` 
### Check the installation
Check the proper installation with the following command.
```bash
cargo --version
```
This should display cargo version number similar to following
```
cargo 1.54.0 (5ae8d74b3 2021-06-22)
```
## Download VS Code
Now, let's download the VS code IDE and install the extensions necessary for the Rust development.
### Download microsoft signing key
Run the following commands to download microsoft signing key so that we could add the VS code repository, download and install in our system.
```bash
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
```
Type your password and press Enter.

### Add VS code repository to the sources list
Run the following commands to add the VS code repository to the Ubuntu sources list.
```bash
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
```
### Update the sources and install vscode
Run the following commands to update the sources list and install the VS code.
```bash
sudo apt install apt-transport-https
sudo apt update
sudo apt install code
```
For Linux based systems other than Debian or Ubuntu based, use the link [https://code.visualstudio.com/docs/setup/linux](https://code.visualstudio.com/docs/setup/linux) to install VS Code.
## Install Rust Extensions
Now, VS code has been installed. Open the VS code IDE. Press `Ctrl`+`Shift`+`X` to open extension market place in the VS code. Search for the following extensions and click install.

 * *rust-analyzer* - Supports code completion, go to definition, go to implementation and go to type definiton, syntax highlighting. You can find more about rust-analyzer at [https://rust-analyzer.github.io/manual.html](https://rust-analyzer.github.io/manual.html).
 * *crates* - To manage the dependencies with *Cargo.toml* file. More about this file in the later rust articles.
 * *CodeLLDB* - Supports native and remote debugging, disassembly, reverse debugging, core dump inspection. More about codelldb at [https://github.com/vadimcn/vscode-lldb/blob/VERSION/MANUAL.md](https://github.com/vadimcn/vscode-lldb/blob/VERSION/MANUAL.md). Replace *VERSION* with codelldb version. *ex: v1.6.5*.
 * *Better TOML* - Syntax hightlighting and validation for toml files and markdown files.

## Create a Hello World! project
Create a new folder *rust_hello_world* in the home directory by running following command in the terminal.
```bash
mkdir ~/rust_hello_world
```
Now open the VS code. Click on *File* -> *Open Folder* from the menu, select the *rust_hello_world* directory present in the Home directory and then press OK.

{% include image.html url="vscode_open_folder.png" description="VS Code open and select folder" %}
Now right click anywhere in the *Explorer* and create a new file. Name it to *Cargo.toml*.

{% include image.html url="vscode_new_file.png" description="VS Code Create New File in Explorer" %}
Add the following content into the file and save it by pressing `Ctrl` + `S`.
```toml
[package]
name = "hello_world"
version = "0.0.1"
```
Now again right click on the explorer and create a new folder *src*. And then right click on the *src* folder, choose *New File* and name it to *main.rs*.

Add the following content to main.rs and save it.
```rs
fn main() {
    println!("Hello, world!");
}
```
Once you save the files, the project file hierarchy should be looking like following.
{% include image.html url="helloworld_project_hierarchy.png" description="Rust Hello World Project File Tree Hierarchy" %}

### Building the project and running it
Press `Ctrl` + `F5` to build and run the *hello_world* project. Alternatively you can click on *Run* -> *Run Without Debugging* from the menu. If any window pops up asking to generate launch configuration settings, press OK and then again build the project.

If everything works, the VS code integrated terminal shows *Hello, World!* output.
{% include image.html url="rust_helloworld_output.png" description="Rust Hello World Output" %}

## Debugging by setting breakpoints
You can set the breakpoints at specific lines and start debugging by pressing the `F5` key. In the following case, I set the breakpoint at *line 3* by hovering the mouse over line 3 and then clicking the red dot button there.
{% include image.html url="rust_vscode_debugging.png" description="Debugging Rust Program in VS Code" %}

If you see the *DEBUG CONSOLE* window with the prints similar to following, congrats! your VS code setup for Rust code development is ready.
