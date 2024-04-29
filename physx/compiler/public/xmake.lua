add_rules(
    "mode.debug",
    "mode.release",
    "plugin.vsxmake.autoupdate"
)

set_project("PhysX")
set_version("5.3.1", {build = "%Y%m%d%H%M"})

set_allowedplats("gdk", "gdkx", "windows", "linux", "freebsd", "switch")
set_allowedarchs("gdk|x64", "gdkx|x64", "switch|arm64")

set_languages("cxx98")
set_exceptions("none")

physx_root = path.join("$(scriptdir)", "..", "..")

is_windows = is_plat("gdk", "gdkx", "windows")
is_gdk = is_plat("gdk", "gdkx")
is_win32 = is_plat("windows")
is_unix = is_plat("linux", "freebsd")
is_switch = is_plat("switch")

add_defines("PX_PHYSX_STATIC_LIB")
add_includedirs(path.join(physx_root, "include"))

if is_mode("debug") then
    add_defines("_DEBUG")
else
    add_defines("NDEBUG")
end

function fix_target(target)
    if is_plat("gdk", "gdkx", "xbox360") and get_config("toolchain") ~= "mingw" then
        target:set("prefixname", "")
        if target:kind() == "binary" then
            target:set("extension", ".exe")
        elseif target:kind() == "static" then
            target:set("extension", ".lib")
        elseif target:kind() == "shared" then
            target:set("extension", ".dll")
        end
    elseif is_plat("switch") then
        if target:kind() == "binary" then
            target:set("prefixname", "")
            target:set("extension", ".nss")
        elseif target:kind() == "static" then
            target:set("prefixname", "lib")
            target:set("extension", ".a")
        elseif target:kind() == "shared" then
            target:set("prefixname", "lib")
            target:set("extension", ".nrs")
        end
    elseif is_plat("switchhb", "psp", "ps3") then
        if target:kind() == "binary" then
            target:set("prefixname", "")
            target:set("extension", ".elf")
        elseif target:kind() == "static" then
            target:set("prefixname", "lib")
            target:set("extension", ".a")
        elseif target:kind() == "shared" then
            target:set("prefixname", "lib")
            target:set("extension", ".elf")
        end
    elseif not is_plat("windows") then
        -- Of course POSIX or GNU or whoever gets to have "libutil.a" be a reserved name
        -- Other systems don't need this, since they don't pull shit like this
        if target:kind() == "static" then
            target:set("suffixname", "-purpl")
        end
    end
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
    elseif is_unix then
    elseif is_switch then
    end

    on_load(fix_target)
target_end()

target("LowLevel")
    set_kind("static")
    add_headerfiles(
        path.join(physx_root, "source", "lowlevel", "api", "include", "PxsMaterialShared.h"),
        path.join(physx_root, "source", "lowlevel", "api", "include", "PxsMaterialCore.h"),
        path.join(physx_root, "source", "lowlevel", "api", "include", "PxsFEMSoftBodyMaterialCore.h"),
        path.join(physx_root, "source", "lowlevel", "api", "include", "PxsFEMClothMaterialCore.h"),
        path.join(physx_root, "source", "lowlevel", "api", "include", "PxsPBDMaterialCore.h"),
        path.join(physx_root, "source", "lowlevel", "api", "include", "PxsFLIPMaterialCore.h"),
        path.join(physx_root, "source", "lowlevel", "api", "include", "PxsMPMMaterialCore.h"),
        path.join(physx_root, "source", "lowlevel", "api", "include", "PxsMaterialManager.h"),
        path.join(physx_root, "source", "lowlevel", "api", "include", "PxvConfig.h"),
        path.join(physx_root, "source", "lowlevel", "api", "include", "PxvDynamics.h"),
        path.join(physx_root, "source", "lowlevel", "api", "include", "PxvGeometry.h"),
        path.join(physx_root, "source", "lowlevel", "api", "include", "PxvGlobals.h"),
        path.join(physx_root, "source", "lowlevel", "api", "include", "PxvManager.h"),
        path.join(physx_root, "source", "lowlevel", "api", "include", "PxvSimStats.h"),

        path.join(physx_root, "source", "lowlevel", "common", "include", "pipeline", "PxcConstraintBlockStream.h"),
        path.join(physx_root, "source", "lowlevel", "common", "include", "pipeline", "PxcContactCache.h"),
        path.join(physx_root, "source", "lowlevel", "common", "include", "pipeline", "PxcMaterialMethodImpl.h"),
        path.join(physx_root, "source", "lowlevel", "common", "include", "pipeline", "PxcNpBatch.h"),
        path.join(physx_root, "source", "lowlevel", "common", "include", "pipeline", "PxcNpCache.h"),
        path.join(physx_root, "source", "lowlevel", "common", "include", "pipeline", "PxcNpCacheStreamPair.h"),
        path.join(physx_root, "source", "lowlevel", "common", "include", "pipeline", "PxcNpContactPrepShared.h"),
        path.join(physx_root, "source", "lowlevel", "common", "include", "pipeline", "PxcNpMemBlockPool.h"),
        path.join(physx_root, "source", "lowlevel", "common", "include", "pipeline", "PxcNpThreadContext.h"),
        path.join(physx_root, "source", "lowlevel", "common", "include", "pipeline", "PxcNpWorkUnit.h"),

        path.join(physx_root, "source", "lowlevel", "common", "include", "utils", "PxcScratchAllocator.h"),
        path.join(physx_root, "source", "lowlevel", "common", "include", "utils", "PxcThreadCoherentCache.h"),

        path.join(physx_root, "source", "lowlevel", "software", "include", "PxsCCD.h"),
        path.join(physx_root, "source", "lowlevel", "software", "include", "PxsContactManager.h"),
        path.join(physx_root, "source", "lowlevel", "software", "include", "PxsContactManagerState.h"),
        path.join(physx_root, "source", "lowlevel", "software", "include", "PxsContext.h"),
        path.join(physx_root, "source", "lowlevel", "software", "include", "PxsHeapMemoryAllocator.h"),
        path.join(physx_root, "source", "lowlevel", "software", "include", "PxsIslandManagerTypes.h"),
        path.join(physx_root, "source", "lowlevel", "software", "include", "PxsIslandSim.h"),
        path.join(physx_root, "source", "lowlevel", "software", "include", "PxsKernelWrangler.h"),
        path.join(physx_root, "source", "lowlevel", "software", "include", "PxsMaterialCombiner.h"),
        path.join(physx_root, "source", "lowlevel", "software", "include", "PxsMemoryManager.h"),
        path.join(physx_root, "source", "lowlevel", "software", "include", "PxsNphaseImplementationContext.h"),
        path.join(physx_root, "source", "lowlevel", "software", "include", "PxsRigidBody.h"),
        path.join(physx_root, "source", "lowlevel", "software", "include", "PxsShapeSim.h"),
        path.join(physx_root, "source", "lowlevel", "software", "include", "PxsSimpleIslandManager.h"),
        path.join(physx_root, "source", "lowlevel", "software", "include", "PxsSimulationController.h"),
        path.join(physx_root, "source", "lowlevel", "software", "include", "PxsTransformCache.h"),
        path.join(physx_root, "source", "lowlevel", "software", "include", "PxsNphaseCommon.h"),
        path.join(physx_root, "source", "lowlevel", "software", "include", "PxvNphaseImplementationContext.h")
    )
    add_files(
        path.join(physx_root, "source", "lowlevel", "api", "src", "px_globals.cpp"),

        path.join(physx_root, "source", "lowlevel", "common", "src", "pipeline", "PxcContactCache.cpp"),
        path.join(physx_root, "source", "lowlevel", "common", "src", "pipeline", "PxcContactMethodImpl.cpp"),
        path.join(physx_root, "source", "lowlevel", "common", "src", "pipeline", "PxcMaterialMethodImpl.cpp"),
        path.join(physx_root, "source", "lowlevel", "common", "src", "pipeline", "PxcNpBatch.cpp"),
        path.join(physx_root, "source", "lowlevel", "common", "src", "pipeline", "PxcNpCacheStreamPair.cpp"),
        path.join(physx_root, "source", "lowlevel", "common", "src", "pipeline", "PxcNpContactPrepShared.cpp"),
        path.join(physx_root, "source", "lowlevel", "common", "src", "pipeline", "PxcNpMemBlockPool.cpp"),
        path.join(physx_root, "source", "lowlevel", "common", "src", "pipeline", "PxcNpThreadContext.cpp"),

        path.join(physx_root, "source", "lowlevel", "software", "src", "PxsCCD.cpp"),
        path.join(physx_root, "source", "lowlevel", "software", "src", "PxsContactManager.cpp"),
        path.join(physx_root, "source", "lowlevel", "software", "src", "PxsContext.cpp"),
        path.join(physx_root, "source", "lowlevel", "software", "src", "PxsDefaultMemoryManager.cpp"),
        path.join(physx_root, "source", "lowlevel", "software", "src", "PxsIslandSim.cpp"),
        path.join(physx_root, "source", "lowlevel", "software", "src", "PxsNphaseImplementationContext.cpp"),
        path.join(physx_root, "source", "lowlevel", "software", "src", "PxsSimpleIslandManager.cpp")
    )

    add_includedirs(
        path.join(physx_root, "source", "foundation"),

        path.join(physx_root, "include"),

        path.join(physx_root, "source", "common", "include"),
        path.join(physx_root, "source", "common", "src"),

        path.join(physx_root, "source", "physxgpu", "include"),

        path.join(physx_root, "source", "geomutils", "include"),
        path.join(physx_root, "source", "geomutils", "src"),
        path.join(physx_root, "source", "geomutils", "src", "contact"),
        path.join(physx_root, "source", "geomutils", "src", "common"),
        path.join(physx_root, "source", "geomutils", "src", "convex"),
        path.join(physx_root, "source", "geomutils", "src", "distance"),
        path.join(physx_root, "source", "geomutils", "src", "sweep"),
        path.join(physx_root, "source", "geomutils", "src", "gjk"),
        path.join(physx_root, "source", "geomutils", "src", "intersection"),
        path.join(physx_root, "source", "geomutils", "src", "mesh"),
        path.join(physx_root, "source", "geomutils", "src", "hf"),
        path.join(physx_root, "source", "geomutils", "src", "pcm"),
        path.join(physx_root, "source", "geomutils", "src", "ccd"),

        path.join(physx_root, "source", "lowlevel", "api", "include"),
        path.join(physx_root, "source", "lowlevel", "common", "include"),
        path.join(physx_root, "source", "lowlevel", "common", "include", "collision"),
        path.join(physx_root, "source", "lowlevel", "common", "include", "pipeline"),
        path.join(physx_root, "source", "lowlevel", "common", "include", "utils"),
        path.join(physx_root, "source", "lowlevel", "software", "include"),
        path.join(physx_root, "source", "lowleveldynamics", "include")
    )

    if is_windows then
        add_includedirs(
            path.join(physx_root, "source", "common", "src", "windows")
        )
    elseif is_unix then
    elseif is_switch then
    end

    on_load(fix_target)
