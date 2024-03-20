import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const CONTRACT_NAME = "BasedMigrateERC20";

const BasedMigrateERC20Module = buildModule("BasedMigrateERC20Module", (m) => {
  const basedERC20 = m.contract(CONTRACT_NAME, [], {});

  return { basedERC20 };
});

export default BasedMigrateERC20Module;
