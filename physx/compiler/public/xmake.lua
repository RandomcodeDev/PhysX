add_rules(
    "mode.debug",
    "mode.release",
    "plugin.vsxmake.autoupdate"
)

if os.isfile(path.join("..", "..", "..", "..", "platform", "switch", "switch.lua")) then
    includes(path.join("..", "..", "..", "..", "platform", "switch", "switch.lua"))
end

if os.isfile(path.join("..", "..", "..", "..", "platform", "ps5", "ps5.lua")) then
    includes(path.join("..", "..", "..", "..", "platform", "ps5", "ps5.lua"))
end

if os.isfile(path.join("..", "..", "..", "support", "platform", "win32", "xbox360.lua")) then
    includes(path.join("..", "..", "..", "support", "platform", "win32", "xbox360.lua"))
end

set_project("PhysX")
set_version("5.3.1", {build = "%Y%m%d%H%M"})

set_allowedplats("windows", "linux", "freebsd")

set_languages("cxx98")
set_exceptions("none")

physx_root = path.join("$(scriptdir)", "..", "..")

includes("physx.lua")
setup_physx(physx_root, function() end, "PhysX SDK", "none")

