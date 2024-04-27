add_rules(
    "mode.debug",
    "mode.release",
    "plugin.vsxmake.autoupdate"
)

set_project("PhysX")
set_version("5.3.1", {build = "%Y%m%d%H%M"})


