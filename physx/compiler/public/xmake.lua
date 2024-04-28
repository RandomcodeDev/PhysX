add_rules(
    "mode.debug",
    "mode.release",
    "plugin.vsxmake.autoupdate"
)

set_project("PhysX")
set_version("5.3.1", {build = "%Y%m%d%H%M"})

set_allowedplats("gdk", "gdkx", "windows", "linux", "switch")
set_allowedarchs("gdk|x64", "gdkx|x64", "switch|arm64")

set_languages("cxx98")
set_exceptions("none")

physx_root = path.join("$(scriptdir)", "..", "..")

is_windows = is_plat("gdk", "gdkx", "windows")
is_gdk = is_plat("gdk", "gdkx")
is_win32 = is_plat("windows")
is_linux = is_plat("linux")
is_switch = is_plat("switch")

add_defines("PX_PHYSX_STATIC_LIB")
add_includedirs(path.join(physx_root, "include"))

if is_mode("debug") then
    add_defines("_DEBUG")
else
    add_defines("NDEBUG")
end

target("PhysXFoundation")
    set_kind("static")
    add_headerfiles(
        path.join(physx_root, "include", "foundation", "PxFoundation.h"),
        path.join(physx_root, "include", "foundation", "PxAssert.h"),
        path.join(physx_root, "include", "foundation", "PxFoundationConfig.h"),
        path.join(physx_root, "include", "foundation", "PxMathUtils.h"),
        path.join(physx_root, "include", "foundation", "Px.h"),
        path.join(physx_root, "include", "foundation", "PxAlignedMalloc.h"),
        path.join(physx_root, "include", "foundation", "PxAllocatorCallback.h"),
        path.join(physx_root, "include", "foundation", "PxProfiler.h"),
        path.join(physx_root, "include", "foundation", "PxAoS.h"),
        path.join(physx_root, "include", "foundation", "PxAlloca.h"),
        path.join(physx_root, "include", "foundation", "PxAllocator.h"),
        path.join(physx_root, "include", "foundation", "PxArray.h"),
        path.join(physx_root, "include", "foundation", "PxAtomic.h"),
        path.join(physx_root, "include", "foundation", "PxBasicTemplates.h"),
        path.join(physx_root, "include", "foundation", "PxBitMap.h"),
        path.join(physx_root, "include", "foundation", "PxBitAndData.h    "),
        path.join(physx_root, "include", "foundation", "PxBitUtils.h"),
        path.join(physx_root, "include", "foundation", "PxBounds3.h"),
        path.join(physx_root, "include", "foundation", "PxBroadcast.h"),
        path.join(physx_root, "include", "foundation", "PxErrorCallback.h"),
        path.join(physx_root, "include", "foundation", "PxErrors.h"),
        path.join(physx_root, "include", "foundation", "PxFlags.h"),
        path.join(physx_root, "include", "foundation", "PxFPU.h"),
        path.join(physx_root, "include", "foundation", "PxInlineAoS.h"),
        path.join(physx_root, "include", "foundation", "PxIntrinsics.h"),
        path.join(physx_root, "include", "foundation", "PxHash.h"),
        path.join(physx_root, "include", "foundation", "PxHashInternals.h"),
        path.join(physx_root, "include", "foundation", "PxHashMap.h"),
        path.join(physx_root, "include", "foundation", "PxHashSet.h"),
        path.join(physx_root, "include", "foundation", "PxInlineAllocator.h"),
        path.join(physx_root, "include", "foundation", "PxInlineArray.h"),
        path.join(physx_root, "include", "foundation", "PxPinnedArray.h"),
        path.join(physx_root, "include", "foundation", "PxMathIntrinsics.h"),
        path.join(physx_root, "include", "foundation", "PxMutex.h"),
        path.join(physx_root, "include", "foundation", "PxIO.h"),
        path.join(physx_root, "include", "foundation", "PxMat33.h"),
        path.join(physx_root, "include", "foundation", "PxMat34.h"),
        path.join(physx_root, "include", "foundation", "PxMat44.h"),
        path.join(physx_root, "include", "foundation", "PxMath.h    "),
        path.join(physx_root, "include", "foundation", "PxMemory.h"),
        path.join(physx_root, "include", "foundation", "PxPlane.h"),
        path.join(physx_root, "include", "foundation", "PxPool.h"),
        path.join(physx_root, "include", "foundation", "PxPreprocessor.h"),
        path.join(physx_root, "include", "foundation", "PxQuat.h"),
        path.join(physx_root, "include", "foundation", "PxPhysicsVersion.h"),
        path.join(physx_root, "include", "foundation", "PxSortInternals.h"),
        path.join(physx_root, "include", "foundation", "PxSimpleTypes.h"),
        path.join(physx_root, "include", "foundation", "PxSList.h"),
        path.join(physx_root, "include", "foundation", "PxSocket.h"),
        path.join(physx_root, "include", "foundation", "PxSort.h"),
        path.join(physx_root, "include", "foundation", "PxStrideIterator.h"),
        path.join(physx_root, "include", "foundation", "PxString.h"),
        path.join(physx_root, "include", "foundation", "PxSync.h"),
        path.join(physx_root, "include", "foundation", "PxTempAllocator.h"),
        path.join(physx_root, "include", "foundation", "PxThread.h"),
        path.join(physx_root, "include", "foundation", "PxTransform.h"),
        path.join(physx_root, "include", "foundation", "PxTime.h"),
        path.join(physx_root, "include", "foundation", "PxUnionCast.h"),
        path.join(physx_root, "include", "foundation", "PxUserAllocated.h"),
        path.join(physx_root, "include", "foundation", "PxUtilities.h"),
        path.join(physx_root, "include", "foundation", "PxVec2.h"),
        path.join(physx_root, "include", "foundation", "PxVec3.h"),
        path.join(physx_root, "include", "foundation", "PxVec4.h"),
        path.join(physx_root, "include", "foundation", "PxVecMath.h"),
        path.join(physx_root, "include", "foundation", "PxVecMathAoSScalar.h"),
        path.join(physx_root, "include", "foundation", "PxVecMathAoSScalarInline.h"),
        path.join(physx_root, "include", "foundation", "PxVecMathSSE.h"),
        path.join(physx_root, "include", "foundation", "PxVecQuat.h"),
        path.join(physx_root, "include", "foundation", "PxVecTransform.h"),
        path.join(physx_root, "include", "foundation", "PxSIMDHelpers.h"),
        path.join(physx_root, "source", "foundation", "FdFoundation.h")
    )
    add_files(
        path.join(physx_root, "source", "foundation", "FdAllocator.cpp"),
        path.join(physx_root, "source", "foundation", "FdString.cpp"),
        path.join(physx_root, "source", "foundation", "FdTempAllocator.cpp"),
        path.join(physx_root, "source", "foundation", "FdAssert.cpp"),
        path.join(physx_root, "source", "foundation", "FdMathUtils.cpp"),
        path.join(physx_root, "source", "foundation", "FdFoundation.cpp")
    )

    if is_windows then
        add_headerfiles(
            path.join(physx_root, "include", "foundation", "windows", "PxWindowsMathIntrinsics.h"),
            path.join(physx_root, "include", "foundation", "windows", "PxWindowsIntrinsics.h"),
            path.join(physx_root, "include", "foundation", "windows", "PxWindowsAoS.h"),
            path.join(physx_root, "include", "foundation", "windows", "PxWindowsInlineAoS.h"),
            path.join(physx_root, "include", "foundation", "windows", "PxWindowsTrigConstants.h"),
            path.join(physx_root, "include", "foundation", "windows", "PxWindowsInclude.h"),
            path.join(physx_root, "include", "foundation", "windows", "PxWindowsFPU.h")
        )
        add_files(
            path.join(physx_root, "source", "foundation", "windows", "FdWindowsAtomic.cpp"),
            path.join(physx_root, "source", "foundation", "windows", "FdWindowsMutex.cpp"),
            path.join(physx_root, "source", "foundation", "windows", "FdWindowsSync.cpp"),
            path.join(physx_root, "source", "foundation", "windows", "FdWindowsThread.cpp"),
            path.join(physx_root, "source", "foundation", "windows", "FdWindowsPrintString.cpp"),
            path.join(physx_root, "source", "foundation", "windows", "FdWindowsSList.cpp"),
            path.join(physx_root, "source", "foundation", "windows", "FdWindowsSocket.cpp"),
            path.join(physx_root, "source", "foundation", "windows", "FdWindowsTime.cpp"),
            path.join(physx_root, "source", "foundation", "windows", "FdWindowsFPU.cpp")
        )
    elseif is_linux then

    end
target_end()
