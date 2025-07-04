# Use bash with strict error checking
set shell := ["bash", "-uc"]

# Allow passing arguments to recipes
set positional-arguments

# Show available recipes with their descriptions
default:
    @just --list

# Install configuration files
install:
    stow */
