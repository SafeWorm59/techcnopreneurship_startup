import { useState } from "react";
import { Search, Filter, ShieldCheck, ArrowRight, TrendingUp, Tag, Box, Info, Plus } from "lucide-react";
import { motion } from "motion/react";
import { useRole } from "./RoleContext";

const marketplaceItems = [
  { id: 1, name: "Bukidnon Forest Reserve - Alpha", price: 15.50, amount: 500, verified: true, type: "Reforestation", return: "+4.2%" },
  { id: 2, name: "Mt. Kitanglad Buffer Zone", price: 18.25, amount: 1200, verified: true, type: "Conservation", return: "+6.1%" },
  { id: 3, name: "Malaybalay Agroforestry Project", price: 12.00, amount: 350, verified: false, type: "Agroforestry", return: "+2.8%" },
  { id: 4, name: "Valencia Watershed Protection", price: 22.00, amount: 800, verified: true, type: "Conservation", return: "+8.4%" },
];

export default function Marketplace() {
  const [activeFilter, setActiveFilter] = useState("All");
  const { role } = useRole();

  return (
    <div className="flex flex-col min-h-full p-4 space-y-6 pt-8 pb-24 bg-[#1B211A]">
      <header className="flex justify-between items-center mb-4">
        <div>
          <h1 className="text-2xl font-bold tracking-tight text-[#EBD5AB]">
            {role === "LAND_OWNER" ? "My Carbon Assets" : "Carbon Market"}
          </h1>
          <p className="text-sm text-[#8BAE66] font-medium">
            {role === "LAND_OWNER" ? "Manage and sell your credits" : "Invest in verified local credits"}
          </p>
        </div>
        <button className="p-2 bg-[#2A3329] rounded-full text-[#EBD5AB] hover:bg-[#628141] hover:text-[#1B211A] transition-colors shadow-md border border-[#628141]/30">
          <Info size={20} />
        </button>
      </header>

      {role === "LAND_OWNER" && (
        <button className="w-full py-3.5 bg-[#8BAE66] hover:bg-[#628141] text-[#1B211A] font-bold rounded-2xl flex items-center justify-center transition-colors shadow-lg shadow-[#8BAE66]/20 mb-2 border border-[#8BAE66]/50">
          <Plus size={20} className="mr-2" /> List New Credits for Sale
        </button>
      )}

      <div className="flex space-x-2">
        <div className="relative flex-1">
          <Search size={18} className="absolute left-3 top-1/2 -translate-y-1/2 text-[#628141]" />
          <input 
            type="text" 
            placeholder="Search projects..." 
            className="w-full bg-[#2A3329] text-[#EBD5AB] placeholder-[#628141] rounded-2xl py-3 pl-10 pr-4 outline-none border border-[#628141]/30 focus:border-[#8BAE66] focus:ring-1 focus:ring-[#8BAE66] transition-all shadow-inner"
          />
        </div>
        <button className="bg-[#2A3329] p-3 rounded-2xl text-[#8BAE66] border border-[#628141]/30 shadow-sm flex items-center justify-center">
          <Filter size={20} />
        </button>
      </div>

      <div className="flex space-x-2 overflow-x-auto pb-2 scrollbar-hide">
        {["All", "Verified", "High Yield", "Local"].map((filter) => (
          <button
            key={filter}
            onClick={() => setActiveFilter(filter)}
            className={`px-4 py-1.5 rounded-full text-sm font-semibold whitespace-nowrap transition-all border shadow-sm ${
              activeFilter === filter
                ? "bg-[#8BAE66] text-[#1B211A] border-[#8BAE66]"
                : "bg-[#2A3329] text-[#EBD5AB]/70 border-[#628141]/30 hover:border-[#8BAE66]/50 hover:text-[#EBD5AB]"
            }`}
          >
            {filter}
          </button>
        ))}
      </div>

      <div className="flex justify-between items-center bg-[#2A3329]/50 rounded-xl p-3 border border-[#628141]/20">
        <div className="flex items-center space-x-2 text-sm">
          <TrendingUp size={16} className="text-[#8BAE66]" />
          <span className="text-[#EBD5AB]/80 font-medium">Avg Market Price: <strong className="text-[#EBD5AB]">$16.80/tCO₂</strong></span>
        </div>
      </div>

      <div className="space-y-4">
        {marketplaceItems.map((item, index) => (
          <motion.div
            key={item.id}
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: index * 0.1 }}
            className="bg-[#2A3329] rounded-2xl p-5 border border-[#628141]/30 shadow-md flex flex-col relative overflow-hidden group hover:border-[#8BAE66]/50 transition-colors"
          >
            <div className="absolute top-0 left-0 w-1 h-full bg-[#8BAE66] opacity-0 group-hover:opacity-100 transition-opacity"></div>
            <div className="flex justify-between items-start mb-3">
              <div>
                <h3 className="font-bold text-[#EBD5AB] text-base leading-tight w-4/5">{item.name}</h3>
                <div className="flex items-center space-x-2 mt-1.5">
                  <span className="text-xs bg-[#628141]/20 text-[#8BAE66] px-2 py-0.5 rounded-md font-medium">{item.type}</span>
                  {item.verified && (
                    <span className="flex items-center text-[10px] text-[#1B211A] font-bold bg-[#EBD5AB] px-1.5 py-0.5 rounded uppercase tracking-wider">
                      <ShieldCheck size={10} className="mr-1" /> Verified
                    </span>
                  )}
                </div>
              </div>
              <div className="text-right">
                <span className="text-xl font-black text-[#8BAE66]">${item.price.toFixed(2)}</span>
                <span className="text-xs text-[#EBD5AB]/60 block font-medium">/ tCO₂e</span>
              </div>
            </div>
            
            <div className="flex justify-between items-center mt-2 pt-3 border-t border-[#628141]/20">
              <div className="flex flex-col space-y-1">
                <span className="text-xs text-[#EBD5AB]/60 flex items-center font-medium"><Box size={12} className="mr-1 text-[#628141]" /> Available Volume</span>
                <span className="text-sm font-semibold text-[#EBD5AB]">{item.amount} tons</span>
              </div>
              <div className="flex flex-col space-y-1 items-end">
                <span className="text-xs text-[#EBD5AB]/60 flex items-center font-medium"><Tag size={12} className="mr-1 text-[#628141]" /> Est. Yield</span>
                <span className="text-sm font-semibold text-green-400">{item.return}</span>
              </div>
            </div>

            {role === "LAND_OWNER" ? (
              <div className="grid grid-cols-2 gap-2 mt-4">
                <button className="py-2.5 bg-[#2A3329] hover:bg-[#628141]/30 text-[#EBD5AB] font-bold rounded-xl border border-[#628141]/50 flex items-center justify-center transition-colors shadow-sm">
                  Adjust Price
                </button>
                <button className="py-2.5 bg-[#8BAE66] hover:bg-[#628141] text-[#1B211A] font-bold rounded-xl flex items-center justify-center transition-colors shadow-sm">
                  Sell More
                </button>
              </div>
            ) : (
              <button className={`w-full mt-4 py-2.5 font-bold rounded-xl flex items-center justify-center transition-colors shadow-sm ${item.verified ? "bg-[#2A3329] border border-[#628141]/50 text-[#8BAE66]" : "bg-[#EBD5AB] text-[#1B211A]"}`}>
                {item.verified ? "View Validation Report" : "Verify This Project"} <ArrowRight size={16} className="ml-2" />
              </button>
            )}
          </motion.div>
        ))}
      </div>
    </div>
  );
}
