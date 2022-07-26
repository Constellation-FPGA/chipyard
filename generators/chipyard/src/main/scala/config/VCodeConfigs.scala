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
