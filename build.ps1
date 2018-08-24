param(
    [string]$image
)
if (!(Test-Path "${image}")) {
    Write-Error "no such container image"
    exit;
}
$name = Get-Content ${image}/NAME
$version = Get-Content ${image}/VERSION
Write-Host "building ${name}:${version}"
if (Test-Path "${x}/prebuild.sh") {
    & bash.exe -c "cd ${image} && ${x}/prebuild.sh ${x}";
}
else {
    if (Test-Path "${x}\prebuild.ps1") {
        & "${x}/prebuild.ps1"
    }
}

# $pwd = (Get-Location).Path
# Set-Location .\$image
docker.exe build --build-arg name="${name}" --build-arg version="${version}" --tag "${name}:latest" --tag "${name}:${version}" "${image}"
# Set-Location $pwd
if (Test-Path "${x}/postbuild.sh") {
    & bash.exe -c "cd ${image} && ${x}/postbuild.sh ${x}";
}
else {
    if (Test-Path "${x}\postbuild.ps1") {
        & "${x}/postbuild.ps1"
    }
}
