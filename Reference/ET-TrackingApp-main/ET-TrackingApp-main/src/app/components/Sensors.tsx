import { useState } from "react";
import { MapPin, Activity, CheckCircle, AlertTriangle, Wifi, Thermometer, Droplets, Map, Battery, Info, Leaf, ScanLine, FileCheck } from "lucide-react";
import { motion } from "motion/react";
import { useRole } from "./RoleContext";

const sensors = [
  { id: "S-001", location: "Plot 1, Zone A", status: "Active", co2: "4.2", battery: "84%", temp: "26°C", humidity: "65%" },
  { id: "S-002", location: "Plot 2, Zone A", status: "Active", co2: "3.8", battery: "92%", temp: "25°C", humidity: "62%" },
  { id: "S-003", location: "Plot 1, Zone B", status: "Warning", co2: "1.2", battery: "15%", temp: "28°C", humidity: "55%" },
  { id: "S-004", location: "Plot 3, Zone C", status: "Active", co2: "5.1", battery: "78%", temp: "24°C", humidity: "70%" },
];

const scannedSensors = [
  { id: "S-004", location: "Plot 3, Zone C", scannedAt: "Today, 09:30 AM", validation: "Passed", owner: "Juan Dela Cruz" },
  { id: "S-001", location: "Plot 1, Zone A", scannedAt: "Yesterday, 14:15 PM", validation: "Passed", owner: "Maria Santos" },
  { id: "S-003", location: "Plot 1, Zone B", scannedAt: "Oct 12, 10:45 AM", validation: "Failed (Tampered)", owner: "Maria Santos" },
];

