import { Outlet, useLocation, Link } from "react-router";
import { Home, ShoppingCart, Activity, Wallet } from "lucide-react";
import { useRole } from "./RoleContext";

export default function Layout() {
  const location = useLocation();
  const { role, toggleRole } = useRole();

  const allNavItems = [
    { path: "/", label: "Home", icon: Home, roles: ["LAND_OWNER", "VERIFIER"] },
    { path: "/marketplace", label: "Market", icon: ShoppingCart, roles: ["LAND_OWNER"] },
    { path: "/sensors", label: "Sensors", icon: Activity, roles: ["LAND_OWNER", "VERIFIER"] },
    { path: "/wallet", label: "Wallet", icon: Wallet, roles: ["LAND_OWNER", "VERIFIER"] },
  ];

  const navItems = allNavItems.filter((item) => item.roles.includes(role));

  return (
    <div className="flex flex-col h-screen w-full max-w-md mx-auto bg-[#1B211A] text-[#EBD5AB] relative overflow-hidden font-sans">
      <div className="flex justify-center items-center py-2 bg-[#242A22] border-b border-[#628141]/30 text-xs font-semibold space-x-3 z-50 shadow-sm">
        <span className={role === "LAND_OWNER" ? "text-[#8BAE66]" : "text-[#EBD5AB]/50"}>Land Owner</span>
        <button onClick={toggleRole} className="w-12 h-6 bg-[#1B211A] border border-[#628141]/50 rounded-full relative shadow-inner flex items-center p-1 cursor-pointer transition-colors">
          <div className={`w-4 h-4 rounded-full bg-[#8BAE66] shadow-sm transform transition-transform duration-300 ease-in-out ${role === "VERIFIER" ? "translate-x-6 bg-[#EBD5AB]" : "translate-x-0"}`} />
        </button>
        <span className={role === "VERIFIER" ? "text-[#EBD5AB]" : "text-[#EBD5AB]/50"}>Verifier (NGO/LGU)</span>
      </div>

      <main className="flex-1 overflow-y-auto overflow-x-hidden pb-20 scrollbar-hide">
        <Outlet />
      </main>

      <nav className="absolute bottom-0 w-full bg-[#242A22] border-t border-[#628141]/30 pb-safe">
        <div className="flex justify-around items-center h-16 px-2">
          {navItems.map((item) => {
            const Icon = item.icon;
            const isActive = location.pathname === item.path;
            return (
              <Link
                key={item.path}
                to={item.path}
                className={`flex flex-col items-center justify-center w-full h-full space-y-1 transition-colors ${
                  isActive ? "text-[#8BAE66]" : "text-[#628141] hover:text-[#8BAE66]/80"
                }`}
              >
                <Icon size={22} strokeWidth={isActive ? 2.5 : 2} className={isActive ? "animate-pulse" : ""} />
                <span className="text-[10px] font-medium tracking-wide">
                  {item.label}
                </span>
              </Link>
            );
          })}
        </div>
      </nav>
    </div>
  );
}
