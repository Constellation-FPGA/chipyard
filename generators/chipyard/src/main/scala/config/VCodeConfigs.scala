package chipyard

import org.chipsalliance.cde.config.{Config}

// --------------
// Rocket+VCode Configs
// --------------

// DOC include start: VCodeRocket
class VCodeRocketConfig extends Config(
  new vcoderocc.WithVCodeAccel ++
  new freechips.rocketchip.rocket.WithNBigCores(1) ++
  new chipyard.config.AbstractConfig)
// DOC include end: VCodeRocket

// DOC include start: BigVCodeRocket
class BigVCodeRocketConfig extends Config(
  new vcoderocc.WithVCodeAccel(8) ++
  new freechips.rocketchip.rocket.WithNBigCores(1) ++
  new chipyard.config.AbstractConfig)
// DOC include end: BigVCodeRocket

/* These classes are identical to the regular VCodeRocketConfig classes, but
 * include synthesizing printf calls in the VCode RoCC accelerator for debugging.
 */

class VCodeRocketPrintfConfig extends Config(
  new vcoderocc.WithVCodePrintf ++
  new VCodeRocketConfig)

class BigVCodeRocketPrintfConfig extends Config(
  new vcoderocc.WithVCodePrintf ++
  new BigVCodeRocketConfig)
