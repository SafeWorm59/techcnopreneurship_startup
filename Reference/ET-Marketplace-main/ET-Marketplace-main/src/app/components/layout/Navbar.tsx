import { Link, useLocation } from "react-router";
import { Leaf, Menu, X, Building, TreePine } from "lucide-react";
import { useState } from "react";
import clsx from "clsx";
import { useRole } from "../../context/RoleContext";

export function Navbar() {
  const [isOpen, setIsOpen] = useState(false);
  const location = useLocation();
  const { role, setRole } = useRole();

  const navigation = [
    { name: "Home", href: "/" },
    { name: "Marketplace", href: "/marketplace" },
    { name: "Dashboard", href: "/dashboard" },
  ];

  return (
    <nav className="bg-[#1B211A] text-[#EBD5AB] sticky top-0 z-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-20">
          <div className="flex items-center gap-2">
            <Link to="/" className="flex items-center gap-2 group">
              <div className="bg-[#628141] p-2 rounded-lg group-hover:bg-[#8BAE66] transition-colors">
                <Leaf className="w-6 h-6 text-[#1B211A]" />
              </div>
              <span className="font-bold text-xl tracking-tight">EchoTrace.</span>
            </Link>
          </div>
          
          <div className="hidden md:flex items-center gap-8">
            <div className="flex items-center bg-[#628141]/20 rounded-full p-1 border border-[#628141]/30">
              <button
                onClick={() => setRole("corporate")}
                className={clsx(
                  "flex items-center gap-2 px-4 py-1.5 rounded-full text-sm font-semibold transition-all duration-300",
                  role === "corporate" ? "bg-[#628141] text-[#EBD5AB] shadow-md" : "text-[#8BAE66] hover:text-[#EBD5AB]"
                )}
              >
                <Building className="w-4 h-4" />
                Buyer
              </button>
              <button
                onClick={() => setRole("landowner")}
                className={clsx(
                  "flex items-center gap-2 px-4 py-1.5 rounded-full text-sm font-semibold transition-all duration-300",
                  role === "landowner" ? "bg-[#628141] text-[#EBD5AB] shadow-md" : "text-[#8BAE66] hover:text-[#EBD5AB]"
                )}
              >
                <TreePine className="w-4 h-4" />
                Landowner
              </button>
            </div>

            <div className="flex items-baseline space-x-8">
              {navigation.map((item) => {
                const isActive = location.pathname === item.href;
                return (
                  <Link
                    key={item.name}
                    to={item.href}
                    className={clsx(
                      "px-3 py-2 rounded-md text-sm font-medium transition-colors",
                      isActive
                        ? "bg-[#628141] text-[#EBD5AB]"
                        : "text-[#EBD5AB] hover:bg-[#8BAE66]/20 hover:text-white"
                    )}
                  >
                    {item.name}
                  </Link>
                );
              })}
              <Link
                to="/dashboard"
                className="bg-[#EBD5AB] text-[#1B211A] px-5 py-2.5 rounded-full text-sm font-bold hover:bg-white transition-colors"
              >
                Connect Wallet
              </Link>
            </div>
          </div>
          <div className="-mr-2 flex md:hidden">
            <button
              onClick={() => setIsOpen(!isOpen)}
              type="button"
              className="inline-flex items-center justify-center p-2 rounded-md text-[#EBD5AB] hover:text-white hover:bg-[#628141] focus:outline-none"
            >
              <span className="sr-only">Open main menu</span>
              {isOpen ? <X className="block h-6 w-6" /> : <Menu className="block h-6 w-6" />}
            </button>
          </div>
        </div>
      </div>

      {/* Mobile menu */}
      {isOpen && (
        <div className="md:hidden bg-[#1B211A] border-t border-[#628141]/20">
          <div className="px-4 py-4 border-b border-[#628141]/20">
            <div className="flex bg-[#628141]/20 rounded-full p-1 border border-[#628141]/30">
              <button
                onClick={() => setRole("corporate")}
                className={clsx(
                  "flex-1 flex items-center justify-center gap-2 px-4 py-2 rounded-full text-sm font-semibold transition-all duration-300",
                  role === "corporate" ? "bg-[#628141] text-[#EBD5AB] shadow-md" : "text-[#8BAE66] hover:text-[#EBD5AB]"
                )}
              >
                <Building className="w-4 h-4" />
                Buyer
              </button>
              <button
                onClick={() => setRole("landowner")}
                className={clsx(
                  "flex-1 flex items-center justify-center gap-2 px-4 py-2 rounded-full text-sm font-semibold transition-all duration-300",
                  role === "landowner" ? "bg-[#628141] text-[#EBD5AB] shadow-md" : "text-[#8BAE66] hover:text-[#EBD5AB]"
                )}
              >
                <TreePine className="w-4 h-4" />
                Landowner
              </button>
            </div>
          </div>
          <div className="px-2 pt-2 pb-3 space-y-1 sm:px-3">
            {navigation.map((item) => (
              <Link
                key={item.name}
                to={item.href}
                onClick={() => setIsOpen(false)}
                className={clsx(
                  "block px-3 py-2 rounded-md text-base font-medium",
                  location.pathname === item.href
                    ? "bg-[#628141] text-[#EBD5AB]"
                    : "text-[#EBD5AB] hover:bg-[#8BAE66]/20 hover:text-white"
                )}
              >
                {item.name}
              </Link>
            ))}
            <Link
              to="/dashboard"
              onClick={() => setIsOpen(false)}
              className="block mt-4 text-center bg-[#EBD5AB] text-[#1B211A] px-5 py-3 rounded-full text-base font-bold hover:bg-white transition-colors"
            >
              Connect Wallet
            </Link>
          </div>
        </div>
      )}
    </nav>
  );
}
