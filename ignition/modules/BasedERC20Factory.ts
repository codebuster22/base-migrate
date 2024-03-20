import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
import BasedMigrateERC20Module from "./BasedMigrateERC20";

const CONTRACT_NAME = "BasedERC20Factory";
const BRIDGE = "0x4200000000000000000000000000000000000010";

const BasedERC20FactoryModule = buildModule("BasedERC20FactoryModule", (m) => {
  const { basedERC20 } = m.useModule(BasedMigrateERC20Module);

  const factory = m.contract(CONTRACT_NAME, [basedERC20, BRIDGE], {});

  return { factory };
});

export default BasedERC20FactoryModule;
