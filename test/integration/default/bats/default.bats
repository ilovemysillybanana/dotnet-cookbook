#!/usr/bin/env bats

@test "git binary is found in PATH" {
  run which git
}

@test "is dotnet installed" {
  run dotnet --help
}

@test "create project dotnet" {
  run dotnet new
}
