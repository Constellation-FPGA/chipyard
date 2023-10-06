package chipyard

import freechips.rocketchip.config.{Config}
import freechips.rocketchip.diplomacy.{AsynchronousCrossing}

// --------------
// Rocket+VCode Configs
// --------------

// DOC include start: VCodeRocket
class VCodeRocketConfig extends Config(
  new vcoderocc.WithVCodeAccel ++
  new freechips.rocketchip.subsystem.WithNBigCores(1) ++
  new chipyard.config.AbstractConfig)
// DOC include end: VCodeRocket

/** This class is identical to the VCodeRocketConfig class, but includes
  * synthesizing printf calls in the VCode RoCC accelerator for debugging.
  */
class VCodeRocketPrintfConfig extends Config(
  new vcoderocc.WithVCodePrintf ++
  new VCodeRocketConfig)