target_end()

target("LowLevelAABB")
    set_kind("static")
    add_headerfiles(
        path.join(physx_root, "source", "lowlevelaabb", "include", "BpAABBManager.h"),
        path.join(physx_root, "source", "lowlevelaabb", "include", "BpVolumeData.h"),
        path.join(physx_root, "source", "lowlevelaabb", "include", "BpAABBManagerBase.h"),
        path.join(physx_root, "source", "lowlevelaabb", "include", "BpAABBManagerTasks.h"),
        path.join(physx_root, "source", "lowlevelaabb", "include", "BpBroadPhase.h"),
        path.join(physx_root, "source", "lowlevelaabb", "include", "BpBroadPhaseUpdate.h"),
        path.join(physx_root, "source", "lowlevelaabb", "include", "BpFiltering.h"),

        path.join(physx_root, "source", "lowlevelaabb", "src", "BpBroadPhaseABP.h"),
        path.join(physx_root, "source", "lowlevelaabb", "src", "BpBroadPhaseMBP.h"),
        path.join(physx_root, "source", "lowlevelaabb", "src", "BpBroadPhaseSap.h"),
        path.join(physx_root, "source", "lowlevelaabb", "src", "BpBroadPhaseSapAux.h"),
        path.join(physx_root, "source", "lowlevelaabb", "src", "BpBroadPhaseShared.h"),
        path.join(physx_root, "source", "lowlevelaabb", "src", "BpBroadPhaseIntegerAABB.h"),
        path.join(physx_root, "source", "lowlevelaabb", "src", "BpBroadPhaseMBPCommon.h")
    )
    add_files(
        path.join(physx_root, "source", "lowlevelaabb", "src", "BpAABBManager.cpp"),
        path.join(physx_root, "source", "lowlevelaabb", "src", "BpAABBManagerBase.cpp"),
        path.join(physx_root, "source", "lowlevelaabb", "src", "BpBroadPhase.cpp"),
        path.join(physx_root, "source", "lowlevelaabb", "src", "BpBroadPhaseUpdate.cpp"),
        path.join(physx_root, "source", "lowlevelaabb", "src", "BpBroadPhaseABP.cpp"),
        path.join(physx_root, "source", "lowlevelaabb", "src", "BpBroadPhaseMBP.cpp"),
        path.join(physx_root, "source", "lowlevelaabb", "src", "BpBroadPhaseSap.cpp"),
        path.join(physx_root, "source", "lowlevelaabb", "src", "BpBroadPhaseSapAux.cpp"),
        path.join(physx_root, "source", "lowlevelaabb", "src", "BpBroadPhaseShared.cpp"),
        path.join(physx_root, "source", "lowlevelaabb", "src", "BpFiltering.cpp")
    )

    add_includedirs(
        path.join(physx_root, "source", "foundation"),

        path.join(physx_root, "include"),

        path.join(physx_root, "source", "common", "include"),
        path.join(physx_root, "source", "common", "src"),

        path.join(physx_root, "source", "geomutils", "include"),
        path.join(physx_root, "source", "geomutils", "src"),

        path.join(physx_root, "source", "lowlevel", "api", "include"),
        path.join(physx_root, "source", "lowlevel", "common", "include", "utils"),
        path.join(physx_root, "source", "lowlevel", "common", "include", "pipeline"),
        path.join(physx_root, "source", "lowlevelaabb", "include"),
        path.join(physx_root, "source", "lowlevelaabb", "src")
    )

    if is_windows then
        add_includedirs(
            path.join(physx_root, "source", "common", "src", "windows")
        )
    elseif is_unix then
    elseif is_switch then
    end

    on_load(fix_target)
target_end()

