#!/usr/bin/env python3

import argparse
import subprocess
import os
import sys
import json

def read_port_version_from_vcpkg_json(port_dir: str) -> str:
    vcpkg_json_path = os.path.join(port_dir, "vcpkg.json")

    if not os.path.isfile(vcpkg_json_path):
        print(f"Error: vcpkg.json not found in {port_dir}")
        sys.exit(1)

    with open(vcpkg_json_path, "r", encoding="utf-8") as f:
        try:
            data = json.load(f)
        except json.JSONDecodeError as e:
            print(f"Error parsing vcpkg.json: {e}")
            sys.exit(1)

    # Look for supported version fields in priority order
    version = (
            data.get("version-string") or
            data.get("version") or
            data.get("version-semver") or
            data.get("version-relax") or
            data.get("version-date")
    )

    if not version:
        print(f"Error: No version field found in {vcpkg_json_path}")
        sys.exit(1)

    port_version = data.get("port-version", 0)

    # Format as "version" or "version#port-version"
    if port_version > 0:
        return f"{version}#{port_version}"
    else:
        return version

def vcpkg_format_manifest(port_name: str, ports_dir: str):
    manifest_path = os.path.join(ports_dir, port_name, "vcpkg.json")

    # Construct command
    command = [
        "vcpkg", "format-manifest", manifest_path
    ]

    print(f"Running command: {' '.join(command)}")

    # Run the command
    try:
        subprocess.run(command, check=True)
        print("format-manifest completed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Error running format-manifest: {e}")
        sys.exit(1)

def git_commit_port_files(port_name: str, ports_dir: str, port_version: str):

    port_path = os.path.join(ports_dir, port_name)

    if not os.path.isdir(port_path):
        print(f"Error: Port directory not found: {port_path}")
        sys.exit(1)

    # Stage changes
    try:
        subprocess.run(["git", "add", port_path], check=True)
        print(f"Staged changes in: {port_path}")
    except subprocess.CalledProcessError:
        print("Error: Failed to stage port changes with git.")
        sys.exit(1)

    message = f"[{port_name}] add {port_version}"

    # Commit
    try:
        subprocess.run(["git", "commit", "-m", message], check=True)
        print(f"Committed changes: {message}")
    except subprocess.CalledProcessError:
        print("Error: Failed to commit port changes.")
        sys.exit(1)

def vcpkg_add_version(port_name: str, ports_dir: str, versions_dir: str):
    # Absolute paths
    ports_path = os.path.abspath(ports_dir)
    versions_path = os.path.abspath(versions_dir)

    # Construct command
    command = [
        "vcpkg", "x-add-version", port_name,
        "--x-builtin-ports-root=" + ports_path,
        "--x-builtin-registry-versions-dir=" + versions_path
    ]

    print(f"Running command: {' '.join(command)}")

    # Run the command
    try:
        subprocess.run(command, check=True)
        print("x-add-version completed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Error running x-add-version: {e}")
        sys.exit(1)

def git_commit_version_files(port_name: str, versions_dir: str, port_version: str):
    # Stage changes
    try:
        subprocess.run(["git", "add", versions_dir], check=True)
        print(f"Staged changes in: {versions_dir}")
    except subprocess.CalledProcessError:
        sys.exit(1)

    message = f"[{port_name}] release {port_version}"

    # Commit
    try:
        subprocess.run(["git", "commit", "-m", message], check=True)
        print(f"Committed changes: {message}")
    except subprocess.CalledProcessError:
        print("Error: Failed to commit port changes.")
        sys.exit(1)
def main():
    parser = argparse.ArgumentParser(description="Wrap vcpkg x-add-version for a custom registry.")
    parser.add_argument("port", help="Name of the port to add version for.")
    parser.add_argument("--ports-dir", default="ports", help="Relative path to the ports directory (default: ports)")
    parser.add_argument("--versions-dir", default="versions", help="Relative path to the versions directory (default: versions)")
    args = parser.parse_args()

    # Ensure directories exist
    if not os.path.isdir(args.ports_dir):
        print(f"Error: Ports directory not found: {args.ports_dir}")
        sys.exit(1)

    if not os.path.isdir(args.versions_dir):
        print(f"Error: Versions directory not found: {args.versions_dir}")
        sys.exit(1)

    port_path = str(os.path.join(args.ports_dir, args.port))

    port_version = read_port_version_from_vcpkg_json(port_path)

    vcpkg_format_manifest(args.port, args.ports_dir)
    git_commit_port_files(args.port, args.ports_dir, port_version)
    vcpkg_add_version(args.port, args.ports_dir, args.versions_dir)
    git_commit_version_files(args.port, args.versions_dir, port_version)

if __name__ == "__main__":
    main()
