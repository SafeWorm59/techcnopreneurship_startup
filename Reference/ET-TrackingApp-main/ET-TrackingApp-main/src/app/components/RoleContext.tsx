import { createContext, useContext, useState, ReactNode } from "react";

type Role = "LAND_OWNER" | "VERIFIER";

interface RoleContextType {
  role: Role;
  toggleRole: () => void;
}

const RoleContext = createContext<RoleContextType | undefined>(undefined);

export function RoleProvider({ children }: { children: ReactNode }) {
  const [role, setRole] = useState<Role>("LAND_OWNER");

  const toggleRole = () => {
    setRole((prev) => (prev === "LAND_OWNER" ? "VERIFIER" : "LAND_OWNER"));
  };

  return (
    <RoleContext.Provider value={{ role, toggleRole }}>
      {children}
    </RoleContext.Provider>
  );
}

export function useRole() {
  const context = useContext(RoleContext);
  if (!context) {
    throw new Error("useRole must be used within a RoleProvider");
  }
  return context;
}