export default function Sensors() {
  const [view, setView] = useState<"list" | "map">("list");
  const { role } = useRole();

  if (role === "VERIFIER") {
    return (
      <div className="flex flex-col min-h-full p-4 space-y-6 pt-8 pb-24 bg-[#1B211A]">
        <header className="flex justify-between items-center mb-2">
          <div>
            <h1 className="text-2xl font-bold tracking-tight text-[#EBD5AB]">Scanned Sensors</h1>
            <p className="text-sm text-[#8BAE66] font-medium flex items-center">
              <ScanLine size={14} className="mr-1" /> History of Field Validations
            </p>
          </div>
          <div className="p-2 bg-[#2A3329] rounded-full text-[#8BAE66] hover:bg-[#628141] hover:text-[#1B211A] transition-colors shadow-md border border-[#628141]/30">
            <Map size={20} />
          </div>
        </header>

        <div className="space-y-4">
          <div className="bg-[#8BAE66]/10 border border-[#8BAE66]/30 text-[#8BAE66] p-3 rounded-xl flex items-start space-x-3 text-sm shadow-sm">
            <Info size={18} className="flex-shrink-0 mt-0.5" />
            <p className="font-medium leading-relaxed">You earn a commission for every physical sensor you validate on the field.</p>
          </div>

          <div className="flex justify-between items-center px-1">
            <h3 className="text-sm font-bold text-[#EBD5AB] uppercase tracking-wider">Validation History</h3>
            <span className="text-xs text-[#628141] font-semibold bg-[#2A3329] px-2 py-1 rounded-md border border-[#628141]/20">This Month</span>
          </div>

          {scannedSensors.map((sensor, index) => (
            <motion.div
              key={index}
              initial={{ opacity: 0, x: -10 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ delay: index * 0.1 }}
              className="bg-[#2A3329] rounded-2xl p-4 border border-[#628141]/30 shadow-md flex flex-col hover:border-[#8BAE66]/50 transition-colors group"
            >
              <div className="flex justify-between items-start mb-3">
                <div className="flex items-center space-x-3">
                  <div className={`w-10 h-10 rounded-full flex items-center justify-center shadow-inner ${sensor.validation === 'Passed' ? 'bg-[#8BAE66]/20 text-[#8BAE66]' : 'bg-red-400/20 text-red-400'}`}>
                    {sensor.validation === 'Passed' ? <FileCheck size={20} strokeWidth={2.5} /> : <AlertTriangle size={20} strokeWidth={2.5} />}
                  </div>
                  <div>
                    <h3 className="font-bold text-[#EBD5AB] text-lg">{sensor.id}</h3>
                    <p className="text-xs text-[#EBD5AB]/60 flex items-center font-medium mt-0.5">
                      <MapPin size={12} className="mr-1 text-[#628141]" /> {sensor.location}
                    </p>
                  </div>
                </div>
                <div className={`flex items-center space-x-1.5 px-2.5 py-1 rounded-full text-[10px] font-bold tracking-wide uppercase border shadow-sm ${
                  sensor.validation === 'Passed' ? 'bg-[#8BAE66]/10 text-[#8BAE66] border-[#8BAE66]/30' : 'bg-red-400/10 text-red-400 border-red-400/30'
                }`}>
                  {sensor.validation === 'Passed' ? <CheckCircle size={10} /> : <AlertTriangle size={10} />}
                  <span>{sensor.validation}</span>
                </div>
              </div>

              <div className="pt-3 border-t border-[#628141]/20 flex justify-between items-center text-sm">
                <span className="text-[#EBD5AB]/60 flex items-center"><Info size={14} className="mr-1.5 text-[#628141]" /> Owner: <strong className="ml-1 text-[#EBD5AB]">{sensor.owner}</strong></span>
                <span className="text-[#8BAE66] font-semibold text-xs">{sensor.scannedAt}</span>
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    );
  }

  return (
    <div className="flex flex-col min-h-full p-4 space-y-6 pt-8 pb-24 bg-[#1B211A]">
      <header className="flex justify-between items-center mb-2">
        <div>
          <h1 className="text-2xl font-bold tracking-tight text-[#EBD5AB]">My Sensors</h1>
          <p className="text-sm text-[#8BAE66] font-medium flex items-center">
            <Wifi size={14} className="mr-1" /> 14 Devices Online
          </p>
        </div>
        <div className="flex bg-[#2A3329] rounded-lg p-1 border border-[#628141]/30">
          <button 
            onClick={() => setView("list")}
            className={`p-1.5 rounded-md transition-all ${view === "list" ? "bg-[#628141] text-[#1B211A] shadow" : "text-[#8BAE66] hover:bg-[#8BAE66]/10"}`}
          >
            <Activity size={18} />
          </button>
          <button 
            onClick={() => setView("map")}
            className={`p-1.5 rounded-md transition-all ${view === "map" ? "bg-[#628141] text-[#1B211A] shadow" : "text-[#8BAE66] hover:bg-[#8BAE66]/10"}`}
          >
            <Map size={18} />
          </button>
        </div>
      </header>

      {view === "map" && (
        <motion.div 
          initial={{ opacity: 0, scale: 0.95 }}
          animate={{ opacity: 1, scale: 1 }}
          className="relative w-full h-80 rounded-2xl overflow-hidden border border-[#628141]/30 shadow-lg bg-[#2A3329] flex items-center justify-center group"
        >
          <div className="absolute inset-0 bg-[url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI0MCIgaGVpZ2h0PSI0MCI+PHBhdGggZD0iTTAgMGg0MHY0MEgwVjB6IiBmaWxsPSIjMkEzMzI5Ii8+PHBhdGggZD0iTTAgMGg0MHYxSDBWMHptMCAzOWg0MHYxSDB2LTF6TTAgMGgxdjQwSDBWMHptMzkgMGgxdjQwSDM5VjB6IiBmaWxsPSIjNjI4MTQxIiBmaWxsLW9wYWNpdHk9IjAuMSIvPjwvc3ZnPg==')] opacity-50 pointer-events-none"></div>
          
          <MapPin size={32} className="absolute text-[#8BAE66] animate-bounce z-10 top-1/3 left-1/4" />
          <MapPin size={24} className="absolute text-[#8BAE66] opacity-70 top-1/2 right-1/3" />
          <MapPin size={28} className="absolute text-[#8BAE66] opacity-90 bottom-1/4 left-1/3" />
          <MapPin size={24} className="absolute text-red-400 top-1/4 right-1/4" />
          
          <div className="absolute bottom-4 left-4 right-4 bg-[#1B211A]/80 backdrop-blur-md p-3 rounded-xl border border-[#628141]/30 text-xs text-[#EBD5AB] text-center font-medium shadow-xl">
            Bukidnon Forest Reserve - Sector 7
          </div>
        </motion.div>
      )}

      {view === "list" && (
        <div className="space-y-4">
          <div className="bg-[#8BAE66]/10 border border-[#8BAE66]/30 text-[#8BAE66] p-3 rounded-xl flex items-start space-x-3 text-sm shadow-sm">
            <Info size={18} className="flex-shrink-0 mt-0.5" />
            <p className="font-medium leading-relaxed">Sensors track CO₂ absorption, temperature, and humidity. Data is synced every hour.</p>
          </div>

          <div className="flex justify-between items-center px-1">
            <h3 className="text-sm font-bold text-[#EBD5AB] uppercase tracking-wider">Device List</h3>
            <span className="text-xs text-[#628141] font-semibold bg-[#2A3329] px-2 py-1 rounded-md border border-[#628141]/20">Sort by: Status</span>
          </div>

          {sensors.map((sensor, index) => (
            <motion.div
              key={sensor.id}
              initial={{ opacity: 0, x: -10 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ delay: index * 0.1 }}
              className="bg-[#2A3329] rounded-2xl p-4 border border-[#628141]/30 shadow-md flex flex-col hover:border-[#8BAE66]/50 transition-colors group"
            >
              <div className="flex justify-between items-start mb-3 border-b border-[#628141]/20 pb-3">
                <div className="flex items-center space-x-3">
                  <div className={`w-10 h-10 rounded-full flex items-center justify-center shadow-inner ${sensor.status === 'Active' ? 'bg-[#8BAE66]/20 text-[#8BAE66]' : 'bg-red-400/20 text-red-400'}`}>
                    <Activity size={20} strokeWidth={2.5} />
                  </div>
                  <div>
                    <h3 className="font-bold text-[#EBD5AB] text-lg">{sensor.id}</h3>
                    <p className="text-xs text-[#EBD5AB]/60 flex items-center font-medium mt-0.5">
                      <MapPin size={12} className="mr-1 text-[#628141]" /> {sensor.location}
                    </p>
                  </div>
                </div>
                <div className={`flex items-center space-x-1.5 px-2.5 py-1 rounded-full text-[10px] font-bold tracking-wide uppercase border shadow-sm ${
                  sensor.status === 'Active' ? 'bg-[#8BAE66]/10 text-[#8BAE66] border-[#8BAE66]/30' : 'bg-red-400/10 text-red-400 border-red-400/30'
                }`}>
                  {sensor.status === 'Active' ? <CheckCircle size={10} /> : <AlertTriangle size={10} />}
                  <span>{sensor.status}</span>
                </div>
              </div>

              <div className="grid grid-cols-4 gap-2 pt-1">
                <div className="flex flex-col items-center bg-[#1B211A] rounded-xl py-2 border border-[#628141]/20 group-hover:bg-[#628141]/10 transition-colors">
                  <Leaf size={14} className="text-[#8BAE66] mb-1" />
                  <span className="text-[#EBD5AB] font-bold text-sm">{sensor.co2}</span>
                  <span className="text-[9px] text-[#EBD5AB]/50 font-medium uppercase tracking-wider">kg/day</span>
                </div>
                <div className="flex flex-col items-center bg-[#1B211A] rounded-xl py-2 border border-[#628141]/20 group-hover:bg-[#628141]/10 transition-colors">
                  <Thermometer size={14} className="text-orange-400 mb-1" />
                  <span className="text-[#EBD5AB] font-bold text-sm">{sensor.temp}</span>
                  <span className="text-[9px] text-[#EBD5AB]/50 font-medium uppercase tracking-wider">Temp</span>
                </div>
                <div className="flex flex-col items-center bg-[#1B211A] rounded-xl py-2 border border-[#628141]/20 group-hover:bg-[#628141]/10 transition-colors">
                  <Droplets size={14} className="text-blue-400 mb-1" />
                  <span className="text-[#EBD5AB] font-bold text-sm">{sensor.humidity}</span>
                  <span className="text-[9px] text-[#EBD5AB]/50 font-medium uppercase tracking-wider">Humid</span>
                </div>
                <div className="flex flex-col items-center bg-[#1B211A] rounded-xl py-2 border border-[#628141]/20 group-hover:bg-[#628141]/10 transition-colors">
                  <Battery size={14} className={`${parseInt(sensor.battery) > 20 ? "text-[#8BAE66]" : "text-red-400"} mb-1`} />
                  <span className="text-[#EBD5AB] font-bold text-sm">{sensor.battery}</span>
                  <span className="text-[9px] text-[#EBD5AB]/50 font-medium uppercase tracking-wider">Batt</span>
                </div>
              </div>
            </motion.div>
          ))}
        </div>
      )}
    </div>
  );
}


