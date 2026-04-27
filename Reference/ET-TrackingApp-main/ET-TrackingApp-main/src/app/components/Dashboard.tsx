import { motion } from "motion/react";
import { AreaChart, Area, XAxis, YAxis, Tooltip, ResponsiveContainer } from "recharts";
import { Bell, Leaf, TreeDeciduous, ArrowUpRight, ShieldCheck, QrCode, FileCheck } from "lucide-react";
import { Link } from "react-router";
import { useRole } from "./RoleContext";

const data = [
  { name: "Mon", co2: 12 },
  { name: "Tue", co2: 15 },
  { name: "Wed", co2: 13 },
  { name: "Thu", co2: 18 },
  { name: "Fri", co2: 24 },
  { name: "Sat", co2: 22 },
  { name: "Sun", co2: 28 },
];

export default function Dashboard() {
  const { role } = useRole();

  return (
    <div className="flex flex-col min-h-full p-4 space-y-6 pt-8 pb-24">
      <header className="flex justify-between items-center mb-2">
        <div className="flex items-center space-x-3">
          <div className="w-10 h-10 rounded-full bg-[#628141] flex items-center justify-center text-[#1B211A] font-bold text-lg shadow-inner">
            <TreeDeciduous size={24} />
          </div>
          <div>
            <h1 className="text-xl font-bold tracking-tight text-[#EBD5AB]">EcoTrace</h1>
            <p className="text-xs text-[#8BAE66] font-medium flex items-center">
              <ShieldCheck size={12} className="mr-1" /> {role === "LAND_OWNER" ? "Bukidnon Certified" : "Verifier Portal"}
            </p>
          </div>
        </div>
        <button className="relative p-2 bg-[#2A3329] rounded-full text-[#8BAE66] hover:bg-[#628141] hover:text-[#1B211A] transition-colors shadow-md">
          <Bell size={20} />
          <span className="absolute top-1 right-1 w-2.5 h-2.5 bg-red-500 rounded-full border-2 border-[#2A3329]"></span>
        </button>
      </header>

      {role === "VERIFIER" ? (
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="bg-[#2A3329] rounded-3xl p-6 shadow-xl border border-[#8BAE66]/50 relative overflow-hidden flex flex-col items-center text-center space-y-4"
        >
          <div className="w-20 h-20 bg-[#628141]/20 rounded-full flex items-center justify-center text-[#8BAE66] mb-2">
            <QrCode size={40} />
          </div>
          <h2 className="text-xl font-bold text-[#EBD5AB]">Scan Landowner QR</h2>
          <p className="text-sm text-[#EBD5AB]/70">Use this to validate physical IoT sensors and carbon absorption on the field.</p>
          <button className="w-full py-3.5 bg-[#8BAE66] hover:bg-[#628141] text-[#1B211A] font-bold rounded-2xl flex items-center justify-center transition-colors shadow-lg mt-4">
            <QrCode size={20} className="mr-2" /> Open Scanner
          </button>
        </motion.div>
      ) : (
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="bg-gradient-to-br from-[#2A3329] to-[#1B211A] rounded-3xl p-6 shadow-xl border border-[#628141]/30 relative overflow-hidden"
        >
          <div className="absolute top-0 right-0 -mr-8 -mt-8 w-32 h-32 bg-[#8BAE66]/10 rounded-full blur-3xl"></div>
          <h2 className="text-[#EBD5AB]/70 text-sm font-semibold mb-1 uppercase tracking-wider">Total CO₂ Absorbed</h2>
          <div className="flex items-end justify-between">
            <div className="flex items-baseline space-x-2">
              <span className="text-5xl font-black text-[#8BAE66] tracking-tighter">482</span>
              <span className="text-[#EBD5AB]/60 text-lg font-medium">kg</span>
            </div>
            <div className="flex items-center text-sm font-medium text-green-400 bg-green-400/10 px-2.5 py-1 rounded-full border border-green-400/20">
              <ArrowUpRight size={14} className="mr-1" /> 12%
            </div>
          </div>
          <div className="mt-4 pt-4 border-t border-[#628141]/30 flex justify-between items-center text-sm">
            <span className="text-[#EBD5AB]/60 flex items-center"><Leaf size={14} className="mr-1.5 text-[#628141]" /> Eqv. 12 cars off road</span>
            <Link to="/wallet" className="text-[#8BAE66] font-semibold flex items-center hover:underline">
              Redeem <ArrowUpRight size={14} className="ml-1" />
            </Link>
          </div>
        </motion.div>
      )}

      {role === "VERIFIER" ? (
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="space-y-4"
        >
          <h3 className="text-lg font-bold text-[#EBD5AB] mb-2">Recent Validations</h3>
          <div className="space-y-3">
            {[1, 2, 3].map((i) => (
              <div key={i} className="bg-[#2A3329] p-4 rounded-2xl border border-[#628141]/30 flex justify-between items-center shadow-md">
                <div className="flex items-center space-x-3">
                  <div className="w-10 h-10 rounded-full bg-[#628141]/20 text-[#8BAE66] flex items-center justify-center">
                    <FileCheck size={20} />
                  </div>
                  <div>
                    <h4 className="font-bold text-[#EBD5AB]">Plot #{2400 + i}</h4>
                    <p className="text-xs text-[#EBD5AB]/60">Verified {i * 2} days ago</p>
                  </div>
                </div>
                <span className="text-xs font-bold text-[#1B211A] bg-[#8BAE66] px-2 py-1 rounded-md">Valid</span>
              </div>
            ))}
          </div>
        </motion.div>
      ) : (
        <>
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.1 }}
          >
            <div className="flex justify-between items-center mb-4">
              <h3 className="text-lg font-bold text-[#EBD5AB]">7-Day Tracking</h3>
              <span className="text-xs text-[#628141] font-medium bg-[#628141]/10 px-2 py-1 rounded-md">Live Data</span>
            </div>
            <div className="bg-[#2A3329]/50 rounded-2xl p-4 h-56 border border-[#628141]/20 shadow-inner">
              <ResponsiveContainer width="100%" height="100%" minWidth={1} minHeight={1}>
                <AreaChart id="dashboard-chart" data={data} margin={{ top: 10, right: 0, left: -20, bottom: 0 }}>
                  <defs>
                    <linearGradient id="colorCo2" x1="0" y1="0" x2="0" y2="1">
                      <stop key="start" offset="5%" stopColor="#8BAE66" stopOpacity={0.8}/>
                      <stop key="end" offset="95%" stopColor="#8BAE66" stopOpacity={0}/>
                    </linearGradient>
                  </defs>
                  <XAxis dataKey="name" stroke="#628141" fontSize={12} tickLine={false} axisLine={false} />
                  <YAxis stroke="#628141" fontSize={12} tickLine={false} axisLine={false} tickFormatter={(value) => `${value}k`} />
                  <Tooltip 
                    contentStyle={{ backgroundColor: '#1B211A', borderColor: '#628141', borderRadius: '12px', color: '#EBD5AB' }}
                    itemStyle={{ color: '#8BAE66', fontWeight: 'bold' }}
                  />
                  <Area type="monotone" dataKey="co2" stroke="#8BAE66" strokeWidth={3} fillOpacity={1} fill="url(#colorCo2)" />
                </AreaChart>
              </ResponsiveContainer>
            </div>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.2 }}
            className="space-y-4"
          >
            <h3 className="text-lg font-bold text-[#EBD5AB] mb-2">My Forest Network</h3>
            <div className="grid grid-cols-2 gap-4">
              <div className="bg-[#2A3329] p-4 rounded-2xl border border-[#628141]/30 shadow-md">
                <div className="w-8 h-8 rounded-full bg-[#628141]/20 text-[#8BAE66] flex items-center justify-center mb-3">
                  <TreeDeciduous size={16} />
                </div>
                <h4 className="text-2xl font-bold text-[#EBD5AB]">14</h4>
                <p className="text-xs text-[#EBD5AB]/60 mt-1 font-medium">Active Sensors</p>
              </div>
              <div className="bg-[#2A3329] p-4 rounded-2xl border border-[#628141]/30 shadow-md">
                <div className="w-8 h-8 rounded-full bg-[#EBD5AB]/10 text-[#EBD5AB] flex items-center justify-center mb-3">
                  <ShieldCheck size={16} />
                </div>
                <h4 className="text-2xl font-bold text-[#EBD5AB]">100%</h4>
                <p className="text-xs text-[#EBD5AB]/60 mt-1 font-medium">Verification Status</p>
              </div>
            </div>
          </motion.div>
        </>
      )}
    </div>
  );
}
