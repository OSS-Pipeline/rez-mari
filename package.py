name = "mari"

version = "4.5.2"

authors = [
    "Foundry"
]

description = \
    """
    Mari is Foundry's cutting-edge 3D paint tool, giving you a fluid & flexible way to paint directly onto 3D models.
    """

requires = [
    "cmake-3+",
    "license_manager"
]

variants = [
    ["platform-linux"]
]

tools = [
    "mari"
]

build_system = "cmake"

with scope("config") as config:
    config.build_thread_count = "logical_cores"

uuid = "mari-{version}".format(version=str(version))

def commands():
    env.PATH.prepend("{root}")

    # We setup the license server.
    if "FOUNDRY_LICENSE_SERVER" in env.keys():
        env.foundry_LICENSE.set(str(env.FOUNDRY_LICENSE_SERVER))

    # Helper environment variables.
    env.MARI_BINARY_PATH.set("{root}/bin")
    env.MARI_INCLUDE_PATH.set("{root}/SDK/include")
    env.MARI_LIBRARY_PATH.set("{root}/lib:{root}/plugins")