target("LowLevelDynamics")
    set_kind("static")
    add_headerfiles(
        path.join(physx_root, "source", "lowleveldynamics", "include", "DyArticulationCore.h"),
        path.join(physx_root, "source", "lowleveldynamics", "include", "DyVArticulation.h		"),
        path.join(physx_root, "source", "lowleveldynamics", "include", "DyArticulationTendon.h"),
        path.join(physx_root, "source", "lowleveldynamics", "include", "DySoftBodyCore.h"),
        path.join(physx_root, "source", "lowleveldynamics", "include", "DySoftBody.h"),
        path.join(physx_root, "source", "lowleveldynamics", "include", "DyFEMClothCore.h"),
        path.join(physx_root, "source", "lowleveldynamics", "include", "DyFEMCloth.h"),
        path.join(physx_root, "source", "lowleveldynamics", "include", "DyHairSystemCore.h"),
        path.join(physx_root, "source", "lowleveldynamics", "include", "DyHairSystem.h"),
        path.join(physx_root, "source", "lowleveldynamics", "include", "DyFeatherstoneArticulation.h"),
        path.join(physx_root, "source", "lowleveldynamics", "include", "DyFeatherstoneArticulationJointData.h"),
        path.join(physx_root, "source", "lowleveldynamics", "include", "DyFeatherstoneArticulationUtils.h"),
        path.join(physx_root, "source", "lowleveldynamics", "include", "DyConstraint.h"),
        path.join(physx_root, "source", "lowleveldynamics", "include", "DyConstraintWriteBack.h"),
        path.join(physx_root, "source", "lowleveldynamics", "include", "DyContext.h"),
        path.join(physx_root, "source", "lowleveldynamics", "include", "DySleepingConfigulation.h"),
        path.join(physx_root, "source", "lowleveldynamics", "include", "DyThresholdTable.h"),
        path.join(physx_root, "source", "lowleveldynamics", "include", "DyArticulationJointCore.h"),
        path.join(physx_root, "source", "lowleveldynamics", "include", "DyParticleSystemCore.h"),
        path.join(physx_root, "source", "lowleveldynamics", "include", "DyParticleSystem.h"),

        path.join(physx_root, "source", "lowleveldynamics", "src", "DySolverConstraint1DStep.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyArticulationContactPrep.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyArticulationCpuGpu.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyArticulationPImpl.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyArticulationUtils.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyFeatherstoneArticulationLink.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyBodyCoreIntegrator.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyConstraintPartition.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyConstraintPrep.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyContactPrep.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyContactPrepShared.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyContactReduction.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyCorrelationBuffer.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyDynamics.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyFrictionPatch.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyFrictionPatchStreamPair.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySolverBody.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySolverConstraint1D.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySolverConstraint1D4.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySolverConstraintDesc.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySolverConstraintExtShared.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySolverConstraintsShared.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySolverConstraintTypes.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySolverContact.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySolverContact4.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySolverContactPF.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySolverContactPF4.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySolverContext.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySolverControl.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySolverControlPF.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySolverCore.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySolverExt.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyThreadContext.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyTGSDynamics.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyTGSContactPrep.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyTGS.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyPGS.h"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySleep.h")
    )
    add_files(
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyArticulationContactPrep.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyArticulationContactPrepPF.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyFeatherstoneArticulation.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyFeatherstoneForwardDynamic.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyFeatherstoneInverseDynamic.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyConstraintPartition.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyConstraintSetup.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyConstraintSetupBlock.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyContactPrep.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyContactPrep4.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyContactPrep4PF.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyContactPrepPF.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyDynamics.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyFrictionCorrelation.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyRigidBodyToSolverBody.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySolverConstraints.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySolverConstraintsBlock.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySolverControl.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySolverControlPF.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySolverPFConstraints.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySolverPFConstraintsBlock.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyThreadContext.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyThresholdTable.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyTGSDynamics.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyTGSContactPrep.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DyTGSContactPrepBlock.cpp"),
        path.join(physx_root, "source", "lowleveldynamics", "src", "DySleep.cpp")
    )

    add_includedirs(
        path.join(physx_root, "source", "foundation"),

        path.join(physx_root, "include"),

        path.join(physx_root, "source", "common", "src"),

        path.join(physx_root, "source", "geomutils", "src", "contact"),
        path.join(physx_root, "source", "geomutils", "src"),
        path.join(physx_root, "source", "geomutils", "include"),

        path.join(physx_root, "source", "lowlevel", "api", "include"),
        path.join(physx_root, "source", "lowlevel", "common", "include"),
        path.join(physx_root, "source", "lowlevel", "common", "include", "pipeline"),
        path.join(physx_root, "source", "lowlevel", "common", "include", "utils"),
        path.join(physx_root, "source", "lowlevel", "software", "include"),

        path.join(physx_root, "source", "lowleveldynamics", "include"),
        path.join(physx_root, "source", "lowleveldynamics", "src"),

        path.join(physx_root, "source", "physxgpu", "include")
    )

    if is_windows then
        add_includedirs(
            path.join(physx_root, "source", "common", "src", "windows")
        )
    elseif is_unix then
    elseif is_switch then
    end

    on_load(fix_target)
target_end()

target("PhysX")
    set_kind("static")
    add_headerfiles(
        path.join(physx_root, "include", "PxActor.h"),
        path.join(physx_root, "include", "PxActorData.h"),
        path.join(physx_root, "include", "PxAggregate.h"),
        path.join(physx_root, "include", "PxArticulationFlag.h"),
        path.join(physx_root, "include", "PxArticulationJointReducedCoordinate.h"),
        path.join(physx_root, "include", "PxArticulationLink.h"),
        path.join(physx_root, "include", "PxArticulationReducedCoordinate.h"),
        path.join(physx_root, "include", "PxArticulationTendon.h"),
        path.join(physx_root, "include", "PxArticulationTendonData.h"),
        path.join(physx_root, "include", "PxAttachment.h"),
        path.join(physx_root, "include", "PxBroadPhase.h"),
        path.join(physx_root, "include", "PxClient.h"),
        path.join(physx_root, "include", "PxConeLimitedConstraint.h"),
        path.join(physx_root, "include", "PxConstraint.h"),
        path.join(physx_root, "include", "PxConstraintDesc.h"),
        path.join(physx_root, "include", "PxContact.h"),
        path.join(physx_root, "include", "PxContactModifyCallback.h"),
        path.join(physx_root, "include", "PxDeletionListener.h"),
        path.join(physx_root, "include", "PxFEMParameter.h"),
        path.join(physx_root, "include", "PxFEMClothFlags.h"),
        path.join(physx_root, "include", "PxFiltering.h"),
        path.join(physx_root, "include", "PxForceMode.h"),
        path.join(physx_root, "include", "PxHairSystemFlag.h"),
        path.join(physx_root, "include", "PxImmediateMode.h"),
        path.join(physx_root, "include", "PxLockedData.h"),
        path.join(physx_root, "include", "PxNodeIndex.h"),
        path.join(physx_root, "include", "PxParticleBuffer.h"),
        path.join(physx_root, "include", "PxParticleGpu.h"),
        path.join(physx_root, "include", "PxParticleSolverType.h"),
        path.join(physx_root, "include", "PxParticleSystem.h"),
        path.join(physx_root, "include", "PxParticleSystemFlag.h"),
        path.join(physx_root, "include", "PxPBDParticleSystem.h"),
        path.join(physx_root, "include", "PxPhysics.h"),
        path.join(physx_root, "include", "PxPhysicsAPI.h"),
        path.join(physx_root, "include", "PxPhysicsSerialization.h"),
        path.join(physx_root, "include", "PxPhysXConfig.h"),
        path.join(physx_root, "include", "PxPruningStructure.h"),
        path.join(physx_root, "include", "PxQueryFiltering.h"),
        path.join(physx_root, "include", "PxQueryReport.h"),
        path.join(physx_root, "include", "PxRigidActor.h"),
        path.join(physx_root, "include", "PxRigidBody.h"),
        path.join(physx_root, "include", "PxRigidDynamic.h"),
        path.join(physx_root, "include", "PxRigidStatic.h"),
        path.join(physx_root, "include", "PxScene.h"),
        path.join(physx_root, "include", "PxSceneDesc.h"),
        path.join(physx_root, "include", "PxSceneLock.h"),
        path.join(physx_root, "include", "PxSceneQueryDesc.h"),
        path.join(physx_root, "include", "PxSceneQuerySystem.h"),
        path.join(physx_root, "include", "PxShape.h"),
        path.join(physx_root, "include", "PxSimulationEventCallback.h"),
        path.join(physx_root, "include", "PxSimulationStatistics.h"),
        path.join(physx_root, "include", "PxSoftBody.h"),
        path.join(physx_root, "include", "PxSoftBodyFlag.h"),
        path.join(physx_root, "include", "PxSparseGridParams.h"),
        path.join(physx_root, "include", "PxVisualizationParameter.h"),
        path.join(physx_root, "include", "PxIsosurfaceExtraction.h"),
        path.join(physx_root, "include", "PxSmoothing.h"),
        path.join(physx_root, "include", "PxAnisotropy.h"),
        path.join(physx_root, "include", "PxParticleNeighborhoodProvider.h"),
        path.join(physx_root, "include", "PxArrayConverter.h"),
        path.join(physx_root, "include", "PxLineStripSkinning.h"),
        path.join(physx_root, "include", "PxSDFBuilder.h"),

        path.join(physx_root, "include", "PxFEMCloth.h"),
        path.join(physx_root, "include", "PxFLIPParticleSystem.h"),
        path.join(physx_root, "include", "PxGridParticleSystem.h"),
        path.join(physx_root, "include", "PxHairSystem.h"),
        path.join(physx_root, "include", "PxMPMParticleSystem.h"),

        path.join(physx_root, "include", "PxBaseMaterial.h"),
        path.join(physx_root, "include", "PxFEMMaterial.h"),
        path.join(physx_root, "include", "PxFEMSoftBodyMaterial.h"),
        path.join(physx_root, "include", "PxFEMClothMaterial.h"),
        path.join(physx_root, "include", "PxParticleMaterial.h"),
        path.join(physx_root, "include", "PxPBDMaterial.h"),
        path.join(physx_root, "include", "PxFLIPMaterial.h"),
        path.join(physx_root, "include", "PxMPMMaterial.h"),
        path.join(physx_root, "include", "PxMaterial.h"),

        path.join(physx_root, "include", "PxBaseMaterial.h"),
        path.join(physx_root, "include", "PxFEMMaterial.h"),
        path.join(physx_root, "include", "PxFEMSoftBodyMaterial.h"),
        path.join(physx_root, "include", "PxFEMClothMaterial.h"),
        path.join(physx_root, "include", "PxParticleMaterial.h"),
        path.join(physx_root, "include", "PxPBDMaterial.h"),
        path.join(physx_root, "include", "PxFLIPMaterial.h"),
        path.join(physx_root, "include", "PxMPMMaterial.h"),
        path.join(physx_root, "include", "PxMaterial.h"),

        path.join(physx_root, "include", "common", "PxBase.h"),
        path.join(physx_root, "include", "common", "PxCollection.h"),
        path.join(physx_root, "include", "common", "PxCoreUtilityTypes.h"),
        path.join(physx_root, "include", "common", "PxInsertionCallback.h"),
        path.join(physx_root, "include", "common", "PxMetaData.h"),
        path.join(physx_root, "include", "common", "PxMetaDataFlags.h"),
        path.join(physx_root, "include", "common", "PxPhysXCommonConfig.h"),
        path.join(physx_root, "include", "common", "PxProfileZone.h"),
        path.join(physx_root, "include", "common", "PxRenderBuffer.h"),
        path.join(physx_root, "include", "common", "PxRenderOutput.h"),
        path.join(physx_root, "include", "common", "PxSerialFramework.h"),
        path.join(physx_root, "include", "common", "PxSerializer.h"),
        path.join(physx_root, "include", "common", "PxStringTable.h"),
        path.join(physx_root, "include", "common", "PxTolerancesScale.h"),
        path.join(physx_root, "include", "common", "PxTypeInfo.h"),

        path.join(physx_root, "include", "omnipvd", "PxOmniPvd.h"),

        path.join(physx_root, "include", "pvd", "PxPvdSceneClient.h"),
        path.join(physx_root, "include", "pvd", "PxPvd.h"),
        path.join(physx_root, "include", "pvd", "PxPvdTransport.h"),

        path.join(physx_root, "include", "collision", "PxCollisionDefs.h"),

        path.join(physx_root, "include", "solver", "PxSolverDefs.h"),

        path.join(physx_root, "source", "physx", "src", "physxmetadada", "physx", "src", "include", "PvdMetaDataDefineProperties.h"),
        path.join(physx_root, "source", "physx", "src", "physxmetadada", "physx", "src", "include", "PvdMetaDataExtensions.h"),
        path.join(physx_root, "source", "physx", "src", "physxmetadada", "physx", "src", "include", "PvdMetaDataPropertyVisitor.h"),
        path.join(physx_root, "source", "physx", "src", "physxmetadada", "physx", "src", "include", "PxAutoGeneratedMetaDataObjectNames.h"),
        path.join(physx_root, "source", "physx", "src", "physxmetadada", "physx", "src", "include", "PxAutoGeneratedMetaDataObjects.h"),
        path.join(physx_root, "source", "physx", "src", "physxmetadada", "physx", "src", "include", "PxMetaDataCompare.h"),
        path.join(physx_root, "source", "physx", "src", "physxmetadada", "physx", "src", "include", "PxMetaDataCppPrefix.h"),
        path.join(physx_root, "source", "physx", "src", "physxmetadada", "physx", "src", "include", "PxMetaDataObjects.h"),
        path.join(physx_root, "source", "physx", "src", "physxmetadada", "physx", "src", "include", "RepXMetaDataPropertyVisitor.h"),

        path.join(physx_root, "source", "physx", "src", "omnipvd", "NpOmniPvd.h"),
        path.join(physx_root, "source", "physx", "src", "omnipvd", "NpOmniPvdRegistrationData.h"),
        path.join(physx_root, "source", "physx", "src", "omnipvd", "NpOmniPvdSetData.h"),
        path.join(physx_root, "source", "physx", "src", "omnipvd", "OmniPvdPxSampler.h"),
        path.join(physx_root, "source", "physx", "src", "omnipvd", "OmniPvdChunkAlloc.h"),
        path.join(physx_root, "source", "physx", "src", "omnipvd", "OmniPvdTypes.h"),

        path.join(physx_root, "source", "physx", "src", "NpPvdSceneClient.h"),
        path.join(physx_root, "source", "physx", "src", "NpPvdSceneQueryCollector.h"),
        path.join(physx_root, "source", "physx", "src", "PvdMetaDataBindingData.h"),
        path.join(physx_root, "source", "physx", "src", "PvdMetaDataPvdBinding.h"),
        path.join(physx_root, "source", "physx", "src", "PvdPhysicsClient.h"),
        path.join(physx_root, "source", "physx", "src", "PvdTypeNames.h"),

        path.join(physx_root, "source", "physx", "src", "NpPBDMaterial.h"),
        path.join(physx_root, "source", "physx", "src", "NpFLIPMaterial.h"),
        path.join(physx_root, "source", "physx", "src", "NpMPMMaterial.h"),
        path.join(physx_root, "source", "physx", "src", "NpFEMSoftBodyMaterial.h"),
        path.join(physx_root, "source", "physx", "src", "NpFEMClothMaterial.h"),
        path.join(physx_root, "source", "physx", "src", "NpMaterial.h"),

        path.join(physx_root, "source", "physx", "src", "NpArticulationReducedCoordinate.h"),
        path.join(physx_root, "source", "physx", "src", "NpArticulationJointReducedCoordinate.h"),
        path.join(physx_root, "source", "physx", "src", "NpArticulationLink.h"),
        path.join(physx_root, "source", "physx", "src", "NpArticulationTendon.h"),
        path.join(physx_root, "source", "physx", "src", "NpArticulationSensor.h"),

        path.join(physx_root, "source", "physx", "src", "NpBounds.h"),
        path.join(physx_root, "source", "physx", "src", "NpPruningStructure.h"),
        path.join(physx_root, "source", "physx", "src", "NpBase.h"),
        path.join(physx_root, "source", "physx", "src", "NpActor.h"),
        path.join(physx_root, "source", "physx", "src", "NpActorTemplate.h"),
        path.join(physx_root, "source", "physx", "src", "NpAggregate.h"),
        path.join(physx_root, "source", "physx", "src", "NpSoftBody.h"),
        path.join(physx_root, "source", "physx", "src", "NpFEMCloth.h"),
        path.join(physx_root, "source", "physx", "src", "NpParticleSystem.h"),
        path.join(physx_root, "source", "physx", "src", "NpHairSystem.h"),
        path.join(physx_root, "source", "physx", "src", "NpConnector.h"),
        path.join(physx_root, "source", "physx", "src", "NpConstraint.h"),
        path.join(physx_root, "source", "physx", "src", "NpFactory.h"),
        path.join(physx_root, "source", "physx", "src", "NpMaterialManager.h"),
        path.join(physx_root, "source", "physx", "src", "NpPhysics.h"),
        path.join(physx_root, "source", "physx", "src", "NpPhysicsInsertionCallback.h"),
        path.join(physx_root, "source", "physx", "src", "NpPtrTableStorageManager.h"),
        path.join(physx_root, "source", "physx", "src", "NpCheck.h"),
        path.join(physx_root, "source", "physx", "src", "NpRigidActorTemplate.h"),
        path.join(physx_root, "source", "physx", "src", "NpRigidActorTemplateInternal.h"),
        path.join(physx_root, "source", "physx", "src", "NpRigidBodyTemplate.h"),
        path.join(physx_root, "source", "physx", "src", "NpRigidDynamic.h"),
        path.join(physx_root, "source", "physx", "src", "NpRigidStatic.h"),
        path.join(physx_root, "source", "physx", "src", "NpScene.h"),
        path.join(physx_root, "source", "physx", "src", "NpSceneQueries.h"),
        path.join(physx_root, "source", "physx", "src", "NpSceneAccessor.h"),
        path.join(physx_root, "source", "physx", "src", "NpShape.h"),
        path.join(physx_root, "source", "physx", "src", "NpShapeManager.h"),
        path.join(physx_root, "source", "physx", "src", "NpDebugViz.h")
    )
    add_files(
        path.join(physx_root, "source", "physx", "src", "omnipvd", "NpOmniPvd.cpp"),
        path.join(physx_root, "source", "physx", "src", "omnipvd", "NpOmniPvdRegistrationData.cpp"),
        path.join(physx_root, "source", "physx", "src", "omnipvd", "OmniPvdPxSampler.cpp"),
        path.join(physx_root, "source", "physx", "src", "omnipvd", "OmniPvdChunkAlloc.cpp"),

        path.join(physx_root, "source", "physx", "src", "NpPvdSceneClient.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpPvdSceneQueryCollector.cpp"),
        path.join(physx_root, "source", "physx", "src", "PvdMetaDataPvdBinding.cpp"),
        path.join(physx_root, "source", "physx", "src", "PvdPhysicsClient.cpp"),

        path.join(physx_root, "source", "immediatemode", "src", "NpImmediateMode.cpp"),

        path.join(physx_root, "source", "physx", "src", "NpMaterial.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpFEMSoftBodyMaterial.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpFEMClothMaterial.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpPBDMaterial.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpFLIPMaterial.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpMPMMaterial.cpp"),

        path.join(physx_root, "source", "physx", "src", "NpArticulationReducedCoordinate.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpArticulationJointReducedCoordinate.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpArticulationLink.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpArticulationTendon.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpArticulationSensor.cpp"),

        path.join(physx_root, "source", "physx", "src", "NpActor.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpAggregate.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpSoftBody.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpFEMCloth.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpParticleSystem.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpHairSystem.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpConstraint.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpFactory.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpMetaData.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpPhysics.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpBounds.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpPruningStructure.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpCheck.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpRigidDynamic.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpRigidStatic.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpScene.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpSceneFetchResults.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpSceneQueries.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpSerializerAdapter.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpShape.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpShapeManager.cpp"),
        path.join(physx_root, "source", "physx", "src", "NpDebugViz.cpp")
    )

    add_includedirs(
        path.join(physx_root, "include"),

        path.join(physx_root, "source", "common", "include"),
        path.join(physx_root, "source", "common", "src"),

        path.join(physx_root, "source", "physx", "src"),
        path.join(physx_root, "source", "physx", "src", "device"),
        path.join(physx_root, "source", "physxgpu", "include"),

        path.join(physx_root, "source", "geomutils", "include"),
        path.join(physx_root, "source", "geomutils", "src"),
        path.join(physx_root, "source", "geomutils", "src", "contact"),
        path.join(physx_root, "source", "geomutils", "src", "common"),
        path.join(physx_root, "source", "geomutils", "src", "convex"),
        path.join(physx_root, "source", "geomutils", "src", "distance"),
        path.join(physx_root, "source", "geomutils", "src", "sweep"),
        path.join(physx_root, "source", "geomutils", "src", "gjk"),
        path.join(physx_root, "source", "geomutils", "src", "intersection"),
        path.join(physx_root, "source", "geomutils", "src", "mesh"),
        path.join(physx_root, "source", "geomutils", "src", "hf"),
        path.join(physx_root, "source", "geomutils", "src", "pcm"),
        path.join(physx_root, "source", "geomutils", "src", "ccd"),

        path.join(physx_root, "source", "lowlevel", "api", "include"),
        path.join(physx_root, "source", "lowlevel", "software", "include"),
        path.join(physx_root, "source", "lowlevel", "common", "include", "pipeline"),
        path.join(physx_root, "source", "lowlevel", "common", "include", "utils"),

        path.join(physx_root, "source", "lowlevelaabb", "include"),

        path.join(physx_root, "source", "lowleveldynamics", "include"),

        path.join(physx_root, "source", "simulationcontroller", "include"),
        path.join(physx_root, "source", "simulationcontroller", "src"),

        path.join(physx_root, "source", "scenequery", "include"),

        path.join(physx_root, "source", "physxmetadata", "core", "include"),

        path.join(physx_root, "source", "pvd", "include"),

        path.join(physx_root, "pvdruntime", "include")
    )

    if is_windows then
        path.join(physx_root, "source", "compiler", "windows", "resource", "PhysX.rc")
    end

    add_deps(
        "PhysXFoundation",
        "LowLevel",
        "LowLevelAABB",
        "LowLevelDynamics",
        "PhysXCommon"
    -- ,"PhysXPvdSDK",
    --  "PhysXTask",
    --  "SceneQuery",
    --  "SimulationController"
    )

    on_load(fix_target)
target_end()

target("PhysXCharacterController")
    set_kind("static")
    add_headerfiles(
        path.join(physx_root, "include", "characterkinematic", "PxBoxController.h"),
        path.join(physx_root, "include", "characterkinematic", "PxCapsuleController.h"),
        path.join(physx_root, "include", "characterkinematic", "PxController.h"),
        path.join(physx_root, "include", "characterkinematic", "PxControllerBehavior.h"),
        path.join(physx_root, "include", "characterkinematic", "PxControllerManager.h"),
        path.join(physx_root, "include", "characterkinematic", "PxControllerObstacles.h"),
        path.join(physx_root, "include", "characterkinematic", "PxExtended.h"),

        path.join(physx_root, "source", "physxcharacterkinematic", "src", "CctBoxController.h"),
        path.join(physx_root, "source", "physxcharacterkinematic", "src", "CctCapsuleController.h"),
        path.join(physx_root, "source", "physxcharacterkinematic", "src", "CctCharacterController.h"),
        path.join(physx_root, "source", "physxcharacterkinematic", "src", "CctCharacterControllerManager.h"),
        path.join(physx_root, "source", "physxcharacterkinematic", "src", "CctController.h"),
        path.join(physx_root, "source", "physxcharacterkinematic", "src", "CctInternalStructs.h"),
        path.join(physx_root, "source", "physxcharacterkinematic", "src", "CctObstacleContext.h"),
        path.join(physx_root, "source", "physxcharacterkinematic", "src", "CctSweptBox.h"),
        path.join(physx_root, "source", "physxcharacterkinematic", "src", "CctSweptCapsule.h"),
        path.join(physx_root, "source", "physxcharacterkinematic", "src", "CctSweptVolume.h"),
        path.join(physx_root, "source", "physxcharacterkinematic", "src", "CctUtils.h")
    )
    add_files(
        path.join(physx_root, "source", "physxcharacterkinematic", "src", "CctBoxController.cpp"),
        path.join(physx_root, "source", "physxcharacterkinematic", "src", "CctCapsuleController.cpp"),
        path.join(physx_root, "source", "physxcharacterkinematic", "src", "CctCharacterController.cpp"),
        path.join(physx_root, "source", "physxcharacterkinematic", "src", "CctCharacterControllerCallbacks.cpp"),
        path.join(physx_root, "source", "physxcharacterkinematic", "src", "CctCharacterControllerManager.cpp"),
        path.join(physx_root, "source", "physxcharacterkinematic", "src", "CctController.cpp"),
        path.join(physx_root, "source", "physxcharacterkinematic", "src", "CctObstacleContext.cpp"),
        path.join(physx_root, "source", "physxcharacterkinematic", "src", "CctSweptBox.cpp"),
        path.join(physx_root, "source", "physxcharacterkinematic", "src", "CctSweptCapsule.cpp"),
        path.join(physx_root, "source", "physxcharacterkinematic", "src", "CctSweptVolume.cpp")
    )

    add_includedirs(
        path.join(physx_root, "include"),
        path.join(physx_root, "source", "common", "src"),
        path.join(physx_root, "source", "geomutils", "include")
    )

    add_deps("PhysXFoundation")

    on_load(fix_target)
target_end()

target("PhysXCommon")
    set_kind("static")
    add_headerfiles(
        path.join(physx_root, "source", "common", "src", "CmRenderBuffer.h"),
        path.join(physx_root, "source", "common", "src", "CmBlockArray.h"),
        path.join(physx_root, "source", "common", "src", "CmCollection.h"),
        path.join(physx_root, "source", "common", "src", "CmConeLimitHelper.h"),
        path.join(physx_root, "source", "common", "src", "CmFlushPool.h"),
        path.join(physx_root, "source", "common", "src", "CmIDPool.h"),
        path.join(physx_root, "source", "common", "src", "CmMatrix34.h"),
        path.join(physx_root, "source", "common", "src", "CmPool.h"),
        path.join(physx_root, "source", "common", "src", "CmPreallocatingPool.h"),
        path.join(physx_root, "source", "common", "src", "CmPriorityQueue.h"),
        path.join(physx_root, "source", "common", "src", "CmPtrTable.h"),
        path.join(physx_root, "source", "common", "src", "CmRadixSort.h"),
        path.join(physx_root, "source", "common", "src", "CmRandom.h"),
        path.join(physx_root, "source", "common", "src", "CmRefCountable.h"),
        path.join(physx_root, "source", "common", "src", "CmScaling.h"),
        path.join(physx_root, "source", "common", "src", "CmSerialize.h"),
        path.join(physx_root, "source", "common", "src", "CmSpatialVector.h"),
        path.join(physx_root, "source", "common", "src", "CmTask.h"),
        path.join(physx_root, "source", "common", "src", "CmTransformUtils.h"),
        path.join(physx_root, "source", "common", "src", "CmUtils.h"),
        path.join(physx_root, "source", "common", "src", "CmVisualization.h"),

        path.join(physx_root, "source", "common", "include", "omnipvd", "CmOmniPvdAutoGenClearDefines.h"),
        path.join(physx_root, "source", "common", "include", "omnipvd", "CmOmniPvdAutoGenCreateRegistrationStruct.h"),
        path.join(physx_root, "source", "common", "include", "omnipvd", "CmOmniPvdAutoGenRegisterData.h"),
        path.join(physx_root, "source", "common", "include", "omnipvd", "CmOmniPvdAutoGenSetData.h"),

        path.join(physx_root, "include", "common", "PxBase.h"),
        path.join(physx_root, "include", "common", "PxCollection.h"),
        path.join(physx_root, "include", "common", "PxCoreUtilityTypes.h"),
        path.join(physx_root, "include", "common", "PxMetaData.h"),
        path.join(physx_root, "include", "common", "PxMetaDataFlags.h"),
        path.join(physx_root, "include", "common", "PxInsertionCallback.h"),
        path.join(physx_root, "include", "common", "PxPhysXCommonConfig.h"),
        path.join(physx_root, "include", "common", "PxRenderBuffer.h"),
        path.join(physx_root, "include", "common", "PxRenderOutput.h"),
        path.join(physx_root, "include", "common", "PxSerialFramework.h"),
        path.join(physx_root, "include", "common", "PxSerializer.h"),
        path.join(physx_root, "include", "common", "PxStringTable.h"),
        path.join(physx_root, "include", "common", "PxTolerancesScale.h"),
        path.join(physx_root, "include", "common", "PxTypeInfo.h"),
        path.join(physx_root, "include", "common", "PxProfileZone.h"),

        path.join(physx_root, "include", "geometry", "PxBoxGeometry.h"),
        path.join(physx_root, "include", "geometry", "PxCapsuleGeometry.h"),
        path.join(physx_root, "include", "geometry", "PxConvexMesh.h"),
        path.join(physx_root, "include", "geometry", "PxConvexMeshGeometry.h"),
        path.join(physx_root, "include", "geometry", "PxCustomGeometry.h"),
        path.join(physx_root, "include", "geometry", "PxGeometry.h"),
        path.join(physx_root, "include", "geometry", "PxGeometryInternal.h"),
        path.join(physx_root, "include", "geometry", "PxGeometryHelpers.h"),
        path.join(physx_root, "include", "geometry", "PxGeometryHit.h"),
        path.join(physx_root, "include", "geometry", "PxGeometryQuery.h"),
        path.join(physx_root, "include", "geometry", "PxGeometryQueryFlags.h"),
        path.join(physx_root, "include", "geometry", "PxGeometryQueryContext.h"),
        path.join(physx_root, "include", "geometry", "PxHairSystemDesc.h"),
        path.join(physx_root, "include", "geometry", "PxHairSystemGeometry.h"),
        path.join(physx_root, "include", "geometry", "PxHeightField.h"),
        path.join(physx_root, "include", "geometry", "PxHeightFieldDesc.h"),
        path.join(physx_root, "include", "geometry", "PxHeightFieldFlag.h"),
        path.join(physx_root, "include", "geometry", "PxHeightFieldGeometry.h"),
        path.join(physx_root, "include", "geometry", "PxHeightFieldSample.h"),
        path.join(physx_root, "include", "geometry", "PxMeshQuery.h"),
        path.join(physx_root, "include", "geometry", "PxMeshScale.h"),
        path.join(physx_root, "include", "geometry", "PxPlaneGeometry.h"),
        path.join(physx_root, "include", "geometry", "PxReportCallback.h"),
        path.join(physx_root, "include", "geometry", "PxSimpleTriangleMesh.h"),
        path.join(physx_root, "include", "geometry", "PxSphereGeometry.h"),
        path.join(physx_root, "include", "geometry", "PxTriangle.h"),
        path.join(physx_root, "include", "geometry", "PxTriangleMesh.h"),
        path.join(physx_root, "include", "geometry", "PxTriangleMeshGeometry.h"),
        path.join(physx_root, "include", "geometry", "PxBVH.h"),
        path.join(physx_root, "include", "geometry", "PxBVHBuildStrategy.h"),
        path.join(physx_root, "include", "geometry", "PxTetrahedron.h"),
        path.join(physx_root, "include", "geometry", "PxTetrahedronMesh.h"),
        path.join(physx_root, "include", "geometry", "PxTetrahedronMeshGeometry.h"),
        path.join(physx_root, "include", "geometry", "PxParticleSystemGeometry.h"),
        path.join(physx_root, "include", "geometry", "PxGjkQuery.h"),

        path.join(physx_root, "include", "geomutils", "PxContactBuffer.h"),
        path.join(physx_root, "include", "geomutils", "PxContactPoint.h"),

        path.join(physx_root, "include", "collision", "PxCollisionDefs.h"),

        path.join(physx_root, "source", "geomutils", "include", "GuBox.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuSphere.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuSegment.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuCapsule.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuCenterExtents.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuBounds.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuDistanceSegmentBox.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuDistanceSegmentSegment.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuIntersectionBoxBox.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuIntersectionTetrahedronBox.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuIntersectionTriangleBoxRef.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuIntersectionTriangleTriangle.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuRaycastTests.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuOverlapTests.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuSweepTests.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuCachedFuncs.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuPruner.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuPrunerTypedef.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuPrunerPayload.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuPrunerMergeData.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuSqInternal.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuActorShapeMap.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuQuerySystem.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuFactory.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuDistancePointTetrahedron.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuDistancePointTriangle.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuIntersectionTriangleBox.h"),
        path.join(physx_root, "source", "geomutils", "include", "GuCooking.h"),

        path.join(physx_root, "source", "geomutils", "src", "GuGeometryChecks.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuInternal.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuMeshFactory.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuMTD.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuSweepMTD.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuSweepSharedTests.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuSDF.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuSDF.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuCookingSDF.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuWindingNumber.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuWindingNumberCluster.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuWindingNumberT.h"),

        path.join(physx_root, "source", "geomutils", "src", "ccd", "GuCCDSweepConvexMesh.h"),

        path.join(physx_root, "source", "geomutils", "src", "common", "GuBarycentricCoordinates.h"),
        path.join(physx_root, "source", "geomutils", "src", "common", "GuBoxConversion.h"),
        path.join(physx_root, "source", "geomutils", "src", "common", "GuEdgeCache.h"),
        path.join(physx_root, "source", "geomutils", "src", "common", "GuAdjacencies.h"),
        path.join(physx_root, "source", "geomutils", "src", "common", "GuEdgeList.h"),
        path.join(physx_root, "source", "geomutils", "src", "common", "GuSeparatingAxes.h"),
        path.join(physx_root, "source", "geomutils", "src", "common", "GuQuantizer.h"),
        path.join(physx_root, "source", "geomutils", "src", "common", "GuMeshCleaner.h"),
        path.join(physx_root, "source", "geomutils", "src", "common", "GuVertexReducer.h"),
        path.join(physx_root, "source", "geomutils", "src", "common", "GuMeshAnalysis.h"),

        path.join(physx_root, "source", "geomutils", "src", "contact", "GuContactMethodImpl.h"),
        path.join(physx_root, "source", "geomutils", "src", "contact", "GuContactPolygonPolygon.h"),

        path.join(physx_root, "source", "geomutils", "src", "convex", "GuBigConvexData.h"),
        path.join(physx_root, "source", "geomutils", "src", "convex", "GuBigConvexData2.h"),
        path.join(physx_root, "source", "geomutils", "src", "convex", "GuConvexEdgeFlags.h"),
        path.join(physx_root, "source", "geomutils", "src", "convex", "GuConvexHelper.h"),
        path.join(physx_root, "source", "geomutils", "src", "convex", "GuConvexMesh.h"),
        path.join(physx_root, "source", "geomutils", "src", "convex", "GuConvexMeshData.h"),
        path.join(physx_root, "source", "geomutils", "src", "convex", "GuConvexSupportTable.h"),
        path.join(physx_root, "source", "geomutils", "src", "convex", "GuConvexUtilsInternal.h"),
        path.join(physx_root, "source", "geomutils", "src", "convex", "GuCubeIndex.h"),
        path.join(physx_root, "source", "geomutils", "src", "convex", "GuHillClimbing.h"),
        path.join(physx_root, "source", "geomutils", "src", "convex", "GuShapeConvex.h"),
        path.join(physx_root, "source", "geomutils", "src", "contact", "GuFeatureCode.h"),

        path.join(physx_root, "source", "geomutils", "src", "distance", "GuDistancePointBox.h"),
        path.join(physx_root, "source", "geomutils", "src", "distance", "GuDistancePointSegment.h"),
        path.join(physx_root, "source", "geomutils", "src", "distance", "GuDistanceSegmentTriangle.h"),
        path.join(physx_root, "source", "geomutils", "src", "distance", "GuDistanceTriangleTriangle.h"),
        path.join(physx_root, "source", "geomutils", "src", "distance", "GuDistancePointTetrahedron.h"),

        path.join(physx_root, "source", "geomutils", "src", "gjk", "GuEPA.h"),
        path.join(physx_root, "source", "geomutils", "src", "gjk", "GuEPAFacet.h"),
        path.join(physx_root, "source", "geomutils", "src", "gjk", "GuGJK.h"),
        path.join(physx_root, "source", "geomutils", "src", "gjk", "GuGJKPenetration.h"),
        path.join(physx_root, "source", "geomutils", "src", "gjk", "GuGJKRaycast.h"),
        path.join(physx_root, "source", "geomutils", "src", "gjk", "GuGJKSimplex.h"),
        path.join(physx_root, "source", "geomutils", "src", "gjk", "GuGJKTest.h"),
        path.join(physx_root, "source", "geomutils", "src", "gjk", "GuGJKType.h"),
        path.join(physx_root, "source", "geomutils", "src", "gjk", "GuGJKUtil.h"),
        path.join(physx_root, "source", "geomutils", "src", "gjk", "GuVecBox.h"),
        path.join(physx_root, "source", "geomutils", "src", "gjk", "GuVecCapsule.h"),
        path.join(physx_root, "source", "geomutils", "src", "gjk", "GuVecConvex.h"),
        path.join(physx_root, "source", "geomutils", "src", "gjk", "GuVecConvexHull.h"),
        path.join(physx_root, "source", "geomutils", "src", "gjk", "GuVecConvexHullNoScale.h"),
        path.join(physx_root, "source", "geomutils", "src", "gjk", "GuVecPlane.h"),
        path.join(physx_root, "source", "geomutils", "src", "gjk", "GuVecSphere.h"),
        path.join(physx_root, "source", "geomutils", "src", "gjk", "GuVecTriangle.h"),
        path.join(physx_root, "source", "geomutils", "src", "gjk", "GuVecTetrahedron.h"),

        path.join(physx_root, "source", "geomutils", "src", "hf", "GuEntityReport.h"),
        path.join(physx_root, "source", "geomutils", "src", "hf", "GuHeightField.h"),
        path.join(physx_root, "source", "geomutils", "src", "hf", "GuHeightFieldData.h"),
        path.join(physx_root, "source", "geomutils", "src", "hf", "GuHeightFieldUtil.h"),

        path.join(physx_root, "source", "geomutils", "src", "intersection", "GuIntersectionCapsuleTriangle.h"),
        path.join(physx_root, "source", "geomutils", "src", "intersection", "GuIntersectionEdgeEdge.h"),
        path.join(physx_root, "source", "geomutils", "src", "intersection", "GuIntersectionRay.h"),
        path.join(physx_root, "source", "geomutils", "src", "intersection", "GuIntersectionRayBox.h"),
        path.join(physx_root, "source", "geomutils", "src", "intersection", "GuIntersectionRayCapsule.h"),
        path.join(physx_root, "source", "geomutils", "src", "intersection", "GuIntersectionRayPlane.h"),
        path.join(physx_root, "source", "geomutils", "src", "intersection", "GuIntersectionRaySphere.h"),
        path.join(physx_root, "source", "geomutils", "src", "intersection", "GuIntersectionRayTriangle.h"),
        path.join(physx_root, "source", "geomutils", "src", "intersection", "GuIntersectionSphereBox.h"),

        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV32.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV32Build.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4Build.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4Settings.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_AABBAABBSweepTest.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_BoxBoxOverlapTest.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_BoxOverlap_Internal.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_BoxSweep_Internal.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_BoxSweep_Params.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_CapsuleSweep_Internal.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_Common.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_Internal.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_ProcessStreamNoOrder_OBBOBB.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_ProcessStreamNoOrder_SegmentAABB.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_ProcessStreamNoOrder_SegmentAABB_Inflated.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_ProcessStreamNoOrder_SphereAABB.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_ProcessStreamOrdered_OBBOBB.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_ProcessStreamOrdered_SegmentAABB.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_ProcessStreamOrdered_SegmentAABB_Inflated.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_Slabs.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_Slabs_KajiyaNoOrder.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_Slabs_KajiyaOrdered.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_Slabs_SwizzledNoOrder.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_Slabs_SwizzledOrdered.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBVConstants.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuMeshData.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuMidphaseInterface.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuRTree.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuSweepConvexTri.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuSweepMesh.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuTriangle.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuTriangleCache.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuTriangleMesh.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuTriangleMeshBV4.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuTriangleMeshRTree.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuTetrahedron.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuTetrahedronMesh.h"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuTetrahedronMeshUtils.h"),

        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactConvexCommon.h"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactGen.h"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactGenUtil.h"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactMeshCallback.h"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMShapeConvex.h"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMTriangleContactGen.h"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPersistentContactManifold.h"),

        path.join(physx_root, "source", "geomutils", "src", "sweep", "GuSweepBoxBox.h"),
        path.join(physx_root, "source", "geomutils", "src", "sweep", "GuSweepBoxSphere.h"),
        path.join(physx_root, "source", "geomutils", "src", "sweep", "GuSweepBoxTriangle_FeatureBased.h"),
        path.join(physx_root, "source", "geomutils", "src", "sweep", "GuSweepBoxTriangle_SAT.h"),
        path.join(physx_root, "source", "geomutils", "src", "sweep", "GuSweepCapsuleBox.h"),
        path.join(physx_root, "source", "geomutils", "src", "sweep", "GuSweepCapsuleCapsule.h"),
        path.join(physx_root, "source", "geomutils", "src", "sweep", "GuSweepCapsuleTriangle.h"),
        path.join(physx_root, "source", "geomutils", "src", "sweep", "GuSweepSphereCapsule.h"),
        path.join(physx_root, "source", "geomutils", "src", "sweep", "GuSweepSphereSphere.h"),
        path.join(physx_root, "source", "geomutils", "src", "sweep", "GuSweepSphereTriangle.h"),
        path.join(physx_root, "source", "geomutils", "src", "sweep", "GuSweepTriangleUtils.h"),

        path.join(physx_root, "source", "geomutils", "src", "GuQuery.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuAABBTree.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuAABBTreeUpdateMap.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuAABBTreeBounds.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuAABBTreeNode.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuAABBTreeBuildStats.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuAABBTreeQuery.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuIncrementalAABBTree.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuSAH.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuBVH.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuBVHTestsSIMD.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuIncrementalAABBPrunerCore.h")
    )
    add_headerfiles(
        path.join(physx_root, "source", "geomutils", "src", "GuIncrementalAABBPruner.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuPruningPool.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuBucketPruner.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuMaverickNode.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuExtendedBucketPruner.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuSecondaryPruner.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuAABBPruner.h"),
        path.join(physx_root, "source", "geomutils", "src", "GuCallbackAdapter.h"),

        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingGrbTriangleMesh.h"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingTriangleMesh.h"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingTetrahedronMesh.h"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingVolumeIntegration.h"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingQuickHullConvexHullLib.h"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingConvexPolygonsBuilder.h"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingConvexHullUtils.h"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingConvexHullLib.h"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingConvexHullBuilder.h"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingBigConvexDataBuilder.h"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingConvexMeshBuilder.h"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuRTreeCooking.h")
    )
    add_files(
        path.join(physx_root, "source", "common", "src", "CmPtrTable.cpp"),
        path.join(physx_root, "source", "common", "src", "CmCollection.cpp"),
        path.join(physx_root, "source", "common", "src", "CmRadixSort.cpp"),
        path.join(physx_root, "source", "common", "src", "CmSerialize.cpp"),
        path.join(physx_root, "source", "common", "src", "CmVisualization.cpp"),

        path.join(physx_root, "source", "geomutils", "src", "GuBox.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuCapsule.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuCCTSweepTests.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuGeometryQuery.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuInternal.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuMeshFactory.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuMetaData.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuMTD.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuOverlapTests.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuRaycastTests.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuSweepMTD.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuSweepSharedTests.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuSweepTests.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuCookingSDF.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuGjkQuery.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuWindingNumber.cpp"),

        path.join(physx_root, "source", "geomutils", "src", "ccd", "GuCCDSweepConvexMesh.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "ccd", "GuCCDSweepPrimitives.cpp"),

        path.join(physx_root, "source", "geomutils", "src", "common", "GuBarycentricCoordinates.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "common", "GuAdjacencies.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "common", "GuEdgeList.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "common", "GuSeparatingAxes.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "common", "GuQuantizer.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "common", "GuMeshCleaner.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "common", "GuVertexReducer.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "common", "GuMeshAnalysis.cpp"),

        path.join(physx_root, "source", "geomutils", "src", "contact", "GuContactBoxBox.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "contact", "GuContactCapsuleBox.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "contact", "GuContactCapsuleCapsule.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "contact", "GuContactCapsuleConvex.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "contact", "GuContactCapsuleMesh.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "contact", "GuContactConvexConvex.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "contact", "GuContactConvexMesh.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "contact", "GuContactPlaneBox.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "contact", "GuContactPlaneCapsule.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "contact", "GuContactPlaneConvex.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "contact", "GuContactPolygonPolygon.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "contact", "GuContactSphereBox.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "contact", "GuContactSphereCapsule.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "contact", "GuContactSphereMesh.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "contact", "GuContactSpherePlane.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "contact", "GuContactSphereSphere.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "contact", "GuContactCustomGeometry.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "contact", "GuFeatureCode.cpp"),

        path.join(physx_root, "source", "geomutils", "src", "convex", "GuBigConvexData.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "convex", "GuConvexHelper.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "convex", "GuConvexMesh.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "convex", "GuConvexSupportTable.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "convex", "GuConvexUtilsInternal.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "convex", "GuHillClimbing.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "convex", "GuShapeConvex.cpp"),

        path.join(physx_root, "source", "geomutils", "src", "distance", "GuDistancePointBox.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "distance", "GuDistancePointTriangle.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "distance", "GuDistanceSegmentBox.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "distance", "GuDistanceSegmentSegment.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "distance", "GuDistanceSegmentTriangle.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "distance", "GuDistanceTriangleTriangle.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "distance", "GuDistancePointTetrahedron.cpp"),

        path.join(physx_root, "source", "geomutils", "src", "gjk", "GuEPA.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "gjk", "GuGJKSimplex.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "gjk", "GuGJKTest.cpp"),

        path.join(physx_root, "source", "geomutils", "src", "hf", "GuHeightField.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "hf", "GuHeightFieldUtil.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "hf", "GuOverlapTestsHF.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "hf", "GuSweepsHF.cpp"),

        path.join(physx_root, "source", "geomutils", "src", "intersection", "GuIntersectionBoxBox.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "intersection", "GuIntersectionCapsuleTriangle.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "intersection", "GuIntersectionEdgeEdge.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "intersection", "GuIntersectionRayBox.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "intersection", "GuIntersectionRayCapsule.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "intersection", "GuIntersectionRaySphere.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "intersection", "GuIntersectionSphereBox.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "intersection", "GuIntersectionTetrahedronBox.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "intersection", "GuIntersectionTriangleBox.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "intersection", "GuIntersectionTriangleTriangle.cpp"),

        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_AABBSweep.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_BoxOverlap.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_CapsuleSweep.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_CapsuleSweepAA.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_MeshMeshOverlap.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_OBBSweep.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_Raycast.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_SphereOverlap.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4_SphereSweep.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuMidphaseBV4.cpp"),

        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV4Build.cpp"),

        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuMeshQuery.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuMidphaseRTree.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuOverlapTestsMesh.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuRTree.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuRTreeQueries.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuSweepsMesh.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuTriangleMesh.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuTriangleMeshBV4.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuTriangleMeshRTree.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV32.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuBV32Build.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuTetrahedronMesh.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "mesh", "GuTetrahedronMeshUtils.cpp"),

        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactBoxBox.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactBoxConvex.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactCapsuleBox.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactCapsuleCapsule.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactCapsuleConvex.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactCapsuleHeightField.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactCapsuleMesh.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactConvexCommon.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactConvexConvex.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactConvexHeightField.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactConvexMesh.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactGenBoxConvex.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactGenSphereCapsule.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactPlaneBox.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactPlaneCapsule.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactPlaneConvex.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactSphereBox.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactSphereCapsule.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactSphereConvex.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactSphereHeightField.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactSphereMesh.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactSpherePlane.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactSphereSphere.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactCustomGeometry.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMShapeConvex.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMTriangleContactGen.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPersistentContactManifold.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "pcm", "GuPCMContactGenUtil.cpp"),

        path.join(physx_root, "source", "geomutils", "src", "sweep", "GuSweepBoxBox.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "sweep", "GuSweepBoxSphere.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "sweep", "GuSweepBoxTriangle_FeatureBased.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "sweep", "GuSweepBoxTriangle_SAT.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "sweep", "GuSweepCapsuleBox.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "sweep", "GuSweepCapsuleCapsule.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "sweep", "GuSweepCapsuleTriangle.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "sweep", "GuSweepSphereCapsule.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "sweep", "GuSweepSphereSphere.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "sweep", "GuSweepSphereTriangle.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "sweep", "GuSweepTriangleUtils.cpp"),

        path.join(physx_root, "source", "geomutils", "src", "GuBounds.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuAABBTree.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuAABBTreeUpdateMap.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuSqInternal.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuIncrementalAABBTree.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuSAH.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuBVH.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuIncrementalAABBPrunerCore.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuIncrementalAABBPruner.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuPruningPool.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuBucketPruner.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuMaverickNode.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuExtendedBucketPruner.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuSecondaryPruner.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuAABBPruner.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuActorShapeMap.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuQuerySystem.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "GuFactory.cpp"),

        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuRTreeCooking.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingBVH.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingHF.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingConvexMesh.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingTriangleMesh.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingTetrahedronMesh.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingVolumeIntegration.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingQuickHullConvexHullLib.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingConvexPolygonsBuilder.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingConvexMeshBuilder.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingConvexHullUtils.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingConvexHullLib.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingConvexHullBuilder.cpp"),
        path.join(physx_root, "source", "geomutils", "src", "cooking", "GuCookingBigConvexDataBuilder.cpp")
    )

    add_includedirs(
        path.join(physx_root, "include"),

        path.join(physx_root, "source", "common", "include"),
        path.join(physx_root, "source", "common", "src"),

        path.join(physx_root, "source", "geomutils", "include"),
        path.join(physx_root, "source", "geomutils", "src"),
        path.join(physx_root, "source", "geomutils", "src", "contact"),
        path.join(physx_root, "source", "geomutils", "src", "common"),
        path.join(physx_root, "source", "geomutils", "src", "convex"),
        path.join(physx_root, "source", "geomutils", "src", "distance"),
        path.join(physx_root, "source", "geomutils", "src", "sweep"),
        path.join(physx_root, "source", "geomutils", "src", "gjk"),
        path.join(physx_root, "source", "geomutils", "src", "intersection"),
        path.join(physx_root, "source", "geomutils", "src", "mesh"),
        path.join(physx_root, "source", "geomutils", "src", "hf"),
        path.join(physx_root, "source", "geomutils", "src", "pcm"),
        path.join(physx_root, "source", "geomutils", "src", "ccd")
    )

    add_deps("PhysXFoundation")

    on_load(fix_target)
target_end()

target("PhysXCooking")
    set_kind("static")
    add_headerfiles(
        path.join(physx_root, "include", "cooking", "PxBVH33MidphaseDesc.h"),
        path.join(physx_root, "include", "cooking", "PxBVH34MidphaseDesc.h"),
        path.join(physx_root, "include", "cooking", "Pxc.h"),
        path.join(physx_root, "include", "cooking", "PxConvexMeshDesc.h"),
        path.join(physx_root, "include", "cooking", "PxCooking.h"),
        path.join(physx_root, "include", "cooking", "PxCookingInternal.h"),
        path.join(physx_root, "include", "cooking", "PxMidphaseDesc.h"),
        path.join(physx_root, "include", "cooking", "PxTriangleMeshDesc.h"),
        path.join(physx_root, "include", "cooking", "PxTetrahedronMeshDesc.h"),
        path.join(physx_root, "include", "cooking", "PxBVHDesc.h"),
        path.join(physx_root, "include", "cooking", "PxTetrahedronMeshDesc.h"),
        path.join(physx_root, "include", "cooking", "PxSDFDesc.h"),
        path.join(physx_root, "source", "physxcooking", "src", "Cooking.h")
    )
    add_files(
        path.join(physx_root, "source", "physxcooking", "src", "Cooking.cpp")
    )

    add_includedirs(
        path.join(physx_root, "include"),

        path.join(physx_root, "source", "common", "include"),
        path.join(physx_root, "source", "common", "src"),

        path.join(physx_root, "source", "geomutils", "include"),
        path.join(physx_root, "source", "geomutils", "src"),
        path.join(physx_root, "source", "geomutils", "src", "mesh")
    )

    add_deps("PhysXCommon", "PhysXFoundation")

    on_load(fix_target)
target_end()

target("PhysXExtensions")
    set_kind("static")
    add_headerfiles(
        path.join(physx_root, "source", "physxextensions", "src", "ExtSqQuery.h"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtSqManager.h"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtCpuWorkerThread.h"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtDefaultCpuDispatcher.h"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtInertiaTensor.h"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtPlatform.h"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtPvd.h"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtSerialization.h"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtSharedQueueEntryPool.h"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtTaskQueueHelper.h"),

        path.join(physx_root, "source", "physxextensions", "src", "ExtGearJoint.h"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtRackAndPinionJoint.h"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtConstraintHelper.h"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtD6Joint.h"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtDistanceJoint.h"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtContactJoint.h"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtFixedJoint.h"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtJoint.h"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtJointData.h"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtJointMetaDataExtensions.h"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtPrismaticJoint.h"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtRevoluteJoint.h"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtSphericalJoint.h"),

        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtTetUnionFind.h"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtDelaunayBoundaryInserter.h"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtDelaunayTetrahedralizer.h"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtVec3.h"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtTetSplitting.h"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtFastWindingNumber.h"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtRandomAccessHeap.h"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtQuadric.h"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtMeshSimplificator.h"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtBVH.h"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtRemesher.h"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtMarchingCubesTable.h"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtMultiList.h"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtInsideTester.h"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtOctreeTetrahedralizer.h"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtVoxelTetrahedralizer.h"),

        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtUtilities.h"),

        path.join(physx_root, "source", "physxmetadata", "extensions", "include", "PxExtensionAutoGeneratedMetaDataObjectNames.h"),
        path.join(physx_root, "source", "physxmetadata", "extensions", "include", "PxExtensionAutoGeneratedMetaDataObjects.h"),
        path.join(physx_root, "source", "physxmetadata", "extensions", "include", "PxExtensionMetaDataObjects.h"),
        path.join(physx_root, "source", "physxextensions", "src", "omnipvd", "ExtOmniPvdRegistrationData.h"),
        path.join(physx_root, "source", "physxextensions", "src", "omnipvd", "ExtOmniPvdSetData.h"),
        path.join(physx_root, "source", "physxextensions", "src", "omnipvd", "OmniPvdPxExtensionsTypes.h"),
        path.join(physx_root, "source", "physxextensions", "src", "omnipvd", "OmniPvdPxExtensionsSampler.h"),

        path.join(physx_root, "include", "extensions", "PxBinaryConverter.h"),
        path.join(physx_root, "include", "extensions", "PxBroadPhaseExt.h"),
        path.join(physx_root, "include", "extensions", "PxCollectionExt.h"),
        path.join(physx_root, "include", "extensions", "PxConvexMeshExt.h"),
        path.join(physx_root, "include", "extensions", "PxDefaultAllocator.h"),
        path.join(physx_root, "include", "extensions", "PxDefaultCpuDispatcher.h"),
        path.join(physx_root, "include", "extensions", "PxDefaultErrorCallback.h"),
        path.join(physx_root, "include", "extensions", "PxDefaultSimulationFilterShader.h"),
        path.join(physx_root, "include", "extensions", "PxDefaultStreams.h"),
        path.join(physx_root, "include", "extensions", "PxExtensionsAPI.h"),
        path.join(physx_root, "include", "extensions", "PxMassProperties.h"),
        path.join(physx_root, "include", "extensions", "PxRaycastCCD.h"),
        path.join(physx_root, "include", "extensions", "PxRepXSerializer.h"),
        path.join(physx_root, "include", "extensions", "PxRepXSimpleType.h"),
        path.join(physx_root, "include", "extensions", "PxRigidActorExt.h"),
        path.join(physx_root, "include", "extensions", "PxRigidBodyExt.h"),
        path.join(physx_root, "include", "extensions", "PxSceneQueryExt.h"),
        path.join(physx_root, "include", "extensions", "PxSceneQuerySystemExt.h"),
        path.join(physx_root, "include", "extensions", "PxCustomSceneQuerySystem.h"),
        path.join(physx_root, "include", "extensions", "PxSerialization.h"),
        path.join(physx_root, "include", "extensions", "PxShapeExt.h"),
        path.join(physx_root, "include", "extensions", "PxSimpleFactory.h"),
        path.join(physx_root, "include", "extensions", "PxSmoothNormals.h"),
        path.join(physx_root, "include", "extensions", "PxSoftBodyExt.h"),
        path.join(physx_root, "include", "extensions", "PxStringTableExt.h"),
        path.join(physx_root, "include", "extensions", "PxTriangleMeshExt.h"),
        path.join(physx_root, "include", "extensions", "PxTetrahedronMeshExt.h"),
        path.join(physx_root, "include", "extensions", "PxRemeshingExt.h"),
        path.join(physx_root, "include", "extensions", "PxTriangleMeshAnalysisResult.h"),
        path.join(physx_root, "include", "extensions", "PxTetrahedronMeshAnalysisResult.h"),
        path.join(physx_root, "include", "extensions", "PxTetMakerExt.h"),
        path.join(physx_root, "include", "extensions", "PxGjkQueryExt.h"),
        path.join(physx_root, "include", "extensions", "PxCustomGeometryExt.h"),
        path.join(physx_root, "include", "extensions", "PxSamplingExt.h"),

        path.join(physx_root, "include", "extensions", "PxParticleClothCooker.h"),
        path.join(physx_root, "include", "extensions", "PxParticleExt.h"),
        path.join(physx_root, "include", "extensions", "PxFEMClothExt.h"),

        path.join(physx_root, "include", "extensions", "PxConstraintExt.h"),
        path.join(physx_root, "include", "extensions", "PxContactJoint.h"),
        path.join(physx_root, "include", "extensions", "PxD6Joint.h"),
        path.join(physx_root, "include", "extensions", "PxD6JointCreate.h"),
        path.join(physx_root, "include", "extensions", "PxDistanceJoint.h"),
        path.join(physx_root, "include", "extensions", "PxContactJoint.h"),
        path.join(physx_root, "include", "extensions", "PxFixedJoint.h"),
        path.join(physx_root, "include", "extensions", "PxGearJoint.h"),
        path.join(physx_root, "include", "extensions", "PxRackAndPinionJoint.h"),
        path.join(physx_root, "include", "extensions", "PxJoint.h"),
        path.join(physx_root, "include", "extensions", "PxJointLimit.h"),
--        path.join(physx_root, "include", "extensions", "PxJointRepXSerializer.h"),
        path.join(physx_root, "include", "extensions", "PxPrismaticJoint.h"),
        path.join(physx_root, "include", "extensions", "PxRevoluteJoint.h"),
        path.join(physx_root, "include", "extensions", "PxSphericalJoint.h"),

        path.join(physx_root, "include", "filebuf", "PxFileBuf.h"),

        path.join(physx_root, "source", "physxextensions", "src", "serialization", "SnSerializationRegistry.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "SnSerialUtils.h"),

        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnJointRepXSerializer.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnPxStreamOperators.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnRepX1_0Defaults.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnRepX3_1Defaults.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnRepX3_2Defaults.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnRepXCollection.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnRepXCoreSerializer.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnRepXSerializerImpl.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnRepXUpgrader.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnSimpleXmlWriter.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnXmlDeserializer.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnXmlImpl.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnXmlMemoryAllocator.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnXmlMemoryPool.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnXmlMemoryPoolStreams.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnXmlReader.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnXmlSerializer.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnXmlSimpleXmlWriter.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnXmlStringToType.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnXmlVisitorReader.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnXmlVisitorWriter.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnXmlWriter.h"),

        path.join(physx_root, "source", "physxextensions", "src", "serialization", "File", "SnFile.h"),

        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Binary", "SnConvX.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Binary", "SnConvX_Align.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Binary", "SnConvX_Common.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Binary", "SnConvX_MetaData.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Binary", "SnConvX_Output.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Binary", "SnConvX_Union.h"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Binary", "SnSerializationContext.h")
    )
    add_files(
        path.join(physx_root, "source", "physxextensions", "src", "ExtBroadPhase.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtCollection.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtConvexMeshExt.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtCpuWorkerThread.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtDefaultCpuDispatcher.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtDefaultErrorCallback.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtDefaultSimulationFilterShader.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtDefaultStreams.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtExtensions.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtMetaData.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtPvd.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtPxStringTable.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtRaycastCCD.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtRigidBodyExt.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtRigidActorExt.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtSceneQueryExt.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtSceneQuerySystem.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtCustomSceneQuerySystem.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtSqQuery.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtSqManager.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtSimpleFactory.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtSmoothNormals.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtSoftBodyExt.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtTriangleMeshExt.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtTetrahedronMeshExt.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtRemeshingExt.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtSampling.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtTetMakerExt.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtGjkQueryExt.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtCustomGeometryExt.cpp"),

        path.join(physx_root, "source", "physxextensions", "src", "ExtParticleExt.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtParticleClothCooker.cpp"),
        --path.join(physx_root, "source", "physxextensions", "src", "ExtFEMClothExt.cpp"),

        path.join(physx_root, "source", "physxextensions", "src", "ExtGearJoint.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtRackAndPinionJoint.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtD6Joint.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtD6JointCreate.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtDistanceJoint.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtContactJoint.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtFixedJoint.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtJoint.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtPrismaticJoint.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtRevoluteJoint.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "ExtSphericalJoint.cpp"),

        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtUtilities.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtTetUnionFind.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtDelaunayBoundaryInserter.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtDelaunayTetrahedralizer.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtTetSplitting.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtFastWindingNumber.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtMeshSimplificator.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtBVH.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtRemesher.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtInsideTester.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtOctreeTetrahedralizer.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "tet", "ExtVoxelTetrahedralizer.cpp"),

        path.join(physx_root, "source", "physxmetadata", "extensions", "src", "PxExtensionAutoGeneratedMetaDataObjects.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "omnipvd", "ExtOmniPvdRegistrationData.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "omnipvd", "OmniPvdPxExtensionsSampler.cpp"),

        path.join(physx_root, "source", "physxextensions", "src", "serialization", "SnSerialization.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "SnSerializationRegistry.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "SnSerialUtils.cpp"),

        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnJointRepXSerializer.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnRepXCoreSerializer.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnRepXUpgrader.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml", "SnXmlSerialization.cpp"),

        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Binary", "SnBinaryDeserialization.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Binary", "SnBinarySerialization.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Binary", "SnConvX.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Binary", "SnConvX_Align.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Binary", "SnConvX_Convert.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Binary", "SnConvX_Error.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Binary", "SnConvX_MetaData.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Binary", "SnConvX_Output.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Binary", "SnConvX_Union.cpp"),
        path.join(physx_root, "source", "physxextensions", "src", "serialization", "Binary", "SnSerializationContext.cpp")
    )

    add_includedirs(
       path.join(physx_root, "include"),

       path.join(physx_root, "source", "common", "include"),
       path.join(physx_root, "source", "common", "src"),

       path.join(physx_root, "source", "geomutils", "include"),
       path.join(physx_root, "source", "geomutils", "src"),
       path.join(physx_root, "source", "geomutils", "src", "intersection"),
       path.join(physx_root, "source", "geomutils", "src", "mesh"),

       path.join(physx_root, "source", "physxmetadata", "core", "include"),
       path.join(physx_root, "source", "physxmetadata", "extensions", "include"),

       path.join(physx_root, "source", "physxextensions", "src"),
       path.join(physx_root, "source", "physxextensions", "src", "serialization", "Xml"),
       path.join(physx_root, "source", "physxextensions", "src", "serialization", "Binary"),
       path.join(physx_root, "source", "physxextensions", "src", "serialization", "File"),

       path.join(physx_root, "source", "physx", "src"),

       path.join(physx_root, "source", "pvd", "include"),

       path.join(physx_root, "source", "scenequery", "include"),

       path.join(physx_root, "source", "fastxml", "include")
    )

    add_deps(
        "PhysXFoundation",
        --"PhysXPvdSDK",
        "PhysX"
    )
target_end()
